defmodule DatabasesWeb.DatabaseController do
    use DatabasesWeb, :controller
  
    def index(conn, _params) do
      #text conn, "db controller"
      databases = Jason.encode!(Databases.Resource.Database.list_databases())
      text conn, databases
    end

    def index_with_lang(conn, %{"lang" => lang}) do
      #text conn, "db controller"
      databases = Jason.encode!(Databases.Resource.Database.list_databases_with_lang(lang))
      text conn, databases
    end

    def show(conn, %{"id" => id, "lang" => lang}) do
      database = Jason.encode!(Databases.Resource.Database.get_database!(id, lang))
      #database = Model.get_database!(id)
      text conn, database
    end

    def show_database_publisher(conn, _params) do
        publishers = Jason.encode!(Databases.Resource.Database.join_on_publisher())
        text conn, publishers
    end
  end


  