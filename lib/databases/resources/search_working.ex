defmodule Databases.Resource.SearchWorking do
  import Ecto.Query
  @elastic_url "http://localhost:9200"
  @query_limit 20
  @default_language "en"

  def index_all(data, lang) do
    IO.inspect("INDEX ALL")
    Elastix.Index.create(@elastic_url, "db", %{})
    data
    |> Enum.map(fn item -> Elastix.Document.index(@elastic_url, "db", lang, item.id, item) end)
  end

  def base(term \\ "*") do
    IO.inspect(term, label: "TERM in BASE")
    %{
      
      query: %{
        bool: %{
          must: [
            %{
                query_string: %{
                  query: term <> "*",
                  fields: ["title", "description", "topics.name"]
              } 
            } 
          ]
        }
      }
    }
  end

  def search(%{} = payload) when not is_map_key(payload, "search") do
    IO.inspect("SEARCH KEY MISSING")
    search(Map.put(payload, "search", "*")) 
  end



  def search(%{"search" => _} = payload) when not is_map_key(payload, "lang") do
    IO.inspect("LANG MAP KEY MISSING")

    search(Map.put(payload, "lang", @default_language)) 
  end
  #def search(%{} = payload), do: do_search(Map.merge(%{"search" => Map.get(payload, "search", "*")}, payload))
  def search(%{"search" => nil} = payload) when is_map_key(payload, "search") do
    IO.inspect("Search is NIL")
    search(Map.put(payload, "search", "*"))
  end

  def search(%{"lang" => nil} = payload) do
    IO.inspect("Lang is NIL")
    search(Map.put(payload, "lang", "sv"))
  end

  def search(%{"lang" => lang, "search" => search} = payload) do
    IO.inspect("Lang and Search present")
    lang = Map.get(payload, "lang")
    term = Map.get(payload, "search")
    sort_order = payload["sortOrder"]
    payload
    |> Map.delete("lang")
    |> Map.delete("search")
    |> Map.delete("sortOrder")
    |> remap_payload
    |> build_filter
    |> search(term, lang, sort_order)
  end

  def has_filter([]), do: nil
  def has_filter(list), do: list    
  
  # TODO: when fixed in frontend, change to correct parameter names
  def remap_payload(%{} = payload) do
    %{
      "topics.id"             => payload["topics"],
      "topics.sub_topics.id"  => payload["sub_topics"],
      "media_type.id"         => payload["mediatype"],
      "public_access"         => payload["show_free"] || false
    }
  end
  
  def search(filter, term, lang, sort_order) do
    IO.inspect(term, label: "term in search")
    q = base(term)
    q = add_filter(filter, q)
    IO.inspect(q, label: "q")
    Elastix.Search.search(@elastic_url, "db", [lang], q)
    #|> IO.inspect
    |> elem(1)
    |> Map.get(:body)
    |> get_in(["hits", "hits"])
    |> Enum.map(fn item -> Map.get(item, "_source") end)
    #|> IO.inspect(label: "QUERY RESULT")
    |> remap
    |> Jason.encode!
    #|> IO.inspect
  end

  def remap(res) do
    %{
       _meta: %{total: 123, found: 2},
       data: res,
       filters:
        %{mediatypes:
        [
          %{
            id: 1,
            name: "Media type 1"
          }
        ],
        topics:
        [
          %{
            id: 1,
            name: "Economy",
            sub_topics: [
              %{
                id: 2,
                name: "Sub topic"
              }
            ]
          }
        ]
      }
     }
   #a = Jason.encode!(a)
   #IO.inspect(res, label: "RESULT")
   #res
 end

  def add_filter(nil, q), do: q 
  def add_filter([], q), do: q 

  def add_filter(filter, q) do
    bool = q.query.bool
    bool = Map.put(bool, :filter, filter)
    q = put_in(q, [:query, :bool], bool)
  end
  
  def build_filter(payload) do
    filter = payload
    # clear payload of nil values and empty lists
    |> Enum.filter(fn ({_, v}) -> !is_nil(v) || (is_list(v) &&  Enum.count(v) < 1) end)
    |> Map.new
    |> Enum.map(fn ({k, v}) -> format_filter_item({k, v}) end)
    |> List.flatten
    |> has_filter
  end
  # when filter item is a list, split list into seperate items
  def format_filter_item({k, v} = item) when is_list(v) do
    v
    |> Enum.map(fn val -> %{match: %{k => val}} end)
  end

  def format_filter_item({k, v} = item) do
    %{match: %{k => v}}
  end
  def s do
    q = %{
      
      query: %{
        bool: %{
          must: [
            %{
                query_string: %{
                  query: "Data" <> "*",
                  fields: ["title^3", "description^1", "topics.name^2"]
              } 
            } 
          ]
        }
      }
    }
    Elastix.Search.search(@elastic_url, "db", ["en"], q)
  end
end