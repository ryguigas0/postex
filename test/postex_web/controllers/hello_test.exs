defmodule HelloTest do
  use PostexWeb.ConnCase, async: true

  test "GET /hello without a name returns a 'Hello World!!' message", %{conn: conn} do
    expected_resp = %{"message" => "Hello world!!"}

    resp = get(conn, "/hello") |> json_response(200)

    assert resp == expected_resp
  end

  test "GET /hello with a name, greets the name", %{conn: conn} do
    expected_resp = %{"message" => "Hello Jane Doe!!"}

    resp = get(conn, "/hello", name: "Jane Doe") |> json_response(200)

    assert resp == expected_resp
  end
end
