defmodule RedesignedPotato.TweetSerializer do
  alias ExTwitter.Model.{Tweet, User}

  def serialize([]), do: []

  def serialize(tweets) when is_list(tweets) do
    Enum.map(tweets, &serialize/1)
  end

  def serialize(%Tweet{
        id: id,
        text: text,
        created_at: created_at,
        retweet_count: retweet_count,
        user: %User{id: author_id, screen_name: author_name}
      }) do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

    %{
      id: id,
      text: text,
      created_at: Timex.parse!(created_at, "%a %b %d %H:%M:%S +0000 %Y", :strftime),
      author_id: author_id,
      author_name: author_name,
      retweet_count: retweet_count,
      inserted_at: now,
      updated_at: now
    }
  end
end
