defmodule Palaute.RegToken do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "reg_token" do
    field :used, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(reg_token, attrs) do
    reg_token
    |> cast(attrs, [:used])
    |> validate_required([:used])
  end
end
