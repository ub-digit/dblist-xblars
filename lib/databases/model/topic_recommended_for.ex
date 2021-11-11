defmodule Databases.Model.TopicRecommendedFor do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "topic_recommended_for" do
      belongs_to :database, Model.Database
      belongs_to :topic, Model.Topic
    end
  
    @doc false
    def changeset(topic_recommended_for, attrs) do
        topic_recommended_for
      |> cast(attrs, [:database_id, :topic_id])
    end
  end
  