defmodule Postex.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string
      add :likes, :integer
      add :shares, :integer

      timestamps()
    end

  end
end
