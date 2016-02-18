defmodule SpeakEasyApi.Auth do
  @opts %{
    key: Application.get_env(:vars, :json_web_token_key)
  }

  alias SpeakEasyApi.User
  import Comeonin.Bcrypt, only: [checkpw: 2]
  use SpeakEasyApi.Web, :controller

  def authorize(conn, email, password) do
    user = Repo.get_by(User, email: email)

    if valid_password?(user, password) do
      token = SpeakEasyApi.JWTConverter.to_token(%{user_id: user.id})
      json(conn, %{token: token})
    else
      conn
      |> put_status(401)
      |> json(%{errors: "Wrong username or password"})
    end
  end

  def valid_password?(nil, _), do: false
  def valid_password?(user, given_password) do
    checkpw(given_password, user.password_hash)
  end
end
