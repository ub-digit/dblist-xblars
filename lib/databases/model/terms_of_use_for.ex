defmodule Databases.Model.TermsOfUseFor do
    use Ecto.Schema
    import Ecto.Changeset
    alias Databases.Model
  
    schema "terms_of_use_for" do
      belongs_to :database, Model.Database
      belongs_to :terms_of_use, Model.TermsOfUse
      field :description_en, :string
      field :description_sv, :string
      field :permitted, :boolean
    end

    def remap(%Model.TermsOfUseFor{description_en: description} = terms_of_use_for, terms_of_use, "en") do
      Map.put(terms_of_use_for, :description, description)
      |> Map.delete(:description_en)
      |> remap(terms_of_use)
    end

    def remap(%Model.TermsOfUseFor{description_sv: description} = terms_of_use_for, terms_of_use, "sv") do
      Map.put(terms_of_use_for, :description, description)
      |> Map.delete(:description_sv)
      |> remap(terms_of_use)
    end

    def remap(%{} = terms_of_use_for, terms_of_use) do
      tou = Enum.find(terms_of_use, fn item -> item.id == terms_of_use_for.terms_of_use_id end)
      %{
        permitted: terms_of_use_for.permitted,
        description: terms_of_use_for.description,
        code: tou.code,
        id: tou.id
      }
    end
  
    @doc false
    def changeset(terms_of_use_for, attrs) do
        terms_of_use_for
      |> cast(attrs, [:database_id, :terms_of_use_id])
    end
  end
  