defmodule SpeakEasyApi.UserTest do
  use SpeakEasyApi.ModelCase

  alias SpeakEasyApi.User, as: Subject

  @valid_attrs %{
    email: "user@example.com",
    password: "supersecret"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subject.changeset(%Subject{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.password_hash
  end

  test "changeset with invalid attributes" do
    changeset = Subject.changeset(%Subject{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_user_changeset defaults to user when a permission isn't passed" do
    changeset = Subject.create_user_changeset(%Subject{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.permission == "user"
  end

  test "create_user_changeset leaves permission alone if 'admin' is passed" do
    changeset = Subject.create_user_changeset(%Subject{}, Map.put(@valid_attrs,
                :permission, "admin"))
    assert changeset.valid?
    assert changeset.changes.permission == "admin"
  end

  test "create_user_changeset checks to see valid permission strings" do
    changeset = Subject.create_user_changeset(%Subject{}, Map.put(@valid_attrs,
                :permission, "user"))
    assert changeset.valid?
  end

  test "guest? returns true if the current_user is a guest" do
    user = %Subject{permission: "guest"}
    assert Subject.guest?(user)
  end

  test "guest? returns false if the current_user is a guest" do
    user = %Subject{permission: "admin"}
    refute Subject.guest?(user)
  end
end
