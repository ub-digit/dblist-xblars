defmodule Databases.Resource.Search do
    alias Databases.Model
    alias Databases.Repo
    import Ecto.Query
    @elastic_url  :"http://localhost:9200"

    def search_db_by_title(title, lang) do
        Databases.Resource.Database.list_databases_with_lang(lang)
        |> Enum.filter(fn db -> String.contains?(db.title, title) end)
        |> Enum.sort_by(fn item -> item.title end)
    end

    def index_all(data) do
      Elastix.Index.create("http://localhost:9200", "db", %{})
    end
end