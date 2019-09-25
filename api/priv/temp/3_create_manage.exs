# defmodule App.Repo.Migrations.CreateManage do
#   use Ecto.Migration

#   def change do
#     create table(:manage) do
#       add :user_id, references(:users)
#       add :team_id, references(:teams)
#     end

#     create unique_index(:manage, [:user_id, :team_id])
#   end
# end
