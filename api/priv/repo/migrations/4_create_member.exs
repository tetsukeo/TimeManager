defmodule App.Repo.Migrations.CreateMember do
  use Ecto.Migration

  def change do
    create table(:member) do
      add :user_id, references(:users)
      add :team_id, references(:teams)
      add :is_manager, :boolean, default: false

      timestamps()
    end

    create(index(:member, [:user_id]))
    create(index(:member, [:team_id]))

    create unique_index(:member, [:user_id, :team_id])
  end
end