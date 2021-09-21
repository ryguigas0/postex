defmodule Postex.Posts.Edit do
  alias Postex.{Post, Repo}

  def call(post_id, content: new_content) do
    case Repo.get(Post, post_id) do
      nil ->
        {:error, :not_found}

      post_to_update ->
        Ecto.Changeset.change(post_to_update, content: new_content, edited: true)
        |> Repo.update()
    end
  end
end
