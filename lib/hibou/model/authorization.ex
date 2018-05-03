defmodule Hibou.Model.Authorization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hibou.Model.User
  alias Hibou.Model.Client

  schema "clients" do
    belongs_to(:user, User)
    belongs_to(:client, Client)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :client_id])
    |> validate_required([:user_id, :client_id])
  end
end
