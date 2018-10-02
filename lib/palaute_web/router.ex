defmodule PalauteWeb.Router do
  use PalauteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :is_authenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PalauteWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/submit-feedback", Redirector, to: "/"
    post "/submit-feedback", FeedbackController, :index
    get "/register/:id", RegisterController, :index
    post "/register/:id", RegisterController, :register
    get "/login", LoginController, :index
    post "/login", LoginController, :login
  end

  scope "/admin", PalauteWeb do
    pipe_through [:browser, :admin]

    get "/", DashboardController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PalauteWeb do
  #   pipe_through :api
  # end
end
