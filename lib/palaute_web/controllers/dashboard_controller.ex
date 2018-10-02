defmodule PalauteWeb.DashboardController do
  use PalauteWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
