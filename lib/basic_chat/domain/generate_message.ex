defmodule BasicChat.Domain.GenerateMessage do
  @moduledoc """
  Module responsible for starting the response process
  """
  alias BasicChat.Messages
  alias BasicChat.Domain.PossiblePogramMessage

  @doc """
  any message

  ## Examples

    iex> BasicChat.Domain.GenerateMessage.response("Bom dia!")
    Bom dia!
  """
  def response(new_message) do
    archived_params = Messages.last_message()

    case has_message_started?(archived_params) do
      true ->
        archived_message = archived_params["user"]

        PossiblePogramMessage.handle_conversation(new_message, archived_message)

      false ->
        start_conversation(new_message)
    end
  end

  defp has_message_started?(archived_message) when is_map_key(archived_message, "user"), do: true

  defp has_message_started?(_archived_message), do: false

  defp start_conversation(message) do
    program_params = PossiblePogramMessage.handle_start_conversation(message)

    params = %{
      "user" => message,
      "program_message" => program_params["program_message"],
      "token" => program_params["token"]
    }

    Messages.update_conversation(params)
    params["program_message"]
  end
end
