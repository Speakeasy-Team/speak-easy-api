defmodule SpeakEasyApi.Camelize do
  def pascalize(key) do
    Inflex.camelize(key, :lower)
  end
end
