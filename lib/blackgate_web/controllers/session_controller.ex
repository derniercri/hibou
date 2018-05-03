defmodule BlackgateWeb.SessionController do
  use BlackgateWeb, :controller
  alias Blackgate.Model.User
  alias Blackgate.Storage

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    changeset = User.changeset(%User{}, %{})

    case get_user(email, password) do
      nil ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("index.html", changeset: changeset)

      user ->
        case user.enabled do
          true ->
            {:ok, token, _} = Blackgate.Guardian.encode_and_sign(user)

            conn
            |> Plug.Conn.put_resp_cookie("token", token, http_only: false)
            |> Plug.Conn.put_resp_cookie("user_id", "#{user.id}")
            |> Blackgate.Guardian.Plug.sign_in(user, %{"sub" => "#{user.id}"})
            |> redirect(to: "/")

          false ->
            conn
            |> put_flash(:error, "User is not activated")
            |> render("index.html", changeset: changeset)
        end
    end
  end

  def sign_out(conn, _params) do
    conn
    |> Blackgate.Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp get_user(email, password) do
    case Storage.get_user_by_username(email) do
      nil ->
        nil

      user ->
        case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
          true -> user
          false -> nil
        end
    end
  end
end
