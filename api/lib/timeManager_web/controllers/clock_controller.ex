defmodule AppWeb.ClockController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Clock
  alias App.Result.Workingtime

  action_fallback AppWeb.FallbackController

  def create(conn, %{"userID" => userID, "clock" => clock_params}) do
    existing_clock = List.last(Result.get_clock_by_userID!(userID))
    if (existing_clock != nil) do
      with {:ok, %Workingtime{}} <- Result.create_auto_workingtime( String.to_integer(userID), existing_clock.time, clock_params["time"]) do
        with {:ok, %Clock{}} <- Result.delete_clock(existing_clock) do
          send_resp(conn, :created, "\"End clock, a workingtime has been set\"")
        end
      end
    else
      with {:ok, %Clock{} = clock} <- Result.create_clock(clock_params, userID) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
        |> render("show.json", clock: clock)
      end
    end
  end

  def show(conn, %{"userID" => userID}) do
    clock = Result.get_clock_by_userID!(userID)
    render(conn, "index.json", clocks: clock)
  end

end
