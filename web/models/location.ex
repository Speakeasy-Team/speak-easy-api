defmodule SpeakEasyApi.Location do
  use SpeakEasyApi.Web, :model

  schema "locations" do
    field :name, :string
    field :description, :string
    field :cover_image_url, :string
    field :latitude, :float
    field :longitude, :float

    timestamps
  end

  @required_fields ~w(name description cover_image_url latitude longitude)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
