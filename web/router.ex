defmodule SpeakEasyApi.Router do
  use SpeakEasyApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
    plug SpeakEasyApi.Plugs.CurrentUser, repo: SpeakEasyApi.Repo
  end

  scope "/", SpeakEasyApi do
    pipe_through :api # Use api stack

    resources "/locations", LocationController, except: [:new, :edit]
    resources "/users", UserController, only: [:index, :create]
    resources "/sessions", SessionController, only: [:create]
  end
end
