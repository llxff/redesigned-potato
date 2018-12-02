use Mix.Config

config :extwitter, :oauth,
  consumer_key: "mYnYiRBvpQUdPEumBKWlzybpK",
  consumer_secret: "Tah3YhyuHNNI3UNPNHMK48hBhvSDbM2heBGQXdRrdeuGqDJLxV"

config :redesigned_potato, RedesignedPotato.Repo,
  database: "redesigned_potato_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"
