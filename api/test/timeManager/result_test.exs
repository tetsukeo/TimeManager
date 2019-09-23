defmodule App.ResultTest do
  use App.DataCase

  alias App.Result

  describe "users" do
    alias App.Result.User

    @valid_attrs %{"": "some ", email: "some email", username: "some username"}
    @update_attrs %{"": "some updated ", email: "some updated email", username: "some updated username"}
    @invalid_attrs %{"": nil, email: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Result.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Result.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Result.create_user(@valid_attrs)
      assert user. == "some "
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Result.update_user(user, @update_attrs)
      assert user. == "some updated "
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_user(user, @invalid_attrs)
      assert user == Result.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Result.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Result.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Result.change_user(user)
    end
  end

  describe "clocks" do
    alias App.Result.Clock

    @valid_attrs %{status: true, time: ~D[2010-04-17]}
    @update_attrs %{status: false, time: ~D[2011-05-18]}
    @invalid_attrs %{status: nil, time: nil}

    def clock_fixture(attrs \\ %{}) do
      {:ok, clock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_clock()

      clock
    end

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Result.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Result.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      assert {:ok, %Clock{} = clock} = Result.create_clock(@valid_attrs)
      assert clock.status == true
      assert clock.time == ~D[2010-04-17]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{} = clock} = Result.update_clock(clock, @update_attrs)
      assert clock.status == false
      assert clock.time == ~D[2011-05-18]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_clock(clock, @invalid_attrs)
      assert clock == Result.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Result.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Result.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Result.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias App.Result.Workingtime

    @valid_attrs %{end: ~D[2010-04-17], start: ~D[2010-04-17]}
    @update_attrs %{end: ~D[2011-05-18], start: ~D[2011-05-18]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtime_fixture(attrs \\ %{}) do
      {:ok, workingtime} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_workingtime()

      workingtime
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Result.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Result.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      assert {:ok, %Workingtime{} = workingtime} = Result.create_workingtime(@valid_attrs)
      assert workingtime.end == ~D[2010-04-17]
      assert workingtime.start == ~D[2010-04-17]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{} = workingtime} = Result.update_workingtime(workingtime, @update_attrs)
      assert workingtime.end == ~D[2011-05-18]
      assert workingtime.start == ~D[2011-05-18]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Result.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Result.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Result.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Result.change_workingtime(workingtime)
    end
  end

  describe "teams" do
    alias App.Result.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Result.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Result.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Result.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = Result.update_team(team, @update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_team(team, @invalid_attrs)
      assert team == Result.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Result.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Result.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Result.change_team(team)
    end
  end

  describe "manage" do
    alias App.Result.Manage

    @valid_attrs %{team_id: 42, user_id: 42}
    @update_attrs %{team_id: 43, user_id: 43}
    @invalid_attrs %{team_id: nil, user_id: nil}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_manage()

      manage
    end

    test "list_manage/0 returns all manage" do
      manage = manage_fixture()
      assert Result.list_manage() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Result.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Result.create_manage(@valid_attrs)
      assert manage.team_id == 42
      assert manage.user_id == 42
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{} = manage} = Result.update_manage(manage, @update_attrs)
      assert manage.team_id == 43
      assert manage.user_id == 43
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_manage(manage, @invalid_attrs)
      assert manage == Result.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Result.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Result.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Result.change_manage(manage)
    end
  end

  describe "member" do
    alias App.Result.Member

    @valid_attrs %{team_id: 42, user_id: 42}
    @update_attrs %{team_id: 43, user_id: 43}
    @invalid_attrs %{team_id: nil, user_id: nil}

    def member_fixture(attrs \\ %{}) do
      {:ok, member} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_member()

      member
    end

    test "list_member/0 returns all member" do
      member = member_fixture()
      assert Result.list_member() == [member]
    end

    test "get_member!/1 returns the member with given id" do
      member = member_fixture()
      assert Result.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      assert {:ok, %Member{} = member} = Result.create_member(@valid_attrs)
      assert member.team_id == 42
      assert member.user_id == 42
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_member(@invalid_attrs)
    end

    test "update_member/2 with valid data updates the member" do
      member = member_fixture()
      assert {:ok, %Member{} = member} = Result.update_member(member, @update_attrs)
      assert member.team_id == 43
      assert member.user_id == 43
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = member_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_member(member, @invalid_attrs)
      assert member == Result.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = member_fixture()
      assert {:ok, %Member{}} = Result.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Result.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = member_fixture()
      assert %Ecto.Changeset{} = Result.change_member(member)
    end
  end
end
