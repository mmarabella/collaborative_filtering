defmodule CollaborativeFilteringWeb.PageController do
  use CollaborativeFilteringWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
