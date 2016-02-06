defmodule SpeakEasyApi.LocationView do
  use SpeakEasyApi.Web, :view

  def calculate_distance(coords_1, coords_2) do
    Geocalc.distance_between(
      [coords_1.latitude, coords_1.longitude],
      [coords_2.latitude, coords_2.longitude]
    )
  end

  def render("index.json", %{user_location: user_location, locations: locations}) do
    %{data: render_many(locations, SpeakEasyApi.LocationView, "location.json",
      %{user_location: user_location, locations: locations})}
  end

  def render("index.json", %{locations: locations}) do
    %{data: render_many(locations, SpeakEasyApi.LocationView, "location.json")}
  end

  def render("show.json", %{user_location: user_location, location: location}) do
    %{data: render_one(location, SpeakEasyApi.LocationView, "location.json",
      %{user_location: user_location, location: location})}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, SpeakEasyApi.LocationView, "location.json")}
  end

  def render("location.json", %{user_location: user_location, location: location}) do
    distance = calculate_distance(user_location, %{latitude: location.latitude,
          longitude: location.longitude})

    %{id: location.id,
      name: location.name,
      description: location.description,
      cover_image_url: location.cover_image_url,
      latitude: location.latitude,
      longitude: location.longitude,
      distance: %{
        meters: distance
      },
      tags: []}
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
