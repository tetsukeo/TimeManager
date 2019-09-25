defmodule AppWeb.ManageController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Manage

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    manage = Result.list_manage()
    render(conn, "index.json", manage: manage)
  end

  def create(conn, %{"manage" => manage_params}) do
    with {:ok, %Manage{} = manage} <- Result.create_manage(manage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.manage_path(conn, :show, manage))
      |> render("show.json", manage: manage)
    end
  end

  def show(conn, %{"id" => id}) do
    manage = Result.get_manage!(id)
    render(conn, "show.json", manage: manage)
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
    manage = Result.get_manage!(id)

    with {:ok, %Manage{} = manage} <- Result.update_manage(manage, manage_params) do
      render(conn, "show.json", manage: manage)
    end
  end

  def delete(conn, %{"id" => id}) do
    manage = Result.get_manage!(id)

    with {:ok, %Manage{}} <- Result.delete_manage(manage) do
      send_resp(conn, :no_content, "")
    end
  end
end
