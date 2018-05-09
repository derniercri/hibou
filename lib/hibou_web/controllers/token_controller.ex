defmodule HibouWeb.TokenController do
  use HibouWeb, :controller

  alias Hibou.Model.User
  alias Hibou.Storage

  @invalid_credentials %{"message" => "invalid credentials"}
  @invalid_request %{"message" => "invalid credentials"}

  defp render_json(conn, code, data) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(code, Poison.encode!(data))
  end

  def create(conn, %{"grant_type" => grant_type} = params) do
    case grant_type do
      "authorization_code" ->
        case Storage.get_authorization_by_code(params["code"]) do
          nil ->
            conn |> render_json(400, @invalid_request)

          auth ->
            {:ok, access_token, _claims} = Hibou.Guardian.encode_and_sign(auth.user, %{})
            {:ok, refresh_token, _claims} = Hibou.Guardian.encode_and_sign(auth.user, %{})

            conn
            |> render_json(200, %{
              "access_token" => access_token,
              "refresh_token" => refresh_token,
              "expires_in" => 3600
            })
        end

      "password" ->
        case Storage.get_user_by_username(params["username"]) do
          nil ->
            conn |> render_json(400, @invalid_credentials)

          user ->
            User.check_password(params["password"], user.password_hash)

            {:ok, access_token, _claims} = Hibou.Guardian.encode_and_sign(user, %{})
            {:ok, refresh_token, _claims} = Hibou.Guardian.encode_and_sign(user, %{})

            conn
            |> render_json(200, %{
              "access_token" => access_token,
              "refresh_token" => refresh_token,
              "expires_in" => 3600
            })
        end
    end
  end
end
