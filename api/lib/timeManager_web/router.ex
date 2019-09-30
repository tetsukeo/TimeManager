defmodule AppWeb.Router do
  use AppWeb, :router
  alias App.Guardian

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]

  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", AppWeb do
    pipe_through :api
    resources "/users", UserController, only: [:create, :show]
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api", AppWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
    get "/workingtimes/:userID", WorkingtimeController, :index
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :create
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit, :index, :show, :create]
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create
    resources "/teams", TeamController, except: [:new, :edit]
    post "/teams/:teamID/members/:userID", TeamController, :add_member
    post "/teams/:teamID/managers/:userID", TeamController, :add_manager
    delete "/teams/:teamID/members/:userID", TeamController, :del_member
    get "/teams/:teamID/workingtimes", TeamController, :get_team_workingtimes
  end
end

