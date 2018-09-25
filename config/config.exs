# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :palaute,
  ecto_repos: [Palaute.Repo]

# Configures the endpoint
config :palaute, PalauteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uM5Ku7xrZr5sJ54wj+KUV8hmGrB/e+bj7KjZtGiwJ2vTMBgbc0j2RPPv3a0qoVG8",
  render_errors: [view: PalauteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Palaute.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
