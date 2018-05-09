defmodule HibouExampleWeb.PageController do
  use HibouExampleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
