defmodule SpeakEasyApi.PageController do
  use SpeakEasyApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
