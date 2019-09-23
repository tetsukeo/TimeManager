defmodule AppWeb.TeamController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Team

  action_fallback AppWeb.FallbackController

end
