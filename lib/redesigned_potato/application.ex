defmodule RedesignedPotato.Application do
  use Application

  def start(_type, _args) do
    children = [
      RedesignedPotato.Repo,
      RedesignedPotato.Import.Server,
      RedesignedPotato.Update.Server
    ]

    opts = [strategy: :one_for_one, name: RedesignedPotato.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
