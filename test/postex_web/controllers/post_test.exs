defmodule PostexWeb.PostsControllerTest do
  use PostexWeb.ConnCase, async: true

  describe "HTTP request tests that depends on id - " do
    test "GET /posts/:id finds a post with valid id", %{conn: conn} do
      created_post = create_post(conn, "This is a test!")

      resp =
        get(conn, "/posts/#{created_post["id"]}")
        |> json_response(200)

      assert %{
               "content" => "This is a test!",
               "edited" => false,
               "id" => _,
               "likes" => 0,
               "shares" => 0
             } = resp
    end

    test "GET /posts/:id doesnt find a post with invalid id", %{conn: conn} do
      resp =
        get(conn, "/posts/960b3ae7-2408-4150-8d2a-8babd87a6863")
        |> json_response(404)

      assert resp == %{"error" => "Post not found!"}
    end

    test "PUT or PATCH /posts/:id finds a post with valid id and updates its likes and shares values with valid data",
         %{conn: conn} do
      created_post = create_post(conn, "This is a test!")

      random_likes = "#{:rand.uniform(5000)}"
      random_shares = "#{:rand.uniform(5000)}"

      resp =
        put(conn, "/posts/#{created_post["id"]}", %{
          "likes" => random_likes,
          "shares" => random_shares
        })
        |> json_response(200)

      assert %{
               "content" => "This is a test!",
               "edited" => false,
               "id" => _,
               "likes" => _random_likes,
               "shares" => _random_shares
             } = resp
    end

    test "PUT or PATCH /posts/:id doesnt find a post with invalid id",
         %{conn: conn} do
      resp =
        put(conn, "/posts/960b3ae7-2408-4150-8d2a-8babd87a6863", %{
          "likes" => "123",
          "shares" => "201"
        })
        |> json_response(404)

      assert resp == %{"error" => "Post not found!"}
    end

    test "GET /posts/:id/edit finds a post with valid id and updates its content",
         %{conn: conn} do
      created_post = create_post(conn, "This is a test!")

      resp =
        get(conn, "/posts/#{created_post["id"]}/edit", content: "This is a drill!")
        |> json_response(200)

      assert %{
               "content" => "This is a drill!",
               "edited" => true,
               "id" => _,
               "likes" => 0,
               "shares" => 0
             } = resp
    end

    test "GET /posts/:id/edit doesnt find a post with invalid id",
         %{conn: conn} do
      resp =
        get(conn, "/posts/960b3ae7-2408-4150-8d2a-8babd87a6863/edit", %{
          "content" => "This is a drill!"
        })
        |> json_response(404)

      assert resp == %{"error" => "Post not found!"}
    end

    test "DELETE /posts/:id finds a post with a valid id and deletes it",
         %{conn: conn} do
      created_post = create_post(conn, "This is a test!")

      resp =
        delete(conn, "/posts/#{created_post["id"]}")
        |> json_response(200)

      assert resp == %{"message" => "Post was deleted!"}
    end

    test "DELETE /posts/:id doesnt find a post with invalid id",
         %{conn: conn} do
      resp =
        delete(conn, "/posts/960b3ae7-2408-4150-8d2a-8babd87a6863")
        |> json_response(404)

      assert resp == %{"error" => "Post not found!"}
    end
  end

  describe "HTTP request tests that doesnt depend on id - " do
    test "POST /posts creates a post with valid data", %{conn: conn} do
      resp = create_post(conn, "This is a test post!")

      assert %{
               "content" => "This is a test post!",
               "edited" => false,
               "id" => _,
               "likes" => 0,
               "shares" => 0
             } = resp
    end

    test "POST /posts doesnt create a post with invalid data", %{conn: conn} do
      resp =
        post(conn, "/posts", %{"content" => ""})
        |> json_response(400)

      assert resp == %{"error" => "Invalid data provided!"}
    end

    test "GET /posts with a size n and a rule returns a list of n posts based on the rule", %{
      conn: conn
    } do
      expected_resp =
        Enum.map(
          # Prepares 20 posts to be created
          1..20,
          fn _n ->
            # Creates the posts
            create_post(conn, "This is a test!")
            # Gets the id for updates
            |> Map.get("id")
          end
        )
        |> Enum.map(fn id ->
          random_likes = "#{:rand.uniform(5000)}"
          random_shares = "#{:rand.uniform(5000)}"

          # Updates the likes and shares values
          put(conn, "/posts/#{id}", %{
            "likes" => random_likes,
            "shares" => random_shares
          })
          |> json_response(200)
        end)
        |> Enum.sort_by(
          # Useless mapper function
          fn n -> n end,
          # Sorts like it should
          fn pa, pb -> pa["likes"] >= pb["likes"] end
        )
        # Takes the batch size
        |> Enum.take(10)

      resp = get(conn, "/posts", size: 10, rule: "likes") |> json_response(200)

      assert resp === expected_resp
    end

    test "GET /posts with a size 0 or when no posts are found", %{
      conn: conn
    } do
      resp = get(conn, "/posts", size: 0, rule: "likes") |> json_response(200)

      assert resp === %{"message" => "No posts found!"}
    end
  end

  defp create_post(conn, content) do
    post(conn, "/posts", %{"content" => content})
    |> json_response(201)
  end
end
