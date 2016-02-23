defmodule SpeakEasyApi.LocationView do
  use SpeakEasyApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :description, :cover_image_url, :latitude, :longitude,
    :distance, :tags]

  location "/locations/:id"

  def distance(location, conn) do
    case conn.query_params do
      %{"lat" => lat, "long" => long } ->
        %{"meters": calculate_distance([String.to_float(lat), String.to_float(long)],
        [location.latitude, location.longitude])}
      _ -> nil
    end
  end

  def tags(_, _) do
    []
  end

  def calculate_distance(coords_1, coords_2) do
    Geocalc.distance_between(coords_1, coords_2)
  end
end
