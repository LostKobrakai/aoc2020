defmodule Aoc2020.Day4 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    input
    |> parse_input()
    |> Enum.count(&valid_by_corrected_policy?/1)
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.count(&valid_by_improved_corrected_policy?/1)
  end

  defp parse_input(stream) do
    stream
    |> (fn stream ->
          # IO.inspect(Enum.to_list(stream))
          stream
        end).()
    |> Stream.chunk_while([], &chunk_fun/2, &after_fun/1)
    |> (fn stream ->
          # IO.inspect(Enum.to_list(stream))
          stream
        end).()
    |> Stream.map(&reduce_to_map/1)
    |> Enum.to_list()
  end

  defp chunk_fun("\n", acc) do
    {:cont, acc, []}
  end

  defp chunk_fun(element, acc) do
    parts = String.split(element)
    {:cont, acc ++ parts}
  end

  defp after_fun([]), do: {:cont, []}
  defp after_fun(parts), do: {:cont, parts, []}

  defp reduce_to_map(parts) do
    for part <- parts, into: %{} do
      [key, value] = String.split(part, ":", parts: 2)
      {String.trim(key), String.trim(value)}
    end
  end

  @password_requirements ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
  defp valid_by_corrected_policy?(map) do
    (@password_requirements -- ["cid"])
    |> Enum.all?(fn key -> Map.has_key?(map, key) end)
  end

  defp valid_by_improved_corrected_policy?(map) do
    (@password_requirements -- ["cid"])
    |> Enum.all?(fn key ->
      Map.has_key?(map, key) && valid_value?(key, map[key])
    end)
  end

  defp valid_value?("byr", value) do
    valid_year?(value, 1920..2002)
  rescue
    _ -> false
  end

  defp valid_value?("iyr", value) do
    valid_year?(value, 2010..2020)
  rescue
    _ -> false
  end

  defp valid_value?("eyr", value) do
    valid_year?(value, 2020..2030)
  rescue
    _ -> false
  end

  defp valid_value?("hgt", value) do
    case Integer.parse(value) do
      {num, "cm"} -> num in 150..193
      {num, "in"} -> num in 59..76
    end
  rescue
    _ -> false
  end

  defp valid_value?("hcl", value) do
    <<"#", hex::binary>> = value
    ^hex = String.downcase(hex)
    {_, ""} = Integer.parse(hex, 16)
  rescue
    _ -> false
  end

  defp valid_value?("ecl", value) do
    value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  rescue
    _ -> false
  end

  defp valid_value?("pid", value) do
    9 = byte_size(value)
    {_, ""} = Integer.parse(value)
  rescue
    _ -> false
  end

  defp valid_year?(value, range) do
    4 = byte_size(value)
    int = String.to_integer(value)
    int in range
  rescue
    _ -> false
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/04/batch.txt")

    path
    |> File.stream!()
  end
end
