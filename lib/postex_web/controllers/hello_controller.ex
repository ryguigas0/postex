defmodule PostexWeb.HelloController do
  use PostexWeb, :controller


  def index(conn, %{"name" => name}) do
    json(conn, %{message: "Hello #{name}!!"})
  end

  def index(conn, _params) do
    json(conn, %{message: "Hello world!!"})
  end
end
