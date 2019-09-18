defmodule AppWeb.WorkingtimeView do
  use AppWeb, :view
  alias AppWeb.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    render_many(workingtimes, WorkingtimeView, "workingtime.json")
  end

  def render("show.json", %{workingtime: workingtime}) do
    render_one(workingtime, WorkingtimeView, "workingtime.json")
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end}
  end
end
