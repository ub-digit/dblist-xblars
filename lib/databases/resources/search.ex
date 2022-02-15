defmodule Databases.Resource.Search do
  import Ecto.Query
  import Ecto
  @elastic_url "http://localhost:9200"
  @query_limit 500
  @default_language "en"
  @index_prefix "db_"

  def index_all(data, lang) do
    index_name = get_index(lang) 
    create_index(Elastix.Index.exists?(@elastic_url, index_name), index_name)
    IO.inspect(lang, label: "INDEX ALL")
    uuid = Ecto.UUID.generate()
    Enum.map(data, fn item -> Elastix.Document.index(@elastic_url, index_name, "_doc", item.id, item) end)
  end

  def get_index(lang) do
    @index_prefix <> lang
  end

  def create_index({:error, _}, _n), do: nil #TODO: Handle error
  def create_index({:ok, true}, _n), do: nil
  def create_index({:ok, false}, index_name) do
    IO.inspect("Creating Index")
    Elastix.Index.create(@elastic_url, index_name, %{})
  end

  def show(%{"id" => id} = payload) do
    search(payload)
    |> Map.get(:data)
    |> Enum.fetch(0)
    |> elem(1)
  end

  def popular_databases(lang \\ @default_language) do
    search(%{"is_popular" => true, "lang" => lang})
    |> Map.get(:data)
    #|> IO.inspect(label: "ispopular")
  end

  def base(term \\ "*") do
    %{
      size: @query_limit,
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

  def get_total_documents(lang) do
    Elastix.Search.count(@elastic_url, get_index(lang), ["_doc"], %{})
    |> elem(1)
    |> Map.get(:body)
    |> Map.get("count")
  end
  
  def search(%{} = payload \\ %{}) when not is_map_key(payload, :params)do
    payload
    |> remap_payload
    |> search
  end
  
  def search(%{params: params, filter: filter} = payload)  do
    lang = params["lang"]
    filter = filter
    |> build_filter
    q = base(params["search"])
    q = add_filter(filter, q)
    IO.inspect(q, label: "q")
    Elastix.Search.search(@elastic_url, get_index(lang), ["_doc"], q)
    |> elem(1)
    #|> IO.inspect
    |> Map.get(:body)
    |> get_in(["hits", "hits"])
    |> Enum.map(fn item -> Map.get(item, "_source") end)
    |> sort_result(params["sort_order"])
    |> remap(get_total_documents(lang))
    
  end

  def sort_result(dbs, "asc") do
    IO.inspect("Sort order asc")
    dbs
    |> Enum.sort_by(fn db -> db["title"] end)
  end

  def sort_result(dbs, "desc") do
    IO.inspect("Sort order desc")
    dbs
    |> Enum.sort_by(fn db -> db["title"] end)
    |> Enum.reverse
  end

  def remap_payload(%{} = payload) do
    #IO.inspect(payload, label: "payload in remap payload")
    %{
      params: %{
        "search"                => payload["search"] || "",
        "lang"                  => payload["lang"] || @default_language,
        "sort_order"            => payload["sort_order"] || "asc"
      },
      filter: %{
        "id"                    => payload["id"],
        "topics.id"             => payload["topic"],
        "topics.sub_topics.id"  => payload["sub_topics"],
        "media_type.id"         => payload["mediatype"],
        "public_access"         => payload["show_free"] || nil,
        "is_popular"            => payload["is_popular"]
      }
    }

  end

  def has_filter([]), do: nil
  def has_filter(list), do: list    

  def remap(res, total_docs) do
    %{
      _meta: %{total: total_docs, found: length(res)},
      data: res,
      filters:
        %{
          mediatypes: get_media_types(res),
          topics: get_topics(res)
        }
     }
  end

  def get_topics(databases) do 
    databases
    |> IO.inspect(label: "Res")
    |> Enum.map(fn db -> db["topics"] end)
    |> List.flatten
    |> Enum.uniq
  end

  def get_media_types(databases) do
    databases
    |> Enum.map(fn db -> db["media_types"] end)
    |> List.flatten
    |> Enum.uniq
  end

  def add_filter(nil, q), do: q 
  def add_filter([], q), do: q 

  def add_filter(filter, q) do
    bool = q.query.bool
    bool = Map.put(bool, :filter, filter)
    put_in(q, [:query, :bool], bool)
  end
  
  def build_filter(filter) do
    filter
    # clear filter of nil values and empty lists
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

  def b() do
    q = %{
      query: %{
        bool: %{
          must: [
            %{
                query_string: %{
                  query: "*",
                  fields: ["title", "description", "topics.name"]
              } 
            } 
          ],
          filter: [
            %{
              match: %{
                "public_access" => true
              }
            }
          ]
        }
      }
     }
    Elastix.Search.search(@elastic_url, get_index("en"), ["_doc"], q)
    |> elem(1)
    |> IO.inspect
    |> Map.get(:body)
    |> get_in(["hits", "hits"])
    #|> Enum.map(fn item -> Map.get(item. "title") end)
  end
end

