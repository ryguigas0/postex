defmodule PostexWeb.PostsController do
  use PostexWeb, :controller

  action_fallback PostexWeb.PostFallbackController

  alias PostexWeb.PostView
  alias Postex.{Post, Posts}

  def create(conn, %{"content" => content}) do
    with {:ok, post} <-
           Posts.Create.call(%Post{content: content, likes: 0, shares: 0, edited: false}) do
      conn
      |> put_status(201)
      |> put_view(PostView)
      |> render("create.json", post: post)
    end
  end

  def show(conn, %{"id" => post_id}) do
    with {:ok, post} <- Posts.Show.call(post_id) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("show.json", post: post)
    end
  end

  def delete(conn, %{"id" => post_id}) do
    with {:ok, _deleted_post} <- Posts.Delete.call(post_id) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("delete.json")
    end
  end

  def update(conn, %{"id" => post_id, "likes" => new_likes, "shares" => new_shares}) do
    with {:ok, updated_post} <- Posts.Update.call(post_id, likes: new_likes, shares: new_shares) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("show.json", post: updated_post)
    end
  end

  def edit(conn, %{"id" => post_id, "content" => new_content}) do
    with {:ok, updated_post} <- Posts.Edit.call(post_id, content: new_content) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("show.json", post: updated_post)
    end
  end
end
