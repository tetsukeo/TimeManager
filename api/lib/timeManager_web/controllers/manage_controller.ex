defmodule AppWeb.ManageController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Manage

  action_fallback AppWeb.FallbackController

end
