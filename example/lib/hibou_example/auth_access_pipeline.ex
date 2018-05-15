defmodule HibouExample.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :hibou_example

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
