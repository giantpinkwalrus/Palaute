defmodule PalauteWeb.LoginController do
  use PalauteWeb, :controller
  import Ecto.Query
  alias Palaute.{User, Repo}

  def index(conn, _) do
    render conn, "index.html", token: get_csrf_token()
  end

  def try_password(password, plain_text) do
    logged_in = Comeonin.Argon2.checkpw(plain_text, password)
  end

  def login(conn, %{"name" => name, "password" => password}) do
    user = Repo.one(from u in User, where: u.name == ^name)
    logged_in = try_password(user.password, password)
    render conn, "logged.html", logged_in: logged_in
  end
end
