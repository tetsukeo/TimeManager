defmodule App.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :utc_datetime, null: false
      add :end, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:workingtimes, [:user_id])
    create constraint(:workingtimes, "positive_duration", check: "workingtimes.end > workingtimes.start")
  end
end
