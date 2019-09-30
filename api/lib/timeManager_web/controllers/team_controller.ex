defmodule AppWeb.TeamController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Team

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    name = Map.get(_params, "name", "")
    cond do
      name != "" -> render(conn, "index.json", teams: Result.list_teams_name(name))
      true -> render(conn, "index.json", teams: Result.list_teams())
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

  alias App.Result.Member

  def add_member(conn, %{"userID" => userID, "teamID" => teamID}) do
    with {:ok, %Member{}} <- Result.add_member(userID, teamID) do
      send_resp(conn, :created, "\"Member successfully affected\"")
    end
  end

  def add_manager(conn, %{"userID" => userID, "teamID" => teamID}) do
    exists = Result.get_team_member(userID, teamID)
    if (exists == nil) do
      with {:ok, %Member{}} <- Result.add_manager(userID, teamID) do
        send_resp(conn, :created, "\"Manager successfully affected\"")
      end
    else
      with {:ok, %Member{}} <- Result.set_to_manager(exists, userID, teamID) do
        send_resp(conn, :created, "\"Member has been successfully set to manager\"")
      end
    end
        
  end

  def get_team_workingtimes(conn, %{"teamID" => teamID} = params) do
    clockStart = Map.get(params, "start", "")
    clockEnd = Map.get(params, "end", "")
    cond do
      clockStart != "" && clockEnd != "" -> render(conn, AppWeb.WorkingtimeView, "index.json", workingtimes: Result.list_team_workingtimes_start_end(teamID, clockStart, clockEnd))
      clockStart != "" -> render(conn, AppWeb.WorkingtimeView, "index.json", workingtimes: Result.list_team_workingtimes_start(teamID, clockStart))
      clockEnd != "" -> render(conn, AppWeb.WorkingtimeView, "index.json", workingtimes: Result.list_team_workingtimes_end(teamID, clockEnd))
      true -> render(conn, AppWeb.WorkingtimeView, "index.json", workingtimes: Result.list_team_workingtimes(teamID))
    end
  end

  def del_member(conn, %{"teamID" => teamID, "userID" => userID}) do
    member_assoc = Result.get_team_member(userID, teamID)

    with {:ok, %Member{}} <- Result.delete_member(member_assoc) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_user_team(conn, %{"userID" => userID}) do
      render(conn, "index.json", teams: Result.get_user_team(userID))
  end
end
