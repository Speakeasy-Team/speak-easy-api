defmodule SpeakEasyApi.AuthHelper do
  alias SpeakEasyApi.User
  use SpeakEasyApi.Web, :controller

  def sign_in(conn, user_type) do
    assign(conn, :current_user, %User{permission: user_type})
  end
end
