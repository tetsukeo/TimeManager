defmodule App.Result.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do

    field :email, :string, null: false
    field :username, :string, null: false
    has_many :clocks, App.Result.Clock
    has_many :workingtimes, App.Result.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)

  end
end