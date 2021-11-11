defmodule Databases.Model.AlternativeTitle do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "alternative_titles" do
      field :title, :string
      has_many :alternative_title_for, Model.AlternativeTitleFor 
    end
  
    def remap(%Databases.Model.AlternativeTitle{} = alternative_title) do
      %{
        #id: topic.id,
        name: alternative_title.title
      }
    end
  
    @doc false
    def changeset(alternative_title, attrs) do
      alternative_title
      |> cast(attrs, [:title])
      |> validate_required([:title])
    end
  end