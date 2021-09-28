defmodule PostexWeb.UserView do
  use PostexWeb, :view

  alias Postex.User

  def render("show.json", %{user: %User{} = user}), do: user
end
