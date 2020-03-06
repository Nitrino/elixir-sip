defmodule Sip.Helpers do
  def method_to_atom(method) do
    case method |> String.downcase() do
      "invite" -> :invite
      "bye" -> :bye
    end
  end
end
