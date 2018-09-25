defmodule Palaute.Feedback do
  use Ecto.Schema
  import Ecto.Changeset
  alias Palaute.Feedback

  schema "feedback" do
    field :feedback, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Feedback{} = feedback, attrs) do
    feedback
    |> cast(attrs, [:feedback, :name])
    |> validate_required([:feedback])
    |> validate_length(:feedback, min: 1)
    |> validate_length(:feedback, max: 2048)
  end
end

