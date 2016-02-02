defmodule SpeakEasyApi.Plugs.CurrentUser do
  import Plug.Conn
  alias SpeakEasyApi.User

  @key Application.get_env(:vars, :json_web_token_key)

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    token = conn |> extract_auth_header
    assign(conn, :current_user, fetch_current_user(token, repo))
  end

  defp extract_auth_header(conn) do
    conn.req_headers |> Enum.into(%{}) |> Map.get("authorization")
  end

  defp fetch_current_user(token, _) when is_nil(token), do: %SpeakEasyApi.Guest{}
  defp fetch_current_user(token, repo) when is_binary(token) do
    token
    |> String.replace("bearer ", "")
    |> get_user_id
    |> find_user(repo)
  end

  defp get_user_id(token) do
    case SpeakEasyApi.JWTConverter.from_token(token) do
      {:ok, claims} -> claims.user_id
      {:error, _} -> nil
    end
  end

  defp find_user(nil, repo), do: nil
  defp find_user(user_id, repo) do
    repo.get(User, user_id)
  end
end
