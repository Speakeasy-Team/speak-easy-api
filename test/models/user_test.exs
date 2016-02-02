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

  test "create_user_changeset defaults to user when a permission isn't passed" do
    changeset = User.create_user_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.permission == "user"
  end

  test "create_user_changeset leaves permission alone if 'admin' is passed" do
    changeset = User.create_user_changeset(%User{}, Map.put(@valid_attrs,
                :permission, "admin"))
    assert changeset.valid?
    assert changeset.changes.permission == "admin"
  end

  test "create_user_changeset checks to see valid permission strings" do
    changeset = User.create_user_changeset(%User{}, Map.put(@valid_attrs,
                :permission, "user"))
    assert changeset.valid?
  end
end
