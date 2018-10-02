defmodule PalauteWeb.Authenticator do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    #if conn.assigns.current_user? do
    if get_session(conn, :current_user) do
      conn
    else
      conn
      |> put_flash(:error, "Kirjaudu sisään")
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
