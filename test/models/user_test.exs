defmodule SpeakEasyApi.UserTest do
  use SpeakEasyApi.ModelCase

  alias SpeakEasyApi.User

  @valid_attrs %{
    email: "user@example.com",
    password: "supersecret"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.password_hash
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
