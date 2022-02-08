defmodule DatabasesWeb.DatabaseController do
    use DatabasesWeb, :controller
  
    def index(conn, params) do
      payload = Jason.decode!(Map.get(params, "payload"))
      #IO.inspect(payload, label: "payload !!")
      IO.inspect(payload, label: "PAYLOAD IN")
      databases = Jason.encode!(Databases.Resource.Search.search(payload))
      #databases = Jason.encode!(Databases.Resource.Database.list_databases())
      #databases = Jason.encode!(Databases.Resource.Search.list_databases(Jason.decode!(Map.get(params, "payload"))))
     # databases = "tjoff"
      text conn, databases
    end

    def index_with_lang(conn, params) do
      IO.inspect("DATABASES")
      databases = "return stuff"

      #IO.inspect(params, label: "params in index_with_lang")
      #databases = Jason.encode!(Databases.Resource.Search.list_databases(Jason.decode!(Map.get(params, :payload))))
      #databases = Databases.Resource.Search.list_databases(Jason.decode!(Map.get(params, :payload)))
      text conn, databases
    end

    def get_popular_databases(conn, params) do
      databases = Jason.encode!(Databases.Resource.Search.popular_databases(get_lang(params)))
      text conn, databases
    end

    """
    def get_popular_databases(conn, params) do
      IO.inspect(params, label: "Params in get popular db")
      databases = Jason.encode!(Databases.Resource.Database.popular_databases(get_lang(params)))
      text conn, databases
    end
    """
    def fffff_show(conn, %{"id" => id, "lang" => lang}) do
      database = Jason.encode!(Databases.Resource.Database.get_database!(id, lang))
      #database = Model.get_database!(id)
      text conn, database
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

    

    def show_database_publisher(conn, _params) do
        publishers = Jason.encode!(Databases.Resource.Database.join_on_publisher())
        text conn, publishers
    end

    def get_lang (params) do
      payload = Jason.decode!(Map.get(params, "payload"))
      |> Map.get("lang")
    end
  end

