defmodule SpeakEasyApi.LocationController do
  use SpeakEasyApi.Web, :controller

  alias SpeakEasyApi.Location
  alias SpeakEasyApi.LocationAuthorization
  alias SpeakEasyApi.Plugs.Authorize

  plug :scrub_params, "location" when action in [:create, :update]
  plug Authorize, permissions_handler: LocationAuthorization

  def index(conn, _params) do
    locations = Repo.all(Location)
    render(conn, "index.json", locations: locations)
  end

  def show(conn, %{"id" => id}) do
    location = Repo.get!(Location, id)
    render(conn, "show.json", location: location)
  end

  def create(conn, %{"location" => params}) do
    changeset = Location.changeset(%Location{}, params)

    case Repo.insert(changeset) do
      {:ok, location} ->
        conn
        |> put_status(201)
        |> render("show.json", location: location)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(SpeakEasyApi.ErrorView, "errors.json", errors: changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Repo.get!(Location, id)
    changeset = Location.changeset(location, location_params)

    case Repo.update(changeset) do
      {:ok, location} ->
        render(conn, "show.json", location: location)
      {:error, location} ->
        conn
        |> put_status(422)
        |> render(SpeakEasyApi.ErrorView, "errors.json", errors: changeset.errors)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Repo.get!(Location, id)
    Repo.delete!(location)
    send_resp(conn, 204, "ok")
  end
end
