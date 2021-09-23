defmodule PostexWeb.PostView do
  alias Postex.Post

  use PostexWeb, :view

  def render("show.json", %{post: %Post{} = post}) do
    %{
      content: post.content,
      likes: post.likes,
      shares: post.shares,
      id: post.id,
      edited: post.edited
    }
  end

  def render("show_many.json", %{post_list: post_list}) do
    Enum.map(post_list, fn p -> render("show.json", %{post: p}) end)
  end

  def render("delete.json", _assigns) do
    %{
      message: "Post was deleted!"
    }
  end
end
