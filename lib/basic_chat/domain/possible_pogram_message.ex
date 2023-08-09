defmodule BasicChat.Domain.PossiblePogramMessage do
  @moduledoc """
  Module responsable for make all proccess response
  """
  alias BasicChat.Messages

  @doc """
  create params

  ## Examples
    iex> BasicChat.Domain.PossiblePogramMessage.handle_start_conversation("Bom dia!")
    %{
      "user" => "Bom dia!",
      "program_message" => "Bom dia!",
      "token" => "SJF2FJ02FI2FEFM2UEF2HEF92FU922EFU9F29EUF9E22"  #token of the message user
    }
  """
  def handle_start_conversation(message) do
    create_params(message)
  end

  @doc """
  handle with conversations started

  ## Examples
    iex> BasicChat.Domain.PossiblePogramMessage.handle_conversation("Bom dia!")
    Bom dia! novamente!
  """
  def handle_conversation(new_message, archived_message) do
    if archived_message =~ new_message do
      new_message
      |> analyse_to_response(true)
    else
      params = create_params(new_message)
      Messages.update_conversation(params)
      params["program_message"]
    end
  end

  defp create_params(message) do
    %{
      "user" => message,
      "program_message" => analyse_to_response(message),
      "token" => generate_hash(message)
    }
  end

  defp analyse_to_response(message, said \\ false) do
    message
    |> String.split(~r/[,!]./)
    |> Enum.map(&(&1 |> String.trim() |> String.downcase()))
    |> Enum.map(&levenshtein_similarity(&1))
    |> Enum.concat()
    |> generate_message("", said)
  end

  defp generate_hash(string) do
    :sha256
    |> :crypto.hash(string)
    |> Base.encode16()
  end

  defp levenshtein_similarity(setence) do
    Enum.map(BasicChat.Data.list_keys(), fn key ->
      if setence =~ key or key =~ setence do
        key
      end
    end)
    |> Enum.reject(&is_nil(&1))
  end

  defp generate_message(list_keys, text_acc, said, count \\ 0)

  defp generate_message([h | t], text_acc, said, count) do
    repeat_phases = choose_random_index(BasicChat.Data.repeat_phrases)

    find_text = choose_random_index(BasicChat.Data.match_response(h))

    message =
      """
      #{text_acc}
      #{if said and count == 0,
        do: (if not is_nil(find_text), do: find_text, else: "") <> " " <> repeat_phases,
        else: find_text}
      """

    generate_message(t, message, said, count + 1)
  end

  defp generate_message([], text_acc, _said, _count) when text_acc != "",
    do: text_acc |> String.trim()

  defp generate_message([], _text_acc, _said, _count),
    do: choose_random_index(BasicChat.Data.not_found_match_response)

  defp choose_random_index(list) do
    list
    |> Enum.take_random(1)
    |> Enum.at(0)
  end
end
