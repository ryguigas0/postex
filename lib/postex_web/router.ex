defmodule PostexWeb.Router do
  use PostexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PostexWeb do
    # Vê se está recebendo os dados corretos
    pipe_through :api

    # verbo "/recurso", Controller, :handler
    get "/hello", HelloController, :index

    resources "/users", UserController,
      only: [
        :create,
        :show,
        # :delete,
        # :edit
      ]

    resources "/posts", PostsController,
      only: [
        :create,
        :show,
        :delete,
        # Post update -> update like and share count
        :update,
        # Post edit -> update content value
        :edit,
        :index
      ]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: PostexWeb.Telemetry
    end
  end
end
