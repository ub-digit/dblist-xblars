defmodule DatabasesWeb.TopicController do
    use DatabasesWeb, :controller
    def index(conn, %{"lang" => lang}) do
      #text conn, "db controller"
      #%{"lang" => lang}
      topics = Jason.encode!(Databases.Resource.Topic.get_parent_topics(lang))
        text conn, topics
    end

    #def show(conn, %{"id" => id}) do
    #    database = Poison.encode!(Databases.Resource.Database.get_database!(id)#)
    #    #database = Model.get_database!(id)
    #    text conn, database
    #end
  end


  