defmodule SpeakEasyApi.UserView do
  use SpeakEasyApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email]

  location "/users/:id"
end
