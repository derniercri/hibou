defmodule MyApp.Repo.Migrations.CreateActivationCodes do
  use Ecto.Migration

  def change do
    create table(:activation_codes) do
      add(:code, :string)
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))

      timestamps()
    end

    create(unique_index(:activation_codes, [:code]))
  end
end
