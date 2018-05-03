defmodule BlackgateWeb.RegistrationController do
  use BlackgateWeb, :controller
  alias Blackgate.Model.User
  alias Blackgate.Repo

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}, %{}))
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    # TODO: check password

    case Repo.insert(changeset) do
      {:ok, _changeset} ->
        render(conn, "created.html")

      {:error, _changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
