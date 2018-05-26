# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hibou_example, ecto_repos: [HibouExample.Repo]

# Configures the endpoint
config :hibou_example, HibouExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "21c0KO6/X6V4LdxYQ664Ii9PDLE+NsG9R+Mv5DjgOfbGbxRT7+RVgsa6KgxuDGo7",
  render_errors: [view: HibouExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HibouExample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :hibou,
  repo: HibouExample.Repo,
  guardian: HibouExample.Guardian

config :hibou, Hibou.AuthAccessPipeline,
  module: Hibou.Guardian,
  error_handler: Hibou.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
