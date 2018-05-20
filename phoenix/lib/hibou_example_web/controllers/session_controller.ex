defmodule HibouExampleWeb.SessionController do
  use HibouExampleWeb, :controller
  alias Hibou.Model.User
  alias Hibou.Storage

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    changeset = User.changeset(%User{}, %{})

    case get_user(email, password) do
      nil ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("new.html", changeset: changeset)

      user ->
        case user.enabled do
          true ->
            conn = Hibou.Guardian.Plug.sign_in(conn, user)
            path = get_session(conn, :redirect_url) || "/"

            conn
            |> Hibou.Guardian.Plug.sign_in(user, %{"sub" => "#{user.id}"})
            |> redirect(to: path)

          false ->
            conn
            |> put_flash(:error, "User is not activated")
            |> render("new.html", changeset: changeset)
        end
    end
  end

  def sign_out(conn, _params) do
    conn
    |> Hibou.Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp get_user(email, password) do
    case Storage.get_user_by_username(email) do
      nil ->
        nil

      user ->
        case User.check_password(password, user.password_hash) do
          true -> user
          false -> nil
        end
    end
  end
end
