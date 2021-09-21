defmodule Postex.Posts.Show do
  alias Postex.{Post, Repo}

  def call(post_id) do
    case Repo.get(Post, post_id) do
      nil ->
        {:error, :not_found}

      post ->
        {:ok, post}
    end
  end
end
