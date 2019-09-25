defmodule App.Repo.Migrations.CreateUsers do
    use Ecto.Migration
  
    def change do
      create table(:users) do
        add :username, :string, null: false
        add :email, :string, null: false
        add :password_hash, :string
        add :password, :string, virtual: true
        add :password_confirmation, :string, virtual: true
        add :role, :string
        timestamps()
      end
      create constraint("users", "check_email_format", check: "email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'")
      create unique_index(:users, [:email])
    end
  end