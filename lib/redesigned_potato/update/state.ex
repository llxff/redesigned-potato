defmodule RedesignedPotato.Update.State do
  defstruct [:last_id]

  def new do
    %__MODULE__{}
  end

  def use_last_id(last_id) do
    %__MODULE__{last_id: last_id}
  end
end
