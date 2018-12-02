defmodule RedesignedPotato.TweetSerializerTest do
  use ExUnit.Case, async: false

  alias ExTwitter.Model.{Tweet, User}
  alias RedesignedPotato.TweetSerializer

  describe "serialize/1" do
    setup do
      {:ok,
       tweet: %Tweet{
         id: 1,
         text: "text",
         created_at: "Mon Nov 19 09:54:40 +0000 2018",
         retweet_count: 1,
         user: %User{id: 2, screen_name: "user"}
       }}
    end

    test "with empty list" do
      assert [] = TweetSerializer.serialize([])
    end

    test "with list of tweets", %{tweet: tweet} do
      assert [
               %{
                 id: 1,
                 text: "text",
                 created_at: ~N[2018-11-19 09:54:40],
                 retweet_count: 1,
                 author_id: 2,
                 author_name: "user"
               }
             ] = TweetSerializer.serialize([tweet])
    end

    test "with one tweet", %{tweet: tweet} do
      assert %{
               id: 1,
               text: "text",
               created_at: ~N[2018-11-19 09:54:40],
               retweet_count: 1,
               author_id: 2,
               author_name: "user"
             } = TweetSerializer.serialize(tweet)
    end
  end
end
