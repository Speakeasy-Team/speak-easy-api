defmodule SpeakEasyApi.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :description, :text
      add :cover_image_url, :string
      add :latitude, :float
      add :longitude, :float

      timestamps
    end

  end
end
