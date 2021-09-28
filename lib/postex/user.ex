defmodule Postex.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:email, :password]

  @derive {Jason.Encoder, only: (@required_params -- [:password]) ++ [:id]}

  schema "users" do
    field :email, :string
    field :password, :string

    has_many :posts, Postex.Post

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, updates \\ %{}) do
    user
    |> cast(updates, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> put_password_hash()
  end

  # If its a valid user data, then hash the password and save it
  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  # If its invalid user data, do nothing
  defp put_password_hash(invalid_changeset), do: invalid_changeset
end
