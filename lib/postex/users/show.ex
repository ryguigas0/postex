defmodule Postex.Users.Show do

  alias Postex.{Repo, User}

  def call(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end
end
