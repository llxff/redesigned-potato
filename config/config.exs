use Mix.Config

config :redesigned_potato, ecto_repos: [RedesignedPotato.Repo]

config :redesigned_potato,
  user: "@F1",
  # 450 requests / 15-min window
  import_timeout: div(60 * 15 * 1000, 450),
  # 300 requests / 15-min window
  update_timeout: div(60 * 15 * 1000, 300)

import_config "#{Mix.env()}.exs"
