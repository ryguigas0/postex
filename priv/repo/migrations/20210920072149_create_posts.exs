defmodule Postex.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :likes, :integer
      add :shares, :integer
      add :edited, :boolean

      timestamps()
    end

  end
end
