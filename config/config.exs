# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chess_ground,
  ecto_repos: [ChessGround.Repo]

# Configures the endpoint
config :chess_ground, ChessGroundWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JLw31IwdX/PxZHKe+jRMfyCu/gbrMGNnVrzagcSKrrymnwjzQPazTlgvlnZny6bK",
  render_errors: [view: ChessGroundWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ChessGround.PubSub,
  live_view: [signing_salt: "jzIzsZWZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
