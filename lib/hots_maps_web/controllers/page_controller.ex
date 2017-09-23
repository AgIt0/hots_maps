defmodule HotsMapsWeb.PageController do
  use HotsMapsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
