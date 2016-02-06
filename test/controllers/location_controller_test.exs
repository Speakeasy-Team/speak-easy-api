defmodule SpeakEasyApi.LocationControllerTest do
  use SpeakEasyApi.ConnCase

  alias SpeakEasyApi.Location

  @valid_attrs %{
    cover_image_url: "some content",
    description: "some content",
    name: "some content",
    latitude: 12.3,
    longitude: 12.3,
  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, location_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "lists all the distances from a location", %{conn: conn} do
    location = Repo.insert! %Location{latitude: 1.0000, longitude: 0.0000}
    conn = get conn, location_path(conn, :index), %{lat: "0.0000", long:
      "0.0000"}
    [location|_] = json_response(conn, 200)["data"]
    assert location["distance"] != %{}
  end

  test "shows chosen resource", %{conn: conn} do
    location = Repo.insert! %Location{}
    conn = get conn, location_path(conn, :show, location)
    assert json_response(conn, 200)["data"] == %{"id" => location.id,
      "name" => location.name,
      "description" => location.description,
      "latitude" => location.latitude,
      "longitude" => location.longitude,
      "tags" => [],
      "cover_image_url" => location.cover_image_url}
  end

  test "does not show resource and instead throw error when id is nonexistent" do
    conn = get conn, location_path(conn, :show, -1)
    assert conn.status == 404
  end

  test "#create returns unauthorized for a guest" do
    conn = conn |> post(location_path(conn, :create), location: @valid_attrs)
    assert json_response(conn, 401)
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = conn
           |> sign_in("admin")
           |> post(location_path(conn, :create), location: @valid_attrs)
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Location, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = conn
           |> sign_in("admin")
           |> post(location_path(conn, :create), location: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    location = Repo.insert! %Location{}
    conn = conn
           |> sign_in("admin")
           |> put(location_path(conn, :update, location), location: @valid_attrs)
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Location, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    location = Repo.insert! %Location{}
    conn = conn
           |> sign_in("admin")
           |> put(location_path(conn, :update, location), location: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    location = Repo.insert! %Location{}
    conn = conn
           |> sign_in("admin")
           |> delete(location_path(conn, :delete, location))
    assert response(conn, 204)
    refute Repo.get(Location, location.id)
  end
end
