defmodule Blackgate.Storage do
  alias Blackgate.Model.User
  alias Blackgate.Repo
  import Ecto.Query, warn: false

  def get_user_by_id!(id), do: Repo.get!(User, id)

  def get_user_by_username(username),
    do: Repo.one(from(u in User, where: u.email == ^username or u.username == ^username))
end
