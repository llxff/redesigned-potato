defmodule RedesignedPotato.Factory do
  use ExMachina.Ecto, repo: RedesignedPotato.Repo

  alias RedesignedPotato.Tweet

  def tweet_factory do
    %Tweet{
      author_id: :rand.uniform(100_000_000),
      author_name: sequence("author"),
      text: sequence("text"),
      created_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      retweet_count: :rand.uniform(100)
    }
  end
end
