defmodule DatabasesWeb.SearchController do
  use DatabasesWeb, :controller
  
  def index_with_lang(conn, %{"term" => term, "lang" => lang}) do
    result = Jason.encode!(Databases.Resource.Search.search_db_by_title(term, lang))
    text conn, result
  end
end