defmodule AppWeb.MemberView do
  use AppWeb, :view
  alias AppWeb.MemberView

  def render("index.json", %{members: members}) do
    render_many(members, MemberView, "member.json")
  end

  def render("show.json", %{member: member}) do
    render_one(member, MemberView, "member.json")
  end

  def render("member.json", %{member: member}) do
    %{user: member.user_id,
      team: member.team_id}
  end
end
