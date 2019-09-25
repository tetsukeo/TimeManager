defmodule AppWeb.MemberView do
  use AppWeb, :view
  alias AppWeb.MemberView

  def render("index.json", %{member: member}) do
    render_many(member, MemberView, "member.json")
  end

  def render("show.json", %{member: member}) do
    render_one(member, MemberView, "member.json")
  end

  def render("member.json", %{member: member}) do
    %{id: member.id,
      user_id: member.user_id,
      team_id: member.team_id}
  end
end
