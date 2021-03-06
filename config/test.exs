use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :speak_easy_api, SpeakEasyApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
config :comeonin, :bcrypt_log_rounds, 4

# Configure your database
config :speak_easy_api, SpeakEasyApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "speak_easy_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
