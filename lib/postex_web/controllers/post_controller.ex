defmodule PostexWeb.PostsController do
  use PostexWeb, :controller

  action_fallback PostexWeb.PostFallbackController

  alias PostexWeb.PostView
  alias Postex.Post

  def create(conn, %{"content" => content}) do
    with {:ok, post} <-
           Postex.create_post(%Post{content: content, likes: 0, shares: 0, edited: false}) do
      response(conn, 201, "create.json", post: post)
    end
  end

  def show(conn, %{"id" => post_id}) do
    with {:ok, post} <- Postex.show_post(post_id) do
      response(conn, 200, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => post_id}) do
    with {:ok, _deleted_post} <- Postex.delete_post(post_id) do
      response(conn, 201, "delete.json")
    end
  end

  def update(conn, %{"id" => post_id, "likes" => new_likes, "shares" => new_shares}) do
    with {:ok, updated_post} <- Postex.update_post(post_id, likes: new_likes, shares: new_shares) do
      response(conn, 200, "show.json", post: updated_post)
    end
  end

  def edit(conn, %{"id" => post_id, "content" => new_content}) do
    with {:ok, edited_post} <- Postex.edit_post(post_id, content: new_content) do
      response(conn, 201, "show.json", post: edited_post)
    end
  end

  defp response(conn, status, template, args \\ []) do
    conn
    |> put_status(status)
    |> put_view(PostView)
    |> render(template, args)
  end
end
