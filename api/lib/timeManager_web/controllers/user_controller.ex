defmodule AppWeb.UserController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.User
  alias App.Guardian

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    users = Result.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Result.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> render("jwt.json", jwt: token)
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  #def show(conn, %{"id" => id}) do
   # user = Result.get_user!(id)
   # render(conn, "show.json", user: user)
  #end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Result.get_user!(id)

    with {:ok, %User{} = user} <- Result.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Result.get_user!(id)

    with {:ok, %User{}} <- Result.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Result.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
end
