defmodule AppWeb.ClockController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Clock

  action_fallback AppWeb.FallbackController

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Result.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => userID}) do
    clock = Result.get_clock_by_userID!(userID)
    render(conn, "show.json", clock: clock)
  end

end
