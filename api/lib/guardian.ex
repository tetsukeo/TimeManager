defmodule App.Guardian do
  use Guardian, otp_app: :timeManager

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    user_username = user.username
    user_email = user.email
    {:ok, [sub, user_username, user_email]}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = List.first(claims["sub"])
    resource = App.Result.get_user!(id)
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end