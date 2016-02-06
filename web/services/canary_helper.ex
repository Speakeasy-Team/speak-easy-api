defmodule SpeakEasyApi.CanaryHelper do
  use SpeakEasyApi.Web, :controller

  def handle_not_found(conn) do
    conn
    |> put_status(404)
    |> json(%{errors: "Not found"})
    |> halt
  end

  def handle_unauthorized(conn) do
    conn
    |> put_status(401)
    |> json(%{errors: "Not Authorized"})
    |> halt
  end
end
