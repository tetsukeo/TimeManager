defmodule AppWeb.Router do
  use AppWeb, :router
  alias App.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api", AppWeb do
    pipe_through :api
    resources "/users", UserController, only: [:create, :show] # maybe replace by resources “/users", UserController, only: [:create, :show]
    
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
  end

  scope "/api", AppWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/users", UserController, :index
    delete "/users", UserController, :delete
    get "/workingtimes/:userID", WorkingtimeController, :index
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :create
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit, :index, :show, :create]
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create
  end
end

