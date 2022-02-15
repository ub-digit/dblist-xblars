  
defmodule Databases.Resource.Database do
  alias Databases.Model.Database
  alias Databases.Model
  alias Databases.Repo
  alias Databases.Model.Publisher
  #alias Databases.Model.DatabasePublisher
  import Ecto.Query

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
    res = (from db in Databases.Model.Database,
    left_join: db_pb in Databases.Model.PublisherFor,
    on: db_pb.database_id == db.id,
    left_join: pb in Databases.Model.Publisher,
    on: pb.id == db_pb.publisher_id,
    #left_join: tp_db in Databases.Model.TopicFor,
    #on: tp_db.database_id == db.id,
    #left_join: tp in Databases.Model.Topic,
    #on: tp.id == tp_db.topic_id,
    left_join: alt_title_for in Databases.Model.AlternativeTitleFor,
    on: alt_title_for.database_id == db.id,
    left_join: alt_title in Databases.Model.AlternativeTitle,
    on: alt_title.id == alt_title_for.alternative_title_id,
    left_join: url_for in Model.UrlFor,
    on: url_for.database_id == db.id,
    left_join: url in Model.Url,
    on: url.id == url_for.url_id,
    #left_join: trf in Model.TopicRecommendedFor,
    #on: trf.database_id == db.id,
    #left_join: tr in Model.Topic,
    #on: trf.topic_id == tr.id,
    left_join: tou_for in Model.TermsOfUseFor,
    on: tou_for.database_id == db.id,
    left_join: tou in Model.TermsOfUse,
    on: tou.id == tou_for.terms_of_use_id,
    left_join: media_type_for in Databases.Model.MediaTypeFor,
    on: media_type_for.database_id == db.id,
    left_join: mt in Databases.Model.MediaType,
    on: mt.id == media_type_for.media_type_id,
    preload: [publishers: pb, alternative_titles: alt_title, urls: url, urls_for: url_for, terms_of_use: tou, terms_of_use_for: tou_for, media_types: mt])  
    |> Repo.all
    |> Enum.map(fn item -> Databases.Model.Database.remap(item,  lang) end)
    |> Enum.map(fn db -> get_topics(db, lang) end)
    |> Enum.map(fn db -> get_topics_recommended(db, lang) end)
  end

  def popular_databases(lang) do
    list_databases_with_lang(lang)
    |> Enum.filter(fn db -> db.is_popular == true end)
  end

  def get_topics_recommended(db, lang) do
    res = (from tp in Databases.Model.Topic,
    left_join: tpf in Databases.Model.TopicRecommendedFor,
    on: tp.id == tpf.topic_id,
    where: not is_nil(tpf.topic_id),
    where: tpf.database_id == ^db.id)
    |> Repo.all
    |> Enum.map(fn topic -> Databases.Model.Topic.remap(topic, lang) end) 
    |> get_sub_topics_recommended(db, lang)
  end

  def get_sub_topics_recommended(topics, db, lang) do
    res = (from stp in Databases.Model.SubTopic,
    left_join: tpf in Databases.Model.TopicRecommendedFor,
    on: stp.id == tpf.sub_topic_id,
    where: not is_nil(tpf.sub_topic_id),
    where: tpf.database_id == ^db.id)
    |> Repo.all
    |> Enum.map(fn sub_topic -> Databases.Model.SubTopic.remap(sub_topic, lang) end)
    |> sort_topics_recommended(topics)
    Map.put(db, :topics_recommended, res)
  end

  def sort_topics_recommended(sub_topics, topics) do
    topics
    |> Enum.map(fn topic -> [topic] ++ Enum.filter(sub_topics, fn st -> st.topic_id == topic.id end) end)
    |> List.flatten
    |> add_single_sub_topics(sub_topics)      
  end

  def add_single_sub_topics(recommended_topics, sub_topics) do
    recommended_topics ++ Enum.filter(sub_topics, fn st -> !Enum.member?(recommended_topics, st) end)
  end
  
  def get_topics(db, lang) do
    res = (from tp in Databases.Model.Topic,
    left_join: tpf in Databases.Model.TopicFor,
    on: tp.id == tpf.topic_id,
    where: not is_nil(tpf.topic_id),
    where: tpf.database_id == ^db.id)
    |> Repo.all
    |> Enum.map(fn topic -> Databases.Model.Topic.remap(topic, lang) end)
    |> Enum.map(fn topic -> get_sub_topics(topic, db, lang) end)
    Map.put(db, :topics, res)
  end

  def get_sub_topics(topic, db, lang) do
    res = (from stp in Databases.Model.SubTopic,
    left_join: tpf in Databases.Model.TopicFor,
    on: stp.id == tpf.sub_topic_id,
    where: not is_nil(tpf.sub_topic_id),
    where: stp.topic_id == ^topic.id,
    where: tpf.database_id == ^db.id)
    |> Repo.all
    |> Enum.map(fn topic -> Databases.Model.SubTopic.remap(topic, lang) end)
    Map.put(topic, :sub_topics, res)
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
end