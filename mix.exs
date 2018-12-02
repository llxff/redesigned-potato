defmodule RedesignedPotato.MixProject do
  use Mix.Project

  def project do
    [
      app: :redesigned_potato,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {RedesignedPotato.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]

  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:extwitter, "~> 0.9"},
      {:timex, "~> 3.4"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:exvcr, "~> 0.10", only: :test},
      {:ex_machina, "~> 2.2", only: :test}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
