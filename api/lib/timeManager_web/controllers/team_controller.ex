defmodule AppWeb.TeamController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Team

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    name = Map.get(_params, "name", "")
    cond do
      name != "" -> render(conn, "index.json", teams: Result.list_teams_name(name))
    end
    teams = Result.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Result.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Result.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Result.get_team!(id)

    with {:ok, %Team{} = team} <- Result.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Result.get_team!(id)

    with {:ok, %Team{}} <- Result.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
