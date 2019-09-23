defmodule App.Result.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "member" do
    belongs_to :user, App.Result.User
    belongs_to :team, App.Result.Team

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
  end
end
