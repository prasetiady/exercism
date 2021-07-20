defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/[:!&@$%^,.]/, "")
    |> String.downcase()
    |> String.split([" ", "_"])
    |> Enum.reduce(%{}, fn word, map ->
      if String.length(word) > 0 do
        count = if Map.has_key?(map, word), do: Map.get(map, word) + 1, else: 1
        Map.put(map, word, count)
      else
        map
      end
    end)
  end
end
