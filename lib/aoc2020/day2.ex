defmodule Aoc2020.Day2 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    for line <- input,
        parsed = parse(line),
        valid_policy_one?(parsed),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    for line <- input,
        parsed = parse(line),
        valid_policy_two?(parsed),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  defp parse(line) do
    %{input: line, min: nil, max: nil, char: nil, password: nil}
    |> parse_min()
    |> parse_max()
    |> parse_char_and_password()
  end

  defp parse_min(%{input: <<min::binary-size(2), "-", rest::binary>>} = map) do
    %{map | input: rest, min: String.to_integer(min)}
  end

  defp parse_min(%{input: <<min::binary-size(1), "-", rest::binary>>} = map) do
    %{map | input: rest, min: String.to_integer(min)}
  end

  defp parse_max(%{input: <<max::binary-size(2), " ", rest::binary>>} = map) do
    %{map | input: rest, max: String.to_integer(max)}
  end

  defp parse_max(%{input: <<max::binary-size(1), " ", rest::binary>>} = map) do
    %{map | input: rest, max: String.to_integer(max)}
  end

  defp parse_char_and_password(%{input: <<char::binary-size(1), ": ", password::binary>>} = map) do
    %{map | input: "", char: char, password: password}
  end

  defp valid_policy_one?(parsed) do
    count =
      parsed.password
      |> String.codepoints()
      |> Enum.filter(fn char -> char == parsed.char end)
      |> Enum.count()

    count in parsed.min..parsed.max
  end

  defp valid_policy_two?(parsed) do
    at_min = String.at(parsed.password, parsed.min - 1)
    at_max = String.at(parsed.password, parsed.max - 1)

    cond do
      at_min == at_max and at_min == parsed.char -> false
      at_min == parsed.char -> true
      at_max == parsed.char -> true
      true -> false
    end
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/02/passwords.txt")

    path
    |> File.stream!()
    |> Stream.map(fn line -> String.trim(line) end)
  end
end
