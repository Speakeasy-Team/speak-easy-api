defmodule SpeakEasyApi.LocationTest do
  use SpeakEasyApi.ModelCase

  alias SpeakEasyApi.Location

  @valid_attrs %{cover_image_url: "some content", description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end
end
