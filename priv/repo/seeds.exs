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

Repo.insert!(%Location{
  name: "Amor y Amargo",
  description: "This place is super dope",
  cover_image_url: "https://irs3.4sqi.net/img/general/width960/424_iYwrxuUP23pBAr_SXMMsfseDhcr1AvNo0cb5J8qoS1g.jpg",
  latitude: 40.7257260,
  longitude: -73.9842380
})
Repo.insert!(%Location{
  name: "151",
  description: "The best spot in NYC",
  cover_image_url: "https://irs3.4sqi.net/img/general/width960/12270858_dWKKwKpeUpxDsulER6c-0egTYF6OxIwcg0JJ0jjl3zM.jpg",
  latitude: 40.7159950,
  longitude: -73.9866640
})
