defmodule SpeakEasyApi.LocationController do
  use SpeakEasyApi.Web, :controller

  alias SpeakEasyApi.Location

  plug :scrub_params, "location" when action in [:create, :update]

  def index(conn, _params) do
    locations = Repo.all(Location)
    render(conn, "index.json", locations: locations)
  end

  def show(conn, %{"id" => id}) do
    location = Repo.get!(Location, id)
    render(conn, "show.json", location: location)
  end
end
