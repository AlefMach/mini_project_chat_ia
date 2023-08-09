defmodule BasicChat do
  @moduledoc """
  This is a simple project to simulate a IA of the conversation

  it's very simple, but the logic is the same used in big tech company
  """

  alias BasicChat.Domain.GenerateMessage

  @doc """
  Tell me something.

  ## Examples

      iex> BasicChat.tell_me("Bom dia! como está?")
      Estou bem, como posso ajudar?

      bom dia!
      :ok

  """
  def tell_me(message) when is_binary(message), do: GenerateMessage.response(message) |> IO.puts()

  def tell_me(message) do
    saved_message = BasicChat.FailedMessage.last_message()

    failed_response = BasicChat.Data.params_wrong |> Enum.take_random(1) |> Enum.at(0) |> String.replace("#", inspect(message))

    case is_map_key(saved_message, "first_failed_response") do
      true ->
        BasicChat.FailedMessage.update_message(%{"failed_response" => nil})
        saved_message["first_failed_response"]

      false ->
        failed_response
    end
  end
end
