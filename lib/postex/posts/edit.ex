defmodule Postex.Posts.Edit do
  alias Postex.{Post, Repo}

  def call(post_id, content: new_content) do
    case Repo.get(Post, post_id) do
      nil ->
        {:error, :not_found}

      post_to_edit ->
        case Ecto.Changeset.change(post_to_edit, content: new_content, edited: true)
             |> Repo.update() do
          {:ok, updated_post} ->
            {:ok, updated_post}

          {:error, _invalid_changeset} ->
            {:error, :invalid_data}
        end
    end
  end
end
