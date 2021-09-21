defmodule Postex.Posts.Create do
  alias Postex.{Post, Repo}

  def call(params) do
    result =
      params
      |> Post.changeset()
      |> Repo.insert()

    case result do
      {:ok, _post} -> result
      {:error, _invalid_changeset} -> {:error, :invalid_data}
    end
  end
end
