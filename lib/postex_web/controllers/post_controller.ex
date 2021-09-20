defmodule PostexWeb.PostController do
  use PostexWeb, :controller

  alias Postex.{Post, Posts}

  def create(conn, %{"content" => content}) do
    with {:ok, post} <- Posts.Create.call(%Post{content: content, likes: 0, shares: 0}) do
      conn
      |> put_status(201)
      |> json(%{message: "Post created!", id: post.id})
    else
      {:error, _changeset} -> json(conn, %{message: "Error creating post!"})
    end
  end

  def show(conn, %{"id" => post_id}) do
    case Posts.Show.call(post_id) do
      {:error, reason} ->
        conn
        |> put_status(404)
        |> json(%{message: reason})

      {:ok, post} ->
        conn
        |> put_status(:ok)
        |> json(%{
          id: post.id,
          content: post.content,
          likes: post.likes,
          shares: post.shares
        })
    end
  end
end
