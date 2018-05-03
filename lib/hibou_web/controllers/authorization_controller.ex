defmodule HibouWeb.AuthorizationController do
  use HibouWeb, :controller
  alias Hibou.Model.User
  alias Hibou.Repo

  def new(conn, %{"client_id" => client_id, "response_type" => "code"} = params) do
    case Hibou.Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> Plug.Conn.put_session(:redirect_url, "#{conn.request_path}?#{conn.query_string}")
        |> redirect(to: "/login")

      user ->
        render(conn, "new.html", changeset: User.changeset(%User{}, %{}))
    end
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "confirmation_code", StringGenerator.random_string(10))

    user_params =
      Map.put(user_params, "password_hash", User.hashed_password(user_params["password"]))

    changeset = User.changeset(%User{}, user_params)

    # TODO: check password
    # TODO: send an activation mail

    case Repo.insert(changeset) do
      {:ok, _changeset} ->
        render(conn, "created.html")

      {:error, _changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
