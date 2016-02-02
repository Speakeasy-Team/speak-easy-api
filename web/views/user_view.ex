defmodule SpeakEasyApi.UserView do
  use SpeakEasyApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, SpeakEasyApi.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SpeakEasyApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end
