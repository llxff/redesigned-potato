defmodule RedesignedPotato.Import do
  alias RedesignedPotato.Import.State
  alias RedesignedPotato.{TwitterApi, TweetSerializer, TweetQuery}

  @batch_amount 100

  def run(%State{since_id: nil, metadata: nil} = state) do
    TweetQuery.get_last_id()
    |> TwitterApi.mentions(@batch_amount)
    |> save_tweets_and_update_state(state)
  end

  def run(%State{since_id: since_id, metadata: nil} = state) do
    since_id
    |> TwitterApi.mentions(@batch_amount)
    |> save_tweets_and_update_state(state)
  end

  def run(%State{metadata: metadata} = state) do
    metadata
    |> TwitterApi.mentions()
    |> save_tweets_and_update_state(state)
  end

  defp save_tweets_and_update_state(%{metadata: metadata, statuses: tweets}, state) do
    save_tweets(tweets)
    update_state(metadata, state)
  end

  defp save_tweets(tweets) do
    tweets
    |> TweetSerializer.serialize()
    |> TweetQuery.upsert()
  end

  defp update_state(%{next_results: results} = metadata, _state) when not is_nil(results) do
    State.use_metadata(metadata)
  end

  defp update_state(_metadata, %State{since_id: nil}) do
    State.use_since_id(TweetQuery.get_last_id())
  end

  defp update_state(_metadata, %State{since_id: since_id}) do
    State.use_since_id(since_id)
  end
end
