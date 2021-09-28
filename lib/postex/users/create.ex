defmodule Postex.Users.Create do
  alias Postex.{Repo, User}

  def call(%{email: _, password: _} = attrs) do
    result =
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, new_user} -> {:ok, new_user}
      {:error, _invalid} -> {:error, :invalid_data}
    end
  end
end
