defmodule Hibou.StorageEcto do
  import Hibou.Config

  import Ecto.Query, warn: false

  def get_user_by_id!(id), do: repo().get!(Config.user_model(), id)

  def get_user_by_username(username),
    do:
      repo().one(
        from(u in Config.user_model(), where: u.email == ^username or u.username == ^username)
      )

  def get_client_by_id(id), do: repo().one(from(c in Config.client_model(), where: c.id == ^id))

  def get_authorization_by_code(code),
    do:
      repo().one(from(a in Config.authorization_model(), where: a.code == ^code))
      |> repo().preload([:user, :client])
end
