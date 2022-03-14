  
defmodule Databases.Resource.Database do
  alias Databases.Model.Database
  alias Databases.Model
  alias Databases.Repo
  alias Databases.Model.Publisher
  import Ecto.Query

  def list_publishers do
    (from db in Model.Database,
    select: map(db, [:title_en, :description_en]))
    |> Repo.all
  end
  
  def get_database!(id, lang) do # Remove or keep for admin pages? - This is done in Databases.Resources.Search
    (from db in db_base(),
    where: db.id == ^id)
    |> Repo.one
    |> Databases.Model.Database.remap(lang)
  end
  
  def db_base() do
    res = (from db in Model.Database,
    left_join: t_for in Model.DatabaseTopic,
    on: t_for.database_id == db.id,
    left_join: t in Model.Topic,
    on: t.id == t_for.topic_id,
    left_join: st_for in Model.DatabaseSubTopic,
    on: st_for.database_id == db.id,
    left_join: st in Model.SubTopic,
    on: st.id == st_for.sub_topic_id,
    left_join: db_pb in Databases.Model.DatabasePublisher,
    on: db_pb.database_id == db.id,
    left_join: pb in Databases.Model.Publisher,
    on: pb.id == db_pb.publisher_id,
    left_join: alt_title_for in Databases.Model.AlternativeTitleFor,
    on: alt_title_for.database_id == db.id,
    left_join: alt_title in Databases.Model.AlternativeTitle,
    on: alt_title.id == alt_title_for.alternative_title_id,
    left_join: database_urls in Model.DatabaseUrl,
    on: database_urls.database_id == db.id,
    left_join: tou_for in Model.DatabaseTermsOfUse,
    on: tou_for.database_id == db.id,
    left_join: tou in Model.TermsOfUse,
    on: tou.id == tou_for.terms_of_use_id,
    left_join: media_type_for in Databases.Model.MediaTypeFor,
    on: media_type_for.database_id == db.id,
    left_join: mt in Databases.Model.MediaType,
    on: mt.id == media_type_for.media_type_id,
    preload: [:database_urls, sub_topics: st, topics: t, publishers: pb, alternative_titles: alt_title, terms_of_use: tou, database_terms_of_use: tou_for, media_types: mt])  
  end
  
  def popular_databases(lang) do
    list_databases_with_lang(lang)
    |> Enum.filter(fn db -> db.is_popular == true end)
  end

  @doc """
  Runs at startup of Phoenix, called from lib/dblist/application.ex
  At startup, fetch all databases and index them in Solr
  """
  def init do
    list_databases_with_lang("en")
    |> Databases.Resource.Search.index_all("en")
    list_databases_with_lang("sv")
    |> Databases.Resource.Search.index_all("sv")
  end

  def list_databases_with_lang(lang) do
    db_base()  
    |> Repo.all
    |> Enum.map(fn item -> Databases.Model.Database.remap(item,  lang) end)
  end
end