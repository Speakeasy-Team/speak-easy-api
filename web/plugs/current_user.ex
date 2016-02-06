defmodule SpeakEasyApi.Plugs.CurrentUser do
  import Plug.Conn
  alias SpeakEasyApi.User
  alias SpeakEasyApi.Guest
  alias SpeakEasyApi.JWTConverter

  @key Application.get_env(:speak_easy_api, :json_web_token_key)

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    if Map.get(conn.assigns, :current_user) do
      conn
    else
      token = conn |> extract_auth_header
      assign(conn, :current_user, fetch_current_user(token, repo))
    end
  end

  defp extract_auth_header(conn) do
    conn.req_headers |> Enum.into(%{}) |> Map.get("authorization")
  end

  defp fetch_current_user(token, _) when is_nil(token), do: %Guest{}
  defp fetch_current_user(token, repo) when is_binary(token) do
    token
    |> String.replace("bearer ", "")
    |> get_user_id
    |> find_user(repo)
  end

  defp get_user_id(token) do
    case JWTConverter.from_token(token) do
      {:ok, claims} -> claims.user_id
      {:error, _} -> nil
    end
  end

  defp find_user(nil, repo), do: nil
  defp find_user(user_id, repo) do
    repo.get(User, user_id)
  end
end
