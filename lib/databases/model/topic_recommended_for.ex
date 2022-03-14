defmodule Databases.Model.TopicRecommendedFor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Databases.Model

  schema "topic_recommended_for" do
    belongs_to :database, Model.Database
    #belongs_to :topic, Model.Topic
    field :topic_id, :integer
    field :sub_topic_id, :integer
  end

  @doc false
  def changeset(database_topics, attrs) do
      database_topics
    |> cast(attrs, [:database_id, :topic_id_id])
  end
end
