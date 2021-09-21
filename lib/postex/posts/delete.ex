defmodule Postex.Posts.Delete do
  alias Postex.{Repo, Post}

  def call(post_id) do
    case Repo.get(Post, post_id) do
      nil -> {:error, :not_found}
      post -> Repo.delete(post)
    end
  end
end
