defmodule SpeakEasyApi.LocationView do
  use SpeakEasyApi.Web, :view

  def render("index.json", %{locations: locations}) do
    %{data: render_many(locations, SpeakEasyApi.LocationView, "location.json")}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, SpeakEasyApi.LocationView, "location.json")}
  end

  def render("location.json", %{location: location}) do
    %{id: location.id,
      name: location.name,
      description: location.description,
      cover_image_url: location.cover_image_url,
      latitude: location.latitude,
      longitude: location.longitude,
      tags: []}
  end
end
