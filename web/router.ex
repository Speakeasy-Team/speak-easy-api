defmodule SpeakEasyApi.Router do
  use SpeakEasyApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpeakEasyApi do
    pipe_through :api # Use api stack

    resources "/locations", LocationController, except: [:new, :edit]
    resources "/users", UserController, only: [:index, :create]
    resources "/sessions", SessionController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpeakEasyApi do
  #   pipe_through :api
  # end
end
