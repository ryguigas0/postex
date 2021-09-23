defmodule Postex.Posts.Create do
  alias Postex.{Post, Repo}

  def call(content) do
    result =
      %Post{content: content}
      |> Post.changeset()
      |> Repo.insert()

    case result do
      {:ok, _post} -> result
      {:error, %Ecto.Changeset{valid?: false}} -> {:error, :invalid_data}
    end
  end
end
