defmodule SpeakEasyApi.CurrentUserTest do
  use ExUnit.Case, async: true
  use Plug.Test
  alias SpeakEasyApi.User
  alias SpeakEasyApi.Repo
  alias SpeakEasyApi.Plugs.CurrentUser, as: Subject

  test "plug sets current user onto the conn" do
    user = Repo.insert! %User{email: "hello", password_hash: "hello"}
    token = SpeakEasyApi.JWTConverter.to_token(%{user_id: user.id})
    conn =
      conn(:get, "/locations")
      |> put_req_header("authorization", "bearer #{token}")

    opts = Subject.init(repo: Repo)
    result = Subject.call(conn, opts)

    assert result.assigns.current_user == user
  end

  test "plug assigns a guest user when a token is not provided" do
    conn = conn(:get, "/locations")
    opts = Subject.init(repo: Repo)
    result = Subject.call(conn, opts)

    assert result.assigns.current_user == %SpeakEasyApi.Guest{}
  end

  test "plug assigns nil to current user if an invalid token is provided" do
    conn =
      conn(:get, "/locations")
      |> put_req_header("authorization", "bearer YXNkZmFzZGZhc2Rm")
    opts = Subject.init(repo: Repo)
    result = Subject.call(conn, opts)

    assert result.assigns.current_user == nil
  end
end
