defmodule DatabasesWeb.DatabaseController do
    use DatabasesWeb, :controller
  
    def index(conn, params) do
      payload = Jason.decode!(Map.get(params, "payload"))
      IO.inspect(payload, label: "PAYLOAD IN index db controller")
      databases = Jason.encode!(Databases.Resource.Search.search(payload))
      text conn, databases
    end

    def get_popular_databases(conn, params) do
      databases = Jason.encode!(Databases.Resource.Search.popular_databases(get_lang(params)))
      text conn, databases
    end

    def show(conn, %{"id" => id, "lang" => lang} = payload) do
      IO.inspect(payload, label: "payload in show/2")
      database = Jason.encode!(Databases.Resource.Search.show(payload))
      text conn, database
    end

    def show(conn, %{"id" => id} = payload) do
      IO.inspect(payload, label: "payload in show")
      database = Jason.encode!(Databases.Resource.Search.show(payload))
      text conn, database
    end
    
    def get_lang (params) do
      payload = Jason.decode!(Map.get(params, "payload"))
      |> Map.get("lang")
    end
  end

