defmodule Bob do
  def hey(input) do
    cond do
      String.match?(input, ~r/!.*\..*\?$/) -> "Sure."
      String.match?(input, ~r/^\w+.*\?[ ]+$/) -> "Sure."
      String.match?(input, ~r/^\s*$/) -> "Fine. Be that way!"
      String.match?(input, ~r/[A-Z]{4,}.*\?$/) -> "Calm down, I know what I'm doing!"
      String.match?(input, ~r/[A-Z]{4,}|\d+.*!$/) -> "Whoa, chill out!"
      String.match?(input, ~r/[-!\n]|[A-Z]{3,}|\?.+$/) -> "Whatever."
      String.match?(input, ~r/^[1-9, ]*$/) -> "Whatever."
      String.match?(input, ~r/^[ ]+.*$/) -> "Whatever."
      String.match?(input, ~r/^\w+.*[ ]+$/) -> "Whatever."
      String.match?(input, ~r/!$/) -> "Whoa, chill out!"
      String.match?(input, ~r/[А-Я]{3,}/) -> "Whoa, chill out!"
      true -> "Sure."
    end
  end
end
