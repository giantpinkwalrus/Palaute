defmodule PalauteWeb.Redirector do
  import Plug.Conn

  @spec init(Keyword.t) :: Keyword.t
  def init([to: _] = opts), do: opts
  def init(_default), do: raise("Missing required to: option in redirect")

  @spec call(Plug.Conn.t, Keyword.t) :: Plug.Conn.t
  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
  end
end
