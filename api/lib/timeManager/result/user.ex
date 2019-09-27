defmodule App.Result.User do
  use Ecto.Schema
  import Ecto.Changeset
  # import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do

    field :email, :string, null: false
    field :username, :string, null: false
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"
    has_many :clocks, App.Result.Clock
    has_many :workingtimes, App.Result.Workingtime
    many_to_many :teams, App.Result.Team, join_through: "member", on_replace: :delete
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  def changeset_update_teams(user, teams) do
    user
    |> cast(%{}, [:user_id, :team_id])
    |> put_assoc(:teams, teams)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
      ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end
