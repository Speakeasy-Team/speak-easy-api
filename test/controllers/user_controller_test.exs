defmodule SpeakEasyApi.UserControllerTest do
  use SpeakEasyApi.ConnCase

  alias SpeakEasyApi.User

  @valid_attrs %{
    email: "user@example.com",
    password: "supersecret"
  }

  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "#index lists all entries on index", %{conn: conn} do
    user = Repo.insert! %User{email: "hello", password_hash: "hello"}

    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] ==
      [%{"email" => user.email, "id" => user.id}]
  end

  test "#create creates a user with proper params" do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    id = json_response(conn, 201)["data"]["id"]
    assert Repo.get(User, id).email == "user@example.com"
  end

  test "#create returns errors on invalid params" do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
