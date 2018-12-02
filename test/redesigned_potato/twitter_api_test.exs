defmodule RedesignedPotato.TwitterApiTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  alias RedesignedPotato.TwitterApi
  alias ExTwitter.Model.{SearchResponse, Tweet}

  describe "mentions/1" do
    setup do
      {:ok,
       metadata: %{
         next_results:
           "?max_id=1069210912165453824&q=%40F1&count=1&include_entities=1&result_type=recent"
       }}
    end

    test "with metadata", %{metadata: metadata} do
      use_cassette "twitter_api_mentions_2_metadata" do
        assert %SearchResponse{
                 metadata: %{
                   count: 1,
                   next_results: <<_::binary>>
                 },
                 statuses: [
                   %Tweet{}
                 ]
               } = TwitterApi.mentions(metadata)
      end
    end
  end

  describe "mentions/2" do
    setup do
      {:ok, since_id: 1_069_210_912_165_453_825}
    end

    test "since_id is nil" do
      use_cassette "twitter_api_mentions_2_empty_since_id" do
        assert %SearchResponse{
                 metadata: %{
                   count: 1,
                   since_id: 0
                 },
                 statuses: [
                   %Tweet{}
                 ]
               } = TwitterApi.mentions(nil, 1)
      end
    end

    test "since_id is defined", %{since_id: since_id} do
      use_cassette "twitter_api_mentions_2_since_id_id_defined" do
        assert %SearchResponse{
                 metadata: %{
                   count: 1,
                   since_id: ^since_id
                 },
                 statuses: [
                   %Tweet{}
                 ]
               } = TwitterApi.mentions(since_id, 1)
      end
    end
  end

  describe "ids/1" do
    setup do
      {:ok, tweet_id: 1_069_210_901_423_763_457}
    end

    test "with one tweet", %{tweet_id: tweet_id} do
      use_cassette "twitter_api_ids_1" do
        assert [
                 %Tweet{
                   id: ^tweet_id
                 }
               ] = TwitterApi.tweets([tweet_id])
      end
    end
  end
end
