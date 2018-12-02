defmodule RedesignedPotato.TweetQuery do
  import Ecto.Query

  alias RedesignedPotato.{Repo, Tweet}

  def get_last_id do
    Tweet
    |> last()
    |> select([t], t.id)
    |> Repo.one()
  end

  def ids_batch(nil, amount) do
    ids_batch_query(Tweet, amount)
  end

  def ids_batch(max_id, amount) do
    Tweet
    |> where([t], t.id < ^max_id)
    |> ids_batch_query(amount)
  end

  defp ids_batch_query(base_query, amount) do
    base_query
    |> order_by(desc: :id)
    |> select([t], t.id)
    |> limit(^amount)
    |> Repo.all()
  end

  def upsert(tweets) do
    Repo.insert_all(
      Tweet,
      tweets,
      conflict_target: :id,
      on_conflict: {:replace, [:retweet_count, :updated_at]}
    )
  end
end
