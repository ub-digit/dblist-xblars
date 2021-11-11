defmodule Databases.Model.MediaTypeFor do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "media_type_for" do
      belongs_to :database, Model.Database
      belongs_to :media_type, Model.MediaType   
    end
  
    @doc false
    def changeset(publisher_for, attrs) do
        publisher_for
      |> cast(attrs, [:database_id, :publisher_id])
    end
  end
  