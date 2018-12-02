defmodule RedesignedPotato.TwitterApi do
  def tweets(ids) do
    ids
    |> Enum.join(",")
    |> ExTwitter.lookup_status()
  end

  def mentions(%{} = metadata) do
    ExTwitter.search_next_page(metadata)
  end

  def mentions(since_id, amount) do
    ExTwitter.search(user(),
      result_type: :recent,
      search_metadata: true,
      since_id: since_id,
      count: amount
    )
  end

  defp user do
    Application.get_env(:redesigned_potato, :user)
  end
end
