defmodule SpeakEasyApi.UserController do
  use SpeakEasyApi.Web, :controller
  alias SpeakEasyApi.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", %{users: users})
  end

  def create(conn, %{"user" => params}) do
    changeset = User.create_user_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("show.json", user: user)
      {:error, changeset } ->
        conn
        |> put_status(422)
        |> render(SpeakEasyApi.ErrorView, "errors.json", errors: changeset.errors)
    end
  end
end
