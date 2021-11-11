defmodule Databases.Model.Url do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "urls" do
      field :title, :string
      field :url, :string
      has_many :url_for, Model.UrlFor 
    end
  
    def remap(url) do
      %{
        title: url.title,
        link: url.url
      }
    end
  
    @doc false
    def changeset(url, attrs) do
      url
      |> cast(attrs, [:title])
      |> validate_required([:title])
    end
  end