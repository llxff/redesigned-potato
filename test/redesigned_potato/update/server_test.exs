defmodule RedesignedPotato.Update.ServerTest do
  use RedesignedPotato.DataCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  import RedesignedPotato.Factory

  alias RedesignedPotato.{Repo, Tweet}
  alias RedesignedPotato.Update.{State, Server}

  describe "init/1" do
    test "init with timeout and new state" do
      assert {:ok, %State{}, 3000} = Server.init(nil)
    end
  end

  describe "handle_info/2" do
    test "no tweets" do
      assert {
               :noreply,
               %State{last_id: nil},
               3000
             } = Server.handle_info(:timeout, State.new())

      assert 0 == Repo.aggregate(Tweet, :count, :id)
    end

    test "one tweet" do
      use_cassette "update_server_one_tweet" do
        %Tweet{id: tweet_id} = insert(:tweet, id: 1_069_210_901_423_763_457, retweet_count: 1)

        assert {
                 :noreply,
                 %State{last_id: nil},
                 3000
               } = Server.handle_info(:timeout, State.new())

        assert %Tweet{retweet_count: 327} = Repo.get(Tweet, tweet_id)
      end
    end
  end
end
