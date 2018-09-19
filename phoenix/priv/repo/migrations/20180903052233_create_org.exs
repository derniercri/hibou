defmodule MyApp.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add(:name, :string)

      timestamps()
    end

    create table(:user_orgs) do
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))
      add(:org_id, references(:orgs, on_delete: :delete_all, type: :bigint))

      timestamps()
    end
  end
end
