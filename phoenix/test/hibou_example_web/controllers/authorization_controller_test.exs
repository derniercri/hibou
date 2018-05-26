defmodule MyAppWeb.AuthorizationControllerTest do
  use MyAppWeb.ConnCase

  alias Hibou.Model.User

  test "authorize whitout being logged cause a redirect", %{conn: conn} do
    conn = get(conn, "/authorize?response_type=code&redirect_uri=http://localhost&client_id=1")

    assert redirected_to(conn) == "/login"

    assert Plug.Conn.get_session(conn, :redirect_url) ==
             "/authorize?response_type=code&redirect_uri=http://localhost&client_id=1"
  end

  test "authorize when user is connected", %{conn: conn} do
    conn = MyApp.Guardian.Plug.sign_in(conn, %User{id: 1})

    conn = get(conn, "/authorize?response_type=code&redirect_uri=http://localhost&client_id=1")

    assert conn.status == 200
    assert String.contains?(conn.resp_body, "dev_client wants to access your data.")
  end
end
