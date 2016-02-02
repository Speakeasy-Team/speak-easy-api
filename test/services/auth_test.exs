defmodule SpeakEasyApi.AuthTest do
  use SpeakEasyApi.ConnCase
  alias SpeakEasyApi.User
  alias SpeakEasyApi.Auth, as: Subject

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "authorize(conn, email, password, opts) adds jwt token to the json" do
    email = "user@example.com"
    password = "supersecret"

    changeset = User.changeset(%User{}, %{email: email, password: password})
    Repo.insert!(changeset)

    response = Subject.authorize(conn, email, password)
    assert response.resp_body
  end

  test "authorize(conn, email, password, opts) adds errors on failed auth" do
    email = "user@example.com"
    password = "supersecret"

    changeset = User.changeset(%User{}, %{email: email, password: password})
    Repo.insert!(changeset)

    response = Subject.authorize(conn, email, "hello")
    assert response.status == 401
  end

  test "#authorize_user(username, password) returns true if the Username and
  password are correct" do
    email = "user@example.com"
    password = "supersecret"

    changeset = User.changeset(%User{}, %{email: email, password: password})
    user = Repo.insert!(changeset)

    assert Subject.valid_password?(user, password)
  end

  test "#authorize_user(username, password) returns false if the email and
  password are incorrect" do
    email = "user@example.com"
    password = "supersecret"

    changeset = User.changeset(%User{}, %{email: email, password: password})
    user = Repo.insert!(changeset)

    refute Subject.valid_password?(user, "hi")
  end
end
