defmodule SpeakEasyApi.LocationAuthorization do
  use SpeakEasyApi.Authorization

  def authorize(action, %Guest{})
    when action in @crud_actions, do: true
  def authorize(action, %User{})
    when action in @crud_actions, do: true

  def authorize(_action, _user), do: false
end
