defmodule Blackgate.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end

  end
end
