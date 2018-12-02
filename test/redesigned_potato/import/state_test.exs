defmodule RedesignedPotato.Import.StateTest do
  use ExUnit.Case, async: false

  alias RedesignedPotato.Import.State

  describe "new/0" do
    test "new state" do
      assert %State{since_id: nil, metadata: nil} == State.new()
    end
  end

  describe "use_metadata/2" do
    test "update state" do
      metadata = %{key: :value}

      assert %State{since_id: nil, metadata: metadata} == State.use_metadata(metadata)
    end
  end

  describe "use_since_id/2" do
    test "update state" do
      since_id = 2

      assert %State{since_id: since_id, metadata: nil} == State.use_since_id(since_id)
    end
  end
end
