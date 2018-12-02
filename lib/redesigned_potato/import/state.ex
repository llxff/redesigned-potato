defmodule RedesignedPotato.Import.State do
  defstruct [:since_id, :metadata]

  def new do
    %__MODULE__{}
  end

  def use_metadata(metadata) do
    %__MODULE__{metadata: metadata, since_id: nil}
  end

  def use_since_id(since_id) do
    %__MODULE__{metadata: nil, since_id: since_id}
  end
end
