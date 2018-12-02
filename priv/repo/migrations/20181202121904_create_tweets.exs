defmodule RedesignedPotato.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create(table(:tweets)) do
      add :author_id, :bigserial
      add :author_name, :string
      add :text, :text
      add :created_at, :naive_datetime
      add :retweet_count, :integer

      timestamps()
    end
  end
end
