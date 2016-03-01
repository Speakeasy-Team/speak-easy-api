# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :speak_easy_api, SpeakEasyApi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "J/opBeaxNfxSB2nvqY+ZYY6eYohepuOZDV8bvSVNdA0GI64ML38+pBrlC8yvv6s/",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: SpeakEasyApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :speak_easy_api,
  json_web_token_key: "gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr9C"

config :canary,
  repo: SpeakEasyApi.Repo,
  not_found_handler: {SpeakEasyApi.CanaryHelper, :handle_not_found},
  unauthorized_handler: {SpeakEasyApi.CanaryHelper, :handle_unauthorized}

config :ja_serializer, key_format: {:custom, SpeakEasyApi.Camelize, :pascalize}

config :plug, :mimes, %{ "application/vnd.api+json" => ["json-api"] }

import_config "#{Mix.env}.exs"
