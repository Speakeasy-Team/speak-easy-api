defmodule SpeakEasyApi.JwtConverterTest do
  use ExUnit.Case, async: false
  import Mock
  alias SpeakEasyApi.JWTConverter

  @opts %{
    key: Application.get_env(:vars, :json_web_token_key)
  }

  test "to_token(claims) converts the claim to a token" do
    with_mock JsonWebToken, [sign: fn(_, _) -> "hello" end] do
      JWTConverter.to_token("hello")

      assert called JsonWebToken.sign("hello", @opts)
    end
  end

  test "from_token(claims) converts the token to a claim" do
    with_mock JsonWebToken, [verify: fn(_, _) -> "hello" end] do
      JWTConverter.from_token("hello")

      assert called JsonWebToken.verify("hello", @opts)
    end
  end
end
