defmodule SpeakEasyApi.SessionController do
  use SpeakEasyApi.Web, :controller

  def create(conn, %{"email" => email, "password" => password}) do
    conn |> SpeakEasyApi.Auth.authorize(email, password)
  end
end
