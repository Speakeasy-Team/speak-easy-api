defmodule SpeakEasyApi.User do
  use SpeakEasyApi.Web, :model

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
