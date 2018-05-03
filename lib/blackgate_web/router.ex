defmodule HibouWeb.Router do
  use HibouWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HibouWeb do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/authorize", AuthorizationController, only: [:new, :create])
    resources("/registrations", RegistrationController, only: [:new, :create])
    resources("/login", SessionController, only: [:new, :create])
    delete("/logout", SessionController, :delete)
  end

  # Other scopes may use custom stacks.
  scope "/v1", HibouWeb do
    pipe_through(:api)

    post("/auth/tokens", AuthorizationController, :create)
  end
end
