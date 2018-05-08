use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hibou, HibouWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :hibou, Hibou.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: System.get_env("PGPASSWORD") || "postgres",
  database: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: System.get_env("PGPORT") || 35432,
  pool_size: 10

config :hibou, Hibou.Guardian,
  issuer: "hibou",
  secret_key: "IiyscTs4H35aVOd9+9aMe4R35oqeZtSyb0cTWp6T3dGydcTmork9RXnXpgoyFQz7"
