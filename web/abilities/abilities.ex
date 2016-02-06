defmodule Abilities do
  alias SpeakEasyApi.Location
  alias SpeakEasyApi.Guest
  alias SpeakEasyApi.User

  defimpl Canada.Can, for: Guest do
    def can?(%Guest{}, action, _)
      when action in [:create, :update, :delete], do: false
  end

  defimpl Canada.Can, for: User do
    def can?(%User{permission: "admin"}, action, %Location{})
      when action in [:create, :update, :delete], do: true
    def can?(%User{permission: "admin"}, action, _)
      when action in [:create, :update, :delete], do: true
    def can?(%User{permission: "user"}, action, _)
      when action in [:create, :update, :delete], do: false
  end

  defimpl Canada.Can do
    def can?(_, _, _), do: false
  end
end
