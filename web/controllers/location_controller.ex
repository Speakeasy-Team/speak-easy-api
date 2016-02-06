defmodule SpeakEasyApi.LocationController do
  use SpeakEasyApi.Web, :controller

  alias SpeakEasyApi.Location

  plug :scrub_params, "location" when action in [:create, :update]
  plug :load_resource, model: Location, only: [:index, :show, :update, :delete]
  plug :authorize_resource, model: Location, only: [:create, :update, :delete]

  def index(conn, _params) do
    render(conn, "index.json", locations: conn.assigns.locations)
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", location: conn.assigns.location)
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
    changeset = Location.changeset(conn.assigns.location, location_params)

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
    Repo.delete!(conn.assigns.location)
    send_resp(conn, 204, "ok")
  end
end
