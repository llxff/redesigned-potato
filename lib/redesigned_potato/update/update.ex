defmodule RedesignedPotato.Update do
  alias RedesignedPotato.Update.State
  alias RedesignedPotato.{TwitterApi, TweetSerializer, TweetQuery}

  @batch_amount 100

  def run(%State{last_id: last_id}) do
    ids = TweetQuery.ids_batch(last_id, @batch_amount)

    ids
    |> update_tweets()
    |> new_state(ids)
  end

  defp update_tweets([]) do
    {0, nil}
  end

  defp update_tweets(ids) do
    ids
    |> TwitterApi.tweets()
    |> TweetSerializer.serialize()
    |> TweetQuery.upsert()
  end

  defp new_state({len, nil}, _ids) when len < @batch_amount do
    State.new()
  end

  defp new_state(_result, ids) do
    ids
    |> List.last()
    |> State.use_last_id()
  end
end
