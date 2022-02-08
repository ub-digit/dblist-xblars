defmodule Databases.Model.Database do
  use Ecto.Schema
  import Ecto.Changeset
  alias Databases.Model
 # import Access

  schema "databases" do
    field :description_en, :string
    field :description_sv, :string
    field :title_en, :string
    field :title_sv, :string
    field :is_popular, :boolean
    field :public_access, :boolean
    field :access_information_code, :string
    field :malfunction_message_active, :boolean
    field :malfunction_message, :string
    has_many :publisher_for, Model.PublisherFor
    has_many :publishers, through: [:publisher_for, :publisher]
    has_many :topic_for, Model.Database.TopicFor
    has_many :topics, through: [:topic_for, :topic]
    has_many :alternative_title_for, Model.AlternativeTitleFor
    has_many :alternative_titles, through: [:alternative_title_for, :alternative_title]
    has_many :urls_for, Model.UrlFor
    has_many :urls, through: [:urls_for, :urls]
    has_many :topic_recommended_for, Model.TopicRecommendedFor
    has_many :topics_recommended, through: [:topic_recommended_for, :topic]
    has_many :terms_of_use_for, Model.TermsOfUseFor
    has_many :terms_of_use, through: [:terms_of_use_for, :terms_of_use]
    has_many :media_type_for, Model.MediaTypeFor
    has_many :media_types, through: [:media_type_for, :media_types]
  end

  def remap(%Model.Database{} = database) do
    %{
      id: database.id,
      title: database.title_en,
      description: database.description_en,
      is_popular: database.is_popular,
      publishers: database.publishers |> Enum.map(&Model.Publisher.remap/1),
      #topics: database.topics |> Enum.map(&Model.Topic.remap/1),
      #topics_recommended: database.topics_recommended |> Enum.map(&Model.Topic.remap/1)
    }
  end

  def remap(%Model.Database{description_en: description, title_en: title} = database, "en") do
    Map.put(database, :description, description)
    |> Map.put(:title, title)
    |> Map.delete(:description_en)
    |> Map.delete(:title_en)
    |> remap("en")
  end

  def remap(%Model.Database{description_sv: description, title_sv: title} = database, "sv") do
    Map.put(database, :description, description)
    |> Map.put(:title, title)
    |> Map.delete(:description_sv)
    |> Map.delete(:title_sv)
    |> remap("sv")
  end
"""
  def remap_old(%{description: _, title: _} = database, lang) do
    %{
      id: database.id,
      title: database.title,
      description: database.description,
      is_popular: database.is_popular,
      alternative_titles: database.alternative_titles |> Enum.map(&Databases.Model.AlternativeTitle.remap/1),
      urls: database.urls |> Enum.map(&Databases.Model.Url.remap/1),
      publishers: database.publishers |> Enum.map(fn item -> Model.Publisher.remap(item, lang) end),
      topics: database.topics |> Enum.map(fn item -> Model.Topic.remap(item, lang) end),
      topic_recommended: database.topics_recommended |> Enum.map(fn item -> Model.Topic.remap(item, lang) end),
      terms_of_use: database.terms_of_use_for |> Enum.map(fn item -> Model.TermsOfUseFor.remap(item, database.terms_of_use, lang) end)
    }
  end
"""

  def remap(%{description: _, title: _} = database, lang) do
    %{
      id: database.id,
      title: database.title,
      description: database.description,
      is_popular: database.is_popular,
      alternative_titles: database.alternative_titles |> Enum.map(&Databases.Model.AlternativeTitle.remap/1),
      urls: database.urls |> Enum.map(&Databases.Model.Url.remap/1),
      publishers: database.publishers |> Enum.map(fn item -> Model.Publisher.remap(item, lang) end),
      public_access: database.public_access,
      access_information_code: database.access_information_code,
      malfunction_message_active: database.malfunction_message_active,
      malfunction_message: database.malfunction_message,
      #topics: database.topics |> Enum.map(fn item -> Model.Topic.remap(item, lang) end),
      #topic_recommended: database.topics_recommended |> Enum.map(fn item -> Model.Topic.remap(item, lang) end),
      terms_of_use: database.terms_of_use_for |> Enum.map(fn item -> Model.TermsOfUseFor.remap(item, database.terms_of_use, lang) end),
      media_types: database.media_types |> Enum.map(fn item -> Model.MediaType.remap(item, lang) end)
    }
  end

  """

  def remap2(db) do
    database = db.database
    
    %{
      id: database.id,
      title: database.title_en,
      description: database.description_en,
      is_popular: database.is_popular,
      publishers: database.publishers |> Enum.map(&Model.Publisher.remap/1),
      topics: database.topics |> Enum.map(&Model.Topic.remap/1)
    }
  end
"""
  @doc false
  def changeset(database, attrs) do
    database
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
