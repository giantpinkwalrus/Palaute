defmodule Palaute.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "user" do
    field :name, :string
    field :password, :string
    field :password_confirm, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
  end

  defp password_match(changeset) do
    password = get_change(changeset, :password)
    password_confirm = get_change(changeset, :password_confirm)
    if password == password_confirm do
      changeset
    else
      changeset |> add_error(:password_confirmation, "Passwords don't match")
    end
  end

  def hash_password(changeset) do
    password = get_change(changeset, :password)
    hash = Comeonin.Argon2.hashpwsalt(password)
    changeset |> put_change(:password, hash)
  end

  def signup(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :password_confirm])
    |> validate_required([:name, :password, :password_confirm])
    |> validate_length(:password, min: 8)
    |> password_match()
    |> hash_password()
  end
end
