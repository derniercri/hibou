defmodule Blackgate.Model.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:enabled, :boolean, default: false)
    field(:password, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :enabled])
    |> validate_required([:username, :email, :password, :enabled])
  end
end
