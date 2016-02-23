defmodule SpeakEasyApi.SessionControllerTest do
  use SpeakEasyApi.ConnCase
  alias SpeakEasyApi.User

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "#create returns a JWT object on a successful post", %{conn: conn} do
    email = "user@example.com"
    password = "supersecret"

    changeset = SpeakEasyApi.User.changeset(%User{}, %{email: email, password: password})
    Repo.insert!(changeset)
    conn = post conn, session_path(conn, :create), %{email: email, password: password}

    assert json_response(conn, 200)["token"]
  end

  test "#create returns a 401 on an unsuccessful post", %{conn: conn} do
    email = "user@example.com"
    password = "supersecret"

    changeset = SpeakEasyApi.User.changeset(%User{}, %{email: email, password: password})
    Repo.insert!(changeset)
    conn = post conn, session_path(conn, :create), %{email: email, password: "hello"}

    assert json_response(conn, 401)
  end
end
