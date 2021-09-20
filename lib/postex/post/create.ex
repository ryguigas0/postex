defmodule Postex.Posts.Create do
  alias Postex.{Post, Repo}

  def call(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
  end
end
