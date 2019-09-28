defmodule App.Result.Member do
    use Ecto.Schema
    import Ecto.Changeset
  
    schema "member" do
        belongs_to :user, App.Result.User
        belongs_to :team, App.Result.Team
        field :is_manager, :boolean, default: false
  
      timestamps()
    end
  
    @doc false
    def changeset(member, attrs) do
      member
      |> cast(attrs, [:user_id, :team_id])
      |> validate_required([:user_id, :team_id])
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:team_id)
      #|> unique_constraint([:user_id, :team_id], name: :user_id_team_id_unique_index, message: "Already exists")
    end
  end
  