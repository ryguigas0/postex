defmodule PostexWeb.PostsController do
  use PostexWeb, :controller

  action_fallback PostexWeb.FallbackController

  alias PostexWeb.PostView

  def create(conn, %{"content" => content}) do
    with {:ok, post} <-
           Postex.create_post(content) do
      response(conn, 201, "show.json", post: post)
    end
  end

  def show(conn, %{"id" => post_id}) do
    with {:ok, post} <- Postex.show_post(post_id) do
      response(conn, 200, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => post_id}) do
    with {:ok, _deleted_post} <- Postex.delete_post(post_id) do
      response(conn, 200, "delete.json")
    end
  end

  def update(conn, %{"id" => post_id, "likes" => new_likes, "shares" => new_shares}) do
    with {:ok, updated_post} <- Postex.update_post(post_id, likes: new_likes, shares: new_shares) do
      response(conn, 200, "show.json", post: updated_post)
    end
  end

  def edit(conn, %{"id" => post_id, "content" => new_content}) do
    with {:ok, edited_post} <- Postex.edit_post(post_id, content: new_content) do
      response(conn, 200, "show.json", post: edited_post)
    end
  end

  def index(conn, %{"size" => size, "rule" => rule}) do
    batch_size = size |> String.to_integer()

    with {:ok, post_list} <- Postex.get_posts(batch_size, rule) do
      if length(post_list) > 0 do
        response(conn, 200, "show_many.json", post_list: post_list, rule: rule)
      end
    end
  end

  defp response(conn, status, template, args \\ []) do
    conn
    |> put_status(status)
    |> put_view(PostView)
    |> render(template, args)
  end
end
