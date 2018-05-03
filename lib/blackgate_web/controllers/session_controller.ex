defmodule BlackgateWeb.SessionController do
  use BlackgateWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    render(conn, "new.html")
  end
end
