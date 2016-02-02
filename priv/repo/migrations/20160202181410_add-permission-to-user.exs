defmodule :"Elixir.SpeakEasyApi.Repo.Migrations.Add-permission-to-user" do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:permission, :string)
    end
  end
end
