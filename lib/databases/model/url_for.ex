defmodule Databases.Model.UrlFor do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "url_for" do
      belongs_to :database, Model.Database
      belongs_to :url, Model.Url
    end
  
    @doc false
    def changeset(url_for, attrs) do
        url_for
      |> cast(attrs, [:database_id, :url_id])
    end
  end
  