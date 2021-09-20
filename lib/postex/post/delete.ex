defmodule Postex.Posts.Delete do
  alias Postex.{Repo, Post}

  def call(post_id) do
    case Repo.delete(Post, String.to_integer(post_id)) do
      {:ok, %Post{} = post} -> {:ok, post}
      {:error, _changeset} -> {:error, "Can't delete post #{post_id}"}
    end
  end
end
