defmodule Postex.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :content, :string
    field :likes, :integer, default: 0
    field :shares, :integer, default: 0
    field :edited, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = post, updates \\ %{}) do
    post
    |> cast(updates, [:content], [:likes, :shares])
    |> validate_required([:content])
    |> validate_length(:content, min: 1, max: 260)
  end
end
