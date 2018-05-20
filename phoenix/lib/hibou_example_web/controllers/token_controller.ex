defmodule HibouExampleWeb.TokenController do
  use HibouExampleWeb, :controller

  alias Hibou.OAuth2

  defp render_json(conn, code, data) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(code, Poison.encode!(data))
  end

  def create(conn, params) do
    case OAuth2.authorize(params) do
      {:error, data} -> conn |> render_json(400, data)
      {:ok, data} -> conn |> render_json(200, data)
    end
  end
end
