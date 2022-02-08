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
  def changeset(topic_for, attrs) do
      topic_for
    |> cast(attrs, [:database_id, :topic_id_id])
  end
end
