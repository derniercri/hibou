defmodule BlackgateWeb.Router do
  use BlackgateWeb, :router

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

  scope "/", BlackgateWeb do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/registrations", RegistrationController, only: [:new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlackgateWeb do
  #   pipe_through :api
  # end
end
