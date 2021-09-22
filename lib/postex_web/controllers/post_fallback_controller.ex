defmodule PostexWeb.PostFallbackController do
  use PostexWeb, :controller

  alias PostexWeb.ErrorView

  def call(conn, {:error, :invalid_data}) do
    conn
    |> put_status(400)
    |> put_view(ErrorView)
    |> render("post400.json")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ErrorView)
    |> render("post404.json")
  end

  def call(conn, {:error, :no_post}) do
    conn
    |> put_status(200)
    |> json(%{
      message: "No posts found!"
    })
  end
end
