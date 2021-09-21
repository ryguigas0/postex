defmodule Postex.Posts.Update do
  alias Postex.{Post, Repo}

  def call(post_id, likes: new_likes, shares: new_shares) do
    new_likes = String.to_integer(new_likes)
    new_shares = String.to_integer(new_shares)

    case Repo.get(Post, post_id) do
      nil ->
        {:error, :not_found}

      post_to_update ->
        Ecto.Changeset.change(post_to_update, likes: new_likes, shares: new_shares)
        |> Repo.update()
    end
  end
end
