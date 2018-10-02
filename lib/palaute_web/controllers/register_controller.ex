defmodule PalauteWeb.RegisterController do
  use PalauteWeb, :controller
  alias Palaute.{Repo, User, RegToken}
  import Ecto.Query

  def index(conn, %{"id" => token}) do
    render conn, "index.html", regtoken: token, token: get_csrf_token()
  end

  def findRegToken(token) do
    token = Repo.one(from reg in Palaute.RegToken, where: reg.id == ^token and reg.used == false)
    if token == nil do
      {:error, nil}
    else
      {:ok, token}
    end
  end 

  def registerUser(name, password, password_confirm, token) do
    user_changeset = User.signup(%User{}, %{
      name: name,
      password: password,
      password_confirm: password_confirm
    })
    token_changeset = RegToken.changeset(token, %{
      used: true
    })
    Ecto.Multi.new
    |> Ecto.Multi.insert(:user, user_changeset)
    |> Ecto.Multi.update(:token, token_changeset)
    |> Repo.transaction
  end

  def dumpId(id) do
    Ecto.UUID.dump(id)
  end

  def register(conn, %{
    "id" => id,
    "name" => name,
    "password" => password,
    "password_confirm" => password_confirm
  }) do
         with {:ok, token} <- findRegToken(id),
         {:ok, token_and_user} <- registerUser(name, password, password_confirm, token)
    do
      render conn, "reg_success.html"
    else
      # Three-form error tuples will be the topic for another blog-post
      {:error, _} -> render conn, "reg_failure.html"
    end
  end
end
