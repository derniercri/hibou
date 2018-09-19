defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  # append_start %{after: ":router", check_value: "AuthorizationController"}
  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(MyApp.AuthAccessPipeline)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", MyAppWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/authorize", AuthorizationController, :new)
    post("/authorize", AuthorizationController, :create)
    resources("/registrations", RegistrationController, only: [:new, :create])
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    delete("/logout", SessionController, :delete)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/v1", MyAppWeb do
    pipe_through(:api)

    post("/auth/tokens", TokenController, :create)
  end

  # append_stop
end
