defmodule PalauteWeb.LoginController do
  use PalauteWeb, :controller
  import Ecto.Query
  alias Palaute.{User, Repo}

  def index(conn, _) do
    render conn, "index.html", token: get_csrf_token()
  end

  def try_password(password, plain_text) do
    if password != nil do
      logged_in = Comeonin.Argon2.checkpw(plain_text, password)
    else
      false
    end
  end

  defp fail_login(conn) do
    conn
    |> put_flash(:error, "Väärä salasana tai käyttäjätunnus")
    |> Phoenix.Controller.redirect(to: "/login")
  end

  def login(conn, %{"name" => name, "password" => password}) do
    user = Repo.one(from u in User, where: u.name == ^name)
    if user == nil do
      fail_login(conn)
    end
    logged_in = try_password(user.password, password)
    if logged_in == true do
      Plug.Conn.put_session(conn, :current_user, user)
      |> Phoenix.Controller.redirect(to: "/admin")
    else
      fail_login(conn)
    end
  end
end
