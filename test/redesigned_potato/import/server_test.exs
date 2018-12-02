defmodule RedesignedPotato.Import.ServerTest do
  use RedesignedPotato.DataCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  import RedesignedPotato.Factory

  alias RedesignedPotato.{Repo, Tweet}
  alias RedesignedPotato.Import.{State, Server}

  describe "init/1" do
    test "init with timeout and new state" do
      assert {:ok, %State{}, 2000} = Server.init(nil)
    end
  end

  describe "handle_info/2" do
    test "import tweets with fresh database" do
      use_cassette "import_server_empty_state" do
        assert {
                 :noreply,
                 %State{
                   metadata: %{
                     count: 100,
                     next_results: <<_::binary>>,
                     since_id: 0
                   },
                   since_id: nil
                 },
                 2000
               } = Server.handle_info(:timeout, State.new())

        assert 100 == Repo.aggregate(Tweet, :count, :id)
      end
    end

    test "empty page and no tweets in the database" do
      use_cassette "import_server_empty_page" do
        state = %State{
          metadata: %{next_results: ""},
          since_id: nil
        }

        assert {
                 :noreply,
                 %State{since_id: nil, metadata: nil},
                 2000
               } == Server.handle_info(:timeout, state)

        assert 0 == Repo.aggregate(Tweet, :count, :id)
      end
    end

    test "empty page and has tweets in the database" do
      use_cassette "import_server_empty_page" do
        %Tweet{id: tweet_id} = insert(:tweet)

        state = %State{
          metadata: %{next_results: ""},
          since_id: nil
        }

        assert {
                 :noreply,
                 %State{since_id: tweet_id, metadata: nil},
                 2000
               } == Server.handle_info(:timeout, state)

        assert 1 == Repo.aggregate(Tweet, :count, :id)
      end
    end
  end
end
