defmodule Postex do
  @moduledoc """
  Postex keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Postex.Posts.{Create, Delete, Edit, Update, Show, GetPosts}

  defdelegate create_post(params), to: Create, as: :call
  defdelegate show_post(post_id), to: Show, as: :call
  defdelegate delete_post(post_id), to: Delete, as: :call
  defdelegate update_post(post_id, updates), to: Update, as: :call
  defdelegate edit_post(post_id, edits), to: Edit, as: :call
  defdelegate get_posts(size, rule), to: GetPosts, as: :call
end
