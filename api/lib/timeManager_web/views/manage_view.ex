defmodule AppWeb.ManageView do
  use AppWeb, :view
  alias AppWeb.ManageView

  def render("index.json", %{manage: manage}) do
    %{data: render_many(manage, ManageView, "manage.json")}
  end

  def render("show.json", %{manage: manage}) do
    %{data: render_one(manage, ManageView, "manage.json")}
  end

  def render("manage.json", %{manage: manage}) do
    %{id: manage.id,
      user_id: manage.user_id,
      team_id: manage.team_id}
  end
end
