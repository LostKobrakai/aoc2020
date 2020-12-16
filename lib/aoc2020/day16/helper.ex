defmodule Aoc2020.Day16.Parser.Helper do
  import NimbleParsec

  def number_until(terminator) do
    repeat(
      lookahead_not(ascii_char(List.wrap(terminator)))
      |> utf8_char([?0..?9])
    )
    |> reduce({__MODULE__, :number, []})
  end

  def to_range(combinator) do
    reduce(combinator, {__MODULE__, :range, []})
  end

  def range([a, b]), do: a..b

  def number(list) do
    list |> List.to_string() |> String.to_integer()
  end
end
