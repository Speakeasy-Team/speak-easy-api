defmodule SpeakEasyApi.Plugs.Authorize do
  import Plug.Conn
  use SpeakEasyApi.Web, :controller

  def init(opts) do
    Keyword.fetch!(opts, :permissions_handler)
  end

  def call(conn, permissions_hander) do
    current_user = conn.assigns.current_user
    action = conn.private.phoenix_action

    if apply(permissions_hander, action, [current_user]) do
      conn
    else
      conn
      |> put_status(401)
      |> halt
    end
  end
end
