# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :hospital, Hospital.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "I41XRJZySrzMmz3uWWC2RC0fRwPGnNSQ1pWF7G7m63/15WLoCn422rMHLquR3W6l",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Hospital.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :joken, config_module: Guardian.JWT

config :guardian, Guardian,
      issuer: "Hospital",
      ttl: { 100_000, :days },
      verify_issuer: true,
      secret_key: "random secret key",
      serializer: Hospital.GuardianSerializer,
      permissions: %{
         default: [:read, :write],
         medic: [:read, :write]
       }
