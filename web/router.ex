defmodule Sched.Router do
  use Sched.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    addict :routes
  end
  scope "/", Sched do
    pipe_through :browser # Use the default browser stack

    get "/authorize", TokenController, :authorize # collection route
    get "/verify_user", TokenController, :verify_user # collection route


    get "/", PageController, :index
    #resources "/tokens", TokenController
    resources "/schedulers", SchedulerController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Sched do
  #   pipe_through :api
  # end
end
