defmodule PostexWeb.PostView do
  alias Postex.Post

  use PostexWeb, :view

  def render("create.json", %{post: %Post{} = post}) do
    %{
      message: "Post was created!",
      post_id: post.id
    }
  end

  def render("show.json", %{post: %Post{} = post}) do
    %{
      content: post.content,
      likes: post.likes,
      shares: post.shares,
      id: post.id,
      edited: post.edited
    }
  end

  def render("delete.json", _assigns) do
    %{
      message: "Post was deleted!"
    }
  end
end
