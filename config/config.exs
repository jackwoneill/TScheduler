# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sched,
  ecto_repos: [Sched.Repo]

# Configures the endpoint
config :sched, Sched.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y6AGspV+fCTX6+f5oVRt86Vm4PtKITNwgCDexg5HxZTvh4GFRkyySqwkBD0gQ4hx",
  render_errors: [view: Sched.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sched.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :addict,
  secret_key: "24326224313224515031535965702f6744684732673142492e64336c4f",
  extra_validation: fn ({valid, errors}, user_params) -> {valid, errors} end, # define extra validation here
  user_schema: Sched.User,
  repo: Sched.Repo,
  from_email: "no-reply@example.com", # CHANGE THIS
  mail_service: nil


  config :quantum, cron: [
      # Every minute check for posts
      "* * * * *": {"Sched.ScheduleHelper", :check_for_items}
  ]