defmodule SpeakEasyApi.JWTConverter do
  @opts %{
    key: Application.get_env(:vars, :json_web_token_key)
  }

  def to_token(claims) do
    JsonWebToken.sign(claims, @opts)
  end

  def from_token(token) do
    try do
      JsonWebToken.verify(token, @opts)
    rescue
      RuntimeError -> {:error, "invalid"}
    end
  end
end
