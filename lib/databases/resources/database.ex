  
defmodule Databases.Resource.Database do
    alias Databases.Model.Database
    alias Databases.Model
    alias Databases.Repo
    alias Databases.Model.Publisher
    #alias Databases.Model.DatabasePublisher
    import Ecto.Query

    def list_databases do
      Repo.all(Database)
    end

    def list_publishers do
      (from db in Model.Database,
      select: map(db, [:title_en, :description_en]))
      |> Repo.all
    end
    

    def get_database!(id, lang) do
      (from db in db_base(),
      where: db.id == ^id)
      |> Repo.one
      |> Databases.Model.Database.remap(lang)
    end

    def join_on_publisher() do
      (from db in Databases.Model.Database,
      left_join: db_pb in Databases.Model.PublisherFor,
      on: db_pb.database_id == db.id,
      left_join: pb in Databases.Model.Publisher,
      on: pb.id == db_pb.publisher_id,
      left_join: tp_db in Databases.Model.TopicFor,
      on: tp_db.database_id == db.id,
      left_join: tp in Databases.Model.Topic,
      on: tp.id == tp_db.topic_id,
      preload: [publishers: pb, topics: tp])
      |> Repo.all
      |> Enum.map(&Databases.Model.Database.remap/1)
    end

    def db_base() do
      (from db in Databases.Model.Database,
      left_join: db_pb in Databases.Model.PublisherFor,
      on: db_pb.database_id == db.id,
      left_join: pb in Databases.Model.Publisher,
      on: pb.id == db_pb.publisher_id,
      left_join: tp_db in Databases.Model.TopicFor,
      on: tp_db.database_id == db.id,
      left_join: tp in Databases.Model.Topic,
      on: tp.id == tp_db.topic_id,
      left_join: alt_title_for in Databases.Model.AlternativeTitleFor,
      on: alt_title_for.database_id == db.id,
      left_join: alt_title in Databases.Model.AlternativeTitle,
      on: alt_title.id == alt_title_for.alternative_title_id,
      left_join: url_for in Model.UrlFor,
      on: url_for.database_id == db.id,
      left_join: url in Model.Url,
      on: url.id == url_for.url_id,
      left_join: trf in Model.TopicRecommendedFor,
      on: trf.database_id == db.id,
      left_join: tr in Model.Topic,
      on: trf.topic_id == tr.id,
      left_join: tou_for in Model.TermsOfUseFor,
      on: tou_for.database_id == db.id,
      left_join: tou in Model.TermsOfUse,
      on: tou.id == tou_for.terms_of_use_id,
      left_join: media_type_for in Databases.Model.MediaTypeFor,
      on: media_type_for.database_id == db.id,
      left_join: mt in Databases.Model.MediaType,
      on: mt.id == media_type_for.media_type_id,
      preload: [publishers: pb, topics: tp, alternative_titles: alt_title, urls: url, topics_recommended: tr, terms_of_use: tou, terms_of_use_for: tou_for, media_types: mt])  
    end

    def list_databases_with_lang(lang) do
      (from db in Databases.Model.Database,
      left_join: db_pb in Databases.Model.PublisherFor,
      on: db_pb.database_id == db.id,
      left_join: pb in Databases.Model.Publisher,
      on: pb.id == db_pb.publisher_id,
      left_join: tp_db in Databases.Model.TopicFor,
      on: tp_db.database_id == db.id,
      left_join: tp in Databases.Model.Topic,
      on: tp.id == tp_db.topic_id,
      left_join: alt_title_for in Databases.Model.AlternativeTitleFor,
      on: alt_title_for.database_id == db.id,
      left_join: alt_title in Databases.Model.AlternativeTitle,
      on: alt_title.id == alt_title_for.alternative_title_id,
      left_join: url_for in Model.UrlFor,
      on: url_for.database_id == db.id,
      left_join: url in Model.Url,
      on: url.id == url_for.url_id,
      left_join: trf in Model.TopicRecommendedFor,
      on: trf.database_id == db.id,
      left_join: tr in Model.Topic,
      on: trf.topic_id == tr.id,
      left_join: tou_for in Model.TermsOfUseFor,
      on: tou_for.database_id == db.id,
      left_join: tou in Model.TermsOfUse,
      on: tou.id == tou_for.terms_of_use_id,
      left_join: media_type_for in Databases.Model.MediaTypeFor,
      on: media_type_for.database_id == db.id,
      left_join: mt in Databases.Model.MediaType,
      on: mt.id == media_type_for.media_type_id,
      preload: [publishers: pb, topics: tp, alternative_titles: alt_title, urls: url, topics_recommended: tr, terms_of_use: tou, terms_of_use_for: tou_for, media_types: mt])  
      |> Repo.all
      |> Enum.map(fn (item) -> Databases.Model.Database.remap(item, lang) end)
      |> Enum.sort_by(fn item -> item.title end)
    end

  @doc """
  Runs at startup of Phoenix, called from lib/dblist/application.ex
  At startup, fetch all databases and index them in Solr
  """
  def init() do
    list_databases_with_lang("en")
    |> Database.Resources.Search.index_all()
  end
  
end