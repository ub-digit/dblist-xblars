  
defmodule Databases.Resource.Topic do
    alias Databases.Model
    alias Databases.Repo
    import Ecto.Query

    def list_topics do
      Repo.all(Databases.Model.Topic)
      |> Enum.map(&Databases.Model.Topic.remap/1)
    end

    def get_parent_topics(lang) do
       (from topic in Model.Topic,
        where: is_nil(topic.parent_topic_id))
        |> Repo.all
        |> Enum.map(fn item -> Databases.Model.Topic.remap(item, lang) end)
        |> Enum.map(fn item -> Databases.Resource.Topic.add_child_topics(item, lang) end)
    end

    def add_child_topics(%{} = parent_topic, lang) do
        children = Repo.all(from topic in Model.Topic,
        where: topic.parent_topic_id == ^parent_topic.id)
        |> Enum.map(fn item -> Databases.Model.Topic.remap(item, lang) end)
        %{
            name: parent_topic.name,
            id: parent_topic.id,
            sub_topics: children
        }
    end
    def list_publishers do
      Repo.all(DatabasePublisher)
    end
    

    def get_database!(id) do
       Repo.get!(Database, id)
    end

    def join_on_publisher() do
      (from db in Databases.Model.Database,
      left_join: db_pb in Databases.Model.DatabasePublisher,
      on: db_pb.database_id == db.id,
      left_join: pb in Databases.Model.Publisher,
      on: pb.id == db_pb.publisher_id,
      left_join: tp_db in Databases.Model.TopicFor,
      on: tp_db.database_id == db.id,
      left_join: tp in Databases.Model.Topic,
      on: tp.id == tp_db.topic_id,
      preload: [publishers: pb, topics: tp])
      |> Repo.all
      |> Enum.map(&Databases.Model.Database.remap/1)
    end
  
end

