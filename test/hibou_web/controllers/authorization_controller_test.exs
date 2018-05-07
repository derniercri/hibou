defmodule HibouWeb.AuthorizationControllerTest do
  use HibouWeb.ConnCase

  test "authorize whitout being logged cause a redirect", %{conn: conn} do
    conn = get(conn, "/authorize?response_type=code&redirect_uri=http://localhost&client_id=1")

    assert redirected_to(conn) == "/login"

    assert Plug.Conn.get_session(conn, :redirect_url) ==
             "/authorize?response_type=code&redirect_uri=http://localhost&client_id=1"
  end
end
