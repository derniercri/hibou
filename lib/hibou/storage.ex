defmodule Hibou.Storage do
  alias Hibou.Model.User
  alias Hibou.Model.Client
  alias Hibou.Repo
  import Ecto.Query, warn: false

  def get_user_by_id!(id), do: Repo.get!(User, id)

  def get_user_by_username(username),
    do: Repo.one(from(u in User, where: u.email == ^username or u.username == ^username))

  def get_client_by_id(id), do: Repo.one(from(c in Client, where: c.id == ^id))
end
