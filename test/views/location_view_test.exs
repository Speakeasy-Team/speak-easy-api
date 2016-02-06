defmodule SpeakEasyApi.LocationViewTest do
  use ExUnit.Case, async: false
  alias SpeakEasyApi.LocationView, as: Subject

  test "#calculate_distance returns the distance between two lat, long coords" do
    coords_1 = %{latitude: 0.000000, longitude: 0.000000}
    coords_2 = %{latitude: 1.000000, longitude: 0.000000}
    distance = Subject.calculate_distance(coords_1, coords_2)

    assert distance == 111194.92664455874
  end
end
