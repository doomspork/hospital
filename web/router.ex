defmodule Hospital.Router do
  use Hospital.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Hospital do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
    delete "/logout", SessionController, :delete, as: :logout
    get "/logout", SessionController, :delete, as: :logout

    get "/account", UserController, :show, as: :account
    get "/signup", UserController, :new, as: :signup
    post "/signup", UserController, :create, as: :signup

    get "/", PageController, :index
    get "/dashboard", HealthCheckController, :index
    get "/settings", PageController, :settings, as: :settings

    resources "/health_checks", HealthCheckController
  end

  scope "/api", Hospital do
    pipe_through :api

    post "/reports", Api.ReportController, :create, as: :report_api
    get "/health_checks", Api.HealthCheckController, :index, as: :health_check_api
  end
end
