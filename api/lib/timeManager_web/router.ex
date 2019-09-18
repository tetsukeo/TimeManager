defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    get "/workingtimes/:userID", WorkingtimeController, :index
    get "/workingtimes/:userID/:workingtimeID", WorkingtimeController, :show
    post "/workingtimes/:userID", WorkingtimeController, :create
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit, :index, :show, :create]
    get "/clocks/:userID", ClockController, :show
    post "/clocks/:userID", ClockController, :create
  end
end

