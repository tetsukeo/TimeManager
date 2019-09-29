defmodule App.Result do
  @moduledoc """
  The Result context.
  """

  import Ecto.Query, warn: false

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias App.Guardian

  alias App.Repo

  alias App.Result.User

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->

        {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end

    defp verify_password(password, %User{} = user) when is_binary(password) do
      if checkpw(password, user.password_hash) do
        {:ok, user}
      else
        {:error, :invalid_password}
      end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def user_by_email(email) do
    query = from c in User, where: c.email == ^email
    Repo.all(query)
  end

  def user_by_username(username) do
    query = from c in User, where: c.username == ^username
    Repo.all(query)
  end

  def user_by_email_and_username(email, username) do
    query = from c in User, where: c.email == ^email and c.username == ^username
    Repo.all(query)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias App.Result.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  def get_clock_by_userID!(userID) do
    query = from c in Clock, where: c.user_id == ^userID
    Repo.all(query)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}, userID) do
    %Clock{}
    |> Map.put(:user_id, String.to_integer(userID))
    |> Map.put(:status, true)
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{source: %Clock{}}

  """
  def change_clock(%Clock{} = clock) do
    Clock.changeset(clock, %{})
  end

  alias App.Result.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  def list_user_workingtimes!(userID) do
    query = from c in Workingtime, where: c.user_id == ^userID
    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_user_workingtimes_start!(userID, start) do
    query = from c in Workingtime, where: c.user_id == ^userID and c.start >= ^start
    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_user_workingtimes_end!(userID, clockEnd) do
    query = from c in Workingtime, where: c.user_id == ^userID and c.end <= ^clockEnd
    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_user_workingtimes_start_end!(userID, start, clockEnd) do
    query = from c in Workingtime, where: c.user_id == ^userID and c.start >= ^start and c.end <= ^clockEnd
    Repo.all(query)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  def get_workingtime_by_user(userID, workingtimeID) do
    query = from c in Workingtime, where: c.user_id == ^userID and c.id == ^workingtimeID
    Repo.one(query)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}, userID) do
    %Workingtime{}
    |> Map.put(:user_id, String.to_integer(userID))
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  def create_auto_workingtime(userID, clockStart, clockEnd) do
    obj = %{start: clockStart, end: clockEnd, user_id: userID}
    %Workingtime{}
    |> Workingtime.changeset(obj)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{source: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime) do
    Workingtime.changeset(workingtime, %{})
  end


  alias App.Result.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  def list_teams_name(name) do
    query = from c in Team, where: c.name == ^name
    Repo.all(query)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end

  alias App.Result.Member

  def add_member(userID, teamID) do
    obj = %{user_id: userID, team_id: teamID}
    %Member{}
    |> Member.changeset(obj)
    |> Repo.insert()
  end

  def add_manager(userID, teamID) do
    obj = %{user_id: userID, team_id: teamID, is_manager: true}
    %Member{}
    |> Member.changeset(obj)
    |> Repo.insert()
  end

  def set_to_manager(%Member{} = member, userID, teamID) do
    obj = %{user_id: userID, team_id: teamID, is_manager: true}
    member
    |> Member.changeset(obj)
    |> Repo.update()
  end

  def get_team_member(userID, teamID) do
    query = from c in Member, where: c.user_id == ^userID and c.team_id == ^teamID
    Repo.one(query)
  end

  def list_team_workingtimes(teamID) do
    query = from c in Workingtime, join: d in Member, on: c.user_id == d.user_id, where: d.team_id == ^teamID
    Repo.all(query)
  end

  def list_team_workingtimes_start(teamID, startClock) do
    query = from c in Workingtime, join: d in Member, on: c.user_id == d.user_id, where: d.team_id == ^teamID and c.start >= ^startClock
    Repo.all(query)
  end

  def list_team_workingtimes_end(teamID, endClock) do
    query = from c in Workingtime, join: d in Member, on: c.user_id == d.user_id, where: d.team_id == ^teamID and c.end <= ^endClock
    Repo.all(query)
  end

  def list_team_workingtimes_start_end(teamID, startClock, endClock) do
    query = from c in Workingtime, join: d in Member, on: c.user_id == d.user_id, where: d.team_id == ^teamID and c.start >= ^startClock and c.end <= ^endClock
    Repo.all(query)
  end

  def delete_member(%Member{} = member) do
    Repo.delete(member)
  end

end
