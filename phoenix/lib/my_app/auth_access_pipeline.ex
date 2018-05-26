defmodule MyApp.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :my_app

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
