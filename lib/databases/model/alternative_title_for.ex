defmodule Databases.Model.AlternativeTitleFor do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "alternative_title_for" do
      belongs_to :database, Model.Database
      belongs_to :alternative_title, Databases.Model.AlternativeTitle
    end
  
    @doc false
    def changeset(database_publisher, attrs) do
        database_publisher
      |> cast(attrs, [:database_id, :publisher_id])
    end
  end
  