use Mix.Config

# Configure your database
config :collaborative_filtering, CollaborativeFiltering.Repo,
  username: "postgres",
  password: "postgres",
  database: "collaborative_filtering_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :collaborative_filtering, CollaborativeFilteringWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
