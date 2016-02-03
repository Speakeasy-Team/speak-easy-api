defmodule SpeakEasyApi.Plugs.AuthorizeTest do
  use ExUnit.Case, async: true
  use SpeakEasyApi.ConnCase
  import Mock
  alias SpeakEasyApi.Plugs.Authorize, as: Subject
  alias SpeakEasyApi.LocationAuthorization

  test "plug passes through the conn if the user is authorized" do
    with_mock LocationAuthorization, [index: fn(_) -> true end] do
      conn = get conn(), "/locations"

      opts = Subject.init(permissions_handler: LocationAuthorization)
      result = Subject.call(conn, opts)

      assert result == conn
    end
  end

  test "plug renders unauthorized if the user is unauthorized" do
    with_mock LocationAuthorization, [index: fn(_) -> false end] do
      conn = get conn(), "/locations"

      opts = Subject.init(permissions_handler: LocationAuthorization)
      result = Subject.call(conn, opts)

      assert result.status == 401
    end
  end
end
