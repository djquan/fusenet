defmodule FusenetWeb.PageController do
  use FusenetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
