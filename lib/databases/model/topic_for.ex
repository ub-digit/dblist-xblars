defmodule Databases.Model.TopicFor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Databases.Model

  schema "topic_for" do
    belongs_to :database, Model.Database
    belongs_to :topic, Model.Topic
    field :is_recommended, :boolean
  end

  @doc false
  def changeset(topic_for, attrs) do
      topic_for
    |> cast(attrs, [:database_id, :topic_id_id])
  end
end
