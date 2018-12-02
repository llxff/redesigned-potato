defmodule RedesignedPotato.Tweet do
  use Ecto.Schema

  schema "tweets" do
    field :author_id, :integer
    field :author_name, :string
    field :text, :string
    field :created_at, :naive_datetime
    field :retweet_count, :integer

    timestamps()
  end
end
