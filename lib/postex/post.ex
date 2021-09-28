defmodule Postex.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:content, :user_id, :likes, :shares]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "posts" do
    belongs_to :users, Postex.User

    field :content, :string
    field :likes, :integer, default: 0
    field :shares, :integer, default: 0
    field :edited, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = post, updates \\ %{}) do
    post
    |> cast(updates, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:content, min: 1, max: 260)
  end
end
