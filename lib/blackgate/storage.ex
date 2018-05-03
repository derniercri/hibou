defmodule Blackgate.Storage do
  alias Blackgate.Model.User
  alias Blackgate.Repo

  def get_user_by_id!(id), do: Repo.get!(User, id)
end
