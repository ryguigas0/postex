defmodule Postex.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :likes, :integer
    field :shares, :integer
    field :edited, :boolean

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
