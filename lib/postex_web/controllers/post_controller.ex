defmodule PostexWeb.PostsController do
  use PostexWeb, :controller

  alias PostexWeb.{PostView, ErrorView}
  alias Postex.{Post, Posts}

  def create(conn, %{"content" => content}) do
    with {:ok, post} <- Posts.Create.call(%Post{content: content, likes: 0, shares: 0}) do
      conn
      |> put_status(201)
      |> put_view(PostView)
      |> render("create.json", post: post)
    else
      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> put_view(ErrorView)
        |> render("post400.json")
    end
  end

  def show(conn, %{"id" => post_id}) do
    with {:ok, post} <- Posts.Show.call(post_id) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("show.json", post: post)
    else
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("post404.json")
    end
  end

  def delete(conn, %{"id" => post_id}) do
    with {:ok, _deleted_post} <- Posts.Delete.call(post_id) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("delete.json")
    else
      {:error, _invalid_changeset_or_not_found} ->
        conn
        |> put_status(400)
        |> put_view(ErrorView)
        |> render("post400.json")
    end
  end

  def update(conn, %{"id" => post_id, "likes" => new_likes, "shares" => new_shares}) do
    with {:ok, updated_post} <- Posts.Update.call(post_id, likes: new_likes, shares: new_shares) do
      conn
      |> put_status(200)
      |> put_view(PostView)
      |> render("show.json", post: updated_post)
    else
      {:error, _invalid_changeset_or_not_found} ->
        conn
        |> put_status(400)
        |> put_view(ErrorView)
        |> render("post400.json")
    end
  end
end
