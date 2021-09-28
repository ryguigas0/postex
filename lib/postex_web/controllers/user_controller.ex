defmodule PostexWeb.UserController do
  use PostexWeb, :controller

  action_fallback PostexWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Postex.create_user(%{email: email, password: password}) do
      response(conn, 201, "show.json", %{user: user})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Postex.show_user(id) do
      response(conn, 200, "show.json", %{user: user})
    end
  end

  defp response(conn, status, template, args) when is_map(args) do
    conn
    |> put_status(status)
    |> put_view(PostexWeb.UserView)
    |> render(template, args)
  end
end
