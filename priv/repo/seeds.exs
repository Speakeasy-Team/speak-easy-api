# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SpeakEasyApi.Repo.insert!(%SpeakEasyApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SpeakEasyApi.Repo
alias SpeakEasyApi.Location

Repo.insert!(%Location{ name: "Eli's Super Cool Spot", description: "This place
  is super dope", cover_image_url: "https://placekitten.com/1200/600" })
Repo.insert!(%Location{ name: "Chris's Super Rad Spot", 
  description: "The best spot in NYC", cover_image_url: "https://placekitten.com/1200/600" })
