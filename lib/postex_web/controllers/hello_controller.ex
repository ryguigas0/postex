defmodule PostexWeb.HelloController do
  use PostexWeb, :controller

  def index(conn, %{"name" => name}) do
    conn
    |> put_status(200)
    |> json(%{message: "Hello #{name}!!"})
  end

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> json(%{message: "Hello world!!"})
  end
end
