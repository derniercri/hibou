# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hibou, ecto_repos: [Hibou.Repo]

# Configures the endpoint
config :hibou, HibouWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2qXZ0OPfpkIeWZwhhG/Uf56cI8YQuNjYi0e99lAx3vzerhn3mah7cHkZzRVmVoPh",
  render_errors: [view: HibouWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hibou.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :hibou, Hibou.AuthAccessPipeline,
  module: Hibou.Guardian,
  error_handler: Hibou.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
