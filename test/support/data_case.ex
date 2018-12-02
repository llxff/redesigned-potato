defmodule RedesignedPotato.DataCase do
  use ExUnit.CaseTemplate

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(RedesignedPotato.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(RedesignedPotato.Repo, {:shared, self()})
    end

    :ok
  end
end
