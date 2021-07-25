defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(0), do: "0"

  def convert(number) do
    result =
      [
        {3, "Pling"},
        {5, "Plang"},
        {7, "Plong"}
      ]
      |> Enum.reduce("", fn {factor, text}, result ->
        if rem(number, factor) == 0, do: result <> text, else: result
      end)

    if result == "" do
      Integer.to_string(number)
    else
      result
    end
  end
end
