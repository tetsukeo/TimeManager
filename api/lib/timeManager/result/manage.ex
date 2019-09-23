defmodule App.Result.Manage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "manage" do
    belongs_to :user, App.Result.User
    belongs_to :team, App.Result.Team

    timestamps()
  end

  @doc false
  def changeset(manage, attrs) do
    manage
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
  end
end
