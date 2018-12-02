defmodule RedesignedPotato.Update.Server do
  use GenServer

  alias RedesignedPotato.Update
  alias RedesignedPotato.Update.State

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    {:ok, State.new(), timeout()}
  end

  def handle_info(:timeout, state) do
    {:noreply, Update.run(state), timeout()}
  end

  defp timeout do
    Application.get_env(:redesigned_potato, :update_timeout)
  end
end
