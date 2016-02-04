defmodule SpeakEasyApi.Authorization do
  @type user_or_guest :: SpeakEasyApi.User.t | SpeakEasyApi.Guest.t
  @callback authorize(action :: atom, current_user :: user_or_guest) :: boolean

  defmacro __using__(_) do
    quote do
      @behaviour SpeakEasyApi.Authorization

      alias SpeakEasyApi.User
      alias SpeakEasyApi.Guest

      @crud_actions [:index, :show, :create, :update, :delete]
    end
  end
end