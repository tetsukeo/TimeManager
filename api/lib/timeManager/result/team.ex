defmodule App.Result.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    many_to_many :users, App.Result.User, join_through: "member", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :users])
    |> validate_required([:name, :users])
  end
end
