defmodule SpeakEasyApi.LocationAuthorization do
  alias SpeakEasyApi.User

  def index(current_user) do
    User.guest? current_user
  end

  def show(current_user) do
    User.guest? current_user
  end

  def create(current_user) do
    User.guest? current_user
  end

  def update(current_user) do
    User.guest? current_user
  end

  def delete(current_user) do
    User.guest? current_user
  end
end
