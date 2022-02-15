defmodule Databases.Resource.SearchXXX do
  alias Databases.Model
  alias Databases.Repo
  import Ecto.Query
  @elastic_url "http://localhost:9200"
  @query_limit 20

  def search_db_by_title(title, lang) do
      Databases.Resource.Database.list_databases_with_lang(lang)
      |> Enum.filter(fn db -> String.contains?(db.title, title) end)
      |> Enum.sort_by(fn item -> item.title end)
  end

  def index_all(data, lang) do
    IO.inspect("INDEX ALL")
    Elastix.Index.create("http://localhost:9200", "db", %{})
    data
    Enum.map(data, fn item -> Elastix.Document.index("http://localhost:9200", "db", lang, item.id, item) end)
  end

  def list_databases(params) do
    IO.inspect("LIST DATABASES IN SEARCH")
    IO.inspect(params, label: "Params")
    ""
  end

  # ------- TEST -------
  def lasso(payload) do
    lang = Map.get(payload, "lang")
    term = Map.get(payload, "search")
    test_search(term, lang)
    
  end

  # -------- Rtsdfsd -------

  def show_params(params \\ NULL ) do
    IO.inspect(params, label: "Params in search")
  end


  def query(term \\ "*") do
    IO.inspect(term, label: "term in query")
    %{
      query: %{
        bool: %{
          must: [
            %{
                query_string: %{
                  query: term,
                  fields: ["title", "description", "topics.name"]
              } 
            } 
          ]
        }
      }
    }
  end
  def test_search(nil, lang), do: test_search("*", lang)
  def test_search("", lang), do: test_search("*", lang)

  def test_search(term, lang) do
    base = query(term)
    bool = base.query.bool
    bool = Map.put(bool, :filter, [%{match: %{"topics.id" => 3}}])
    q = put_in(base, [:query, :bool], bool)
    #IO.inspect(q, label: "query ")
    #q = base
    Elastix.Search.search(@elastic_url, "db", [lang], q)
    |> elem(1)
    |> Map.get(:body)
    |> get_in(["hits", "hits"])
    |> Enum.map(&remap/1)
    |> Jason.encode!
  end
"""
  def query_tmp(term, lang) do
    q = %{
      query: %{
        bool: %{
          must: [
            %{
                query_string: %{
                  query: term,
                  fields: ["title", "description", "topics.name"]
              } 
            } 
          ],
          filter: [
            %{
              match: %{
                "topics.id" => 2
              }
            }
          ]
        }
      }
    }

    Elastix.Search.search(@elastic_url, "db", [lang], q)
    |> elem(1)
    |> Map.get(:body)
    #|> Enum.map(&remap/1)
  end
  """
  def remap(db) do
    db
    |> Map.get("_source")
  end

  #payload=%7B%22topicsfirstlevel%22:null,%22topicsSecondLevel%22:[],%22mediatype%22:null,%22show_free%22:false,%22sortOrder%22:%22asc%22,%22search%22:null,%22lang%22:%22en%22%7D
end