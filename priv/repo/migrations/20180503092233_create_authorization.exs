defmodule Hibou.Repo.Migrations.CreateAuthoriations do
  use Ecto.Migration

  def change do
    create table(:authorizations) do
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))
      add(:client_id, references(:client, on_delete: :delete_all, type: :bigint))

      timestamps()
    end
  end
end
