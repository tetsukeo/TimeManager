defmodule App.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :timeManager,
                              module: App.Guardian,
                              error_handler: App.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end