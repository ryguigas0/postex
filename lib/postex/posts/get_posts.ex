defmodule Postex.Posts.GetPosts do
  alias Postex.{Post, Repo}

  import Ecto.Query

  def call(batch_size, rule) when is_integer(batch_size) do
    post_list = rule |> get_query_by_rule() |> Repo.all() |> Enum.take(batch_size)

    if length(post_list) == 0 do
      {:error, :no_posts}
    else
      {:ok, post_list}
    end
  end

  defp get_query_by_rule("latest") do
    from p in Post, order_by: [desc: :inserted_at]
  end

  defp get_query_by_rule("likes") do
    from p in Post, order_by: [desc: :likes]
  end

  defp get_query_by_rule("shares") do
    from p in Post, order_by: [desc: :shares]
  end
end
