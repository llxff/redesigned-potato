defmodule RedesignedPotato.TweetQueryTest do
  use RedesignedPotato.DataCase, async: false

  import RedesignedPotato.Factory

  alias RedesignedPotato.{TweetQuery, Tweet, Repo}

  describe "get_last_id/0" do
    test "with empty table" do
      assert is_nil(TweetQuery.get_last_id())
    end

    test "with some tweets" do
      insert(:tweet)
      %{id: last_tweet_id} = insert(:tweet)

      assert last_tweet_id == TweetQuery.get_last_id()
    end
  end

  describe "ids_batch/2" do
    test "with empty table" do
      assert [] == TweetQuery.ids_batch(nil, 100)
    end

    test "max_id is nil" do
      [%Tweet{id: second_id}, %Tweet{id: first_id}] = insert_list(2, :tweet)

      assert [first_id, second_id] == TweetQuery.ids_batch(nil, 100)
    end

    test "with max_id" do
      [%Tweet{id: second_id}, %Tweet{id: first_id}] = insert_list(2, :tweet)

      assert [second_id] == TweetQuery.ids_batch(first_id, 100)
    end
  end

  describe "upsert/1" do
    setup do
      {:ok,
       tweet_data: %{
         id: 1,
         text: "text",
         created_at: ~N[2018-11-19 09:54:40],
         retweet_count: 1,
         author_id: 2,
         author_name: "user",
         inserted_at: ~N[2018-11-19 10:00:00],
         updated_at: ~N[2018-11-19 10:00:00]
       }}
    end

    test "insert new tweet", %{tweet_data: tweet_data} do
      assert {1, nil} = TweetQuery.upsert([tweet_data])
      assert 1 == Repo.aggregate(Tweet, :count, :id)
    end

    test "update tweet retweet_count and updated_at", %{
      tweet_data:
        %{
          id: tweet_id,
          retweet_count: retweet_count,
          updated_at: updated_at
        } = tweet_data
    } do
      %Tweet{inserted_at: old_inserted_at} = insert(:tweet, id: tweet_id)

      assert {1, nil} = TweetQuery.upsert([tweet_data])
      assert 1 == Repo.aggregate(Tweet, :count, :id)

      assert %Tweet{
               retweet_count: ^retweet_count,
               inserted_at: ^old_inserted_at,
               updated_at: ^updated_at
             } = Repo.get(Tweet, tweet_id)
    end
  end
end
