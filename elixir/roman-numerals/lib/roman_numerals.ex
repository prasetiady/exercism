defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    {roman_number, _} =
      [
        {1000, "M"},
        {900, "CM"},
        {500, "D"},
        {400, "CD"},
        {100, "C"},
        {90, "XC"},
        {50, "L"},
        {40, "XL"},
        {10, "X"},
        {9, "IX"},
        {5, "V"},
        {4, "IV"},
        {1, "I"}
      ]
      |> Enum.reduce({"", number}, fn {value, symbol}, {roman_number, remaining_number} ->
        if number == 0 do
          {roman_number, remaining_number}
        else
          quotient = remaining_number |> div(value)
          roman_number = roman_number <> String.duplicate(symbol, quotient)
          remaining_number = remaining_number - value * quotient
          {roman_number, remaining_number}
        end
      end)

    roman_number
  end
end
