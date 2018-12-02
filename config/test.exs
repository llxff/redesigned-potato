use Mix.Config

config :logger, level: :warn

config :extwitter, :oauth,
  consumer_key: "mYnYiRBvpQUdPEumBKWlzybpK",
  consumer_secret: "Tah3YhyuHNNI3UNPNHMK48hBhvSDbM2heBGQXdRrdeuGqDJLxV"

config :redesigned_potato, RedesignedPotato.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "redesigned_potato_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"
