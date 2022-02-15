defmodule Databases.Model.SubTopicFor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Databases.Model

  schema "sub_topic_for" do
    belongs_to :database, Model.Database
    belongs_to :sub_topic, Model.SubTopic
    field :is_recommended, :boolean
  end

  @doc false
  def changeset(topic_for, attrs) do
      topic_for
    |> cast(attrs, [:database_id, :topic_id_id])
  end
end
