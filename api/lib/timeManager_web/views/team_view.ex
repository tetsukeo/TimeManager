defmodule AppWeb.TeamView do
  use AppWeb, :view
  alias AppWeb.TeamView

  def render("index.json", %{teams: teams}) do
    render_many(teams, TeamView, "team.json")
  end

  def render("show.json", %{team: team}) do
    render_one(team, TeamView, "team.json")
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name}
  end
end
