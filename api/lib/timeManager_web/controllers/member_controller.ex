defmodule AppWeb.MemberController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Member

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    member = Result.list_member()
    render(conn, "index.json", member: member)
  end

  def create(conn, %{"member" => member_params}) do
    with {:ok, %Member{} = member} <- Result.create_member(member_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.member_path(conn, :show, member))
      |> render("show.json", member: member)
    end
  end

  def show(conn, %{"id" => id}) do
    member = Result.get_member!(id)
    render(conn, "show.json", member: member)
  end

  def update(conn, %{"id" => id, "member" => member_params}) do
    member = Result.get_member!(id)

    with {:ok, %Member{} = member} <- Result.update_member(member, member_params) do
      render(conn, "show.json", member: member)
    end
  end

  def delete(conn, %{"id" => id}) do
    member = Result.get_member!(id)

    with {:ok, %Member{}} <- Result.delete_member(member) do
      send_resp(conn, :no_content, "")
    end
  end
end
