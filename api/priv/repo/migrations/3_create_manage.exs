defmodule App.Repo.Migrations.CreateManage do
  use Ecto.Migration

  def change do
    create table(:manage) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :team_id, references(:teams, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
