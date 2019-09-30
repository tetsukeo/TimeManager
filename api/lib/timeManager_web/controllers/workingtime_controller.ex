defmodule AppWeb.WorkingtimeController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Workingtime

  action_fallback AppWeb.FallbackController

  def index(conn, %{"userID" => userID} = params) do
    clockStart = Map.get(params, "start", "")
    clockEnd = Map.get(params, "end", "")
    cond do
      clockStart != "" && clockEnd != "" -> render(conn, "index.json", workingtimes: Result.list_user_workingtimes_start_end!(userID, clockStart, clockEnd))
      clockStart != "" -> render(conn, "index.json", workingtimes: Result.list_user_workingtimes_start!(userID, clockStart))
      clockEnd != "" -> render(conn, "index.json", workingtimes: Result.list_user_workingtimes_end!(userID, clockEnd))
      true -> render(conn, "index.json", workingtimes: Result.list_user_workingtimes!(userID))
    end
  end

  def create(conn, %{"userID" => userID ,"workingtime" => workingtime_params}) do
    startClock = Map.get(workingtime_params, "start")
    endClock = Map.get(workingtime_params, "end")
    with {:ok, %Workingtime{} = workingtime} <- Result.create_workingtime(workingtime_params, userID) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime.user_id, workingtime.id))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"userID" => userID, "workingtimeID" => workingtimeID}) do
    workingtime = Result.get_workingtime_by_user(userID, workingtimeID)
    if (workingtime == nil) do
      conn
      |> put_status(:not_found)
      |> put_view(AppWeb.ErrorView)
      |> render(:"404")
    else
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Result.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Result.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Result.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Result.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
