# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :my_app, ecto_repos: [MyApp.Repo]

# Configures the endpoint
config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "21c0KO6/X6V4LdxYQ664Ii9PDLE+NsG9R+Mv5DjgOfbGbxRT7+RVgsa6KgxuDGo7",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MyApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# append_start %{after: "use Mix.Config", check_value: "config :hibou,"}
config :hibou,
  repo: MyApp.Repo,
  guardian: MyApp.Guardian,
  storage: Hibou.StorageEcto,
  user_model: Hibou.Model.User,
  client_model: Hibou.Model.Client,
  authorization_model: Hibou.Model.Authorization

config :my_app, MyApp.AuthAccessPipeline,
  module: MyApp.Guardian,
  error_handler: MyApp.AuthErrorHandler

config :my_app, MyApp.Guardian,
  issuer: "my_app",
  secret_key: "IiyscTs4H35aVOd9+9aMe4R35oqeZtSyb0cTWp6T3dGydcTmork9RXnXpgoyFQz7"

# append_stop

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
