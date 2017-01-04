use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :sched, Sched.Endpoint,
  secret_key_base: "Lqhz2bcgzV9cXnW4ilZfIeoivdf1qYx0wUfv22+o3o/HRi0N/yP8zWLXXa4nL7Ll"

# Configure your database
config :sched, Sched.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "sched_prod",
  pool_size: 20
