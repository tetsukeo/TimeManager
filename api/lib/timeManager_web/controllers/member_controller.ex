defmodule AppWeb.MemberController do
  use AppWeb, :controller

  alias App.Result
  alias App.Result.Member

  action_fallback AppWeb.FallbackController

end
