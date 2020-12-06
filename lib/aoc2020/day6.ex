defmodule Aoc2020.Day6 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    input
    |> Stream.chunk_while([], &chunk_fun/2, &after_fun/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp chunk_fun("", acc) do
    {:cont, Enum.uniq(acc), []}
  end

  defp chunk_fun(chars, acc) do
    {:cont, String.to_charlist(chars) ++ acc}
  end

  defp after_fun([]) do
    {:cont, []}
  end

  defp after_fun(acc) do
    {:cont, Enum.uniq(acc), []}
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    input
    |> Stream.chunk_while([], &chunk_fun_2/2, &after_fun_2/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp chunk_fun_2("", acc) do
    {:cont, count_answered_by_everyone(acc), []}
  end

  defp chunk_fun_2(chars, acc) do
    {:cont, [String.to_charlist(chars) | acc]}
  end

  defp after_fun_2([]) do
    {:cont, []}
  end

  defp after_fun_2(acc) do
    {:cont, count_answered_by_everyone(acc), []}
  end

  defp count_answered_by_everyone(answers) do
    uniq_answers =
      answers
      |> List.flatten()
      |> Enum.uniq()

    Enum.filter(uniq_answers, fn a ->
      Enum.all?(answers, fn person -> a in person end)
    end)
  end

  def part2_mapset(input) do
    input
    |> Stream.chunk_while([], &chunk_fun_2_mapset/2, &after_fun_2_mapset/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp chunk_fun_2_mapset("", acc) do
    {:cont, count_answered_by_everyone_mapset(acc), []}
  end

  defp chunk_fun_2_mapset(chars, acc) do
    {:cont, [String.to_charlist(chars) | acc]}
  end

  defp after_fun_2_mapset([]) do
    {:cont, []}
  end

  defp after_fun_2_mapset(acc) do
    {:cont, count_answered_by_everyone_mapset(acc), []}
  end

  defp count_answered_by_everyone_mapset(answers) do
    answers
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
  end

  def part2_optimized(input) do
    input
    |> Stream.chunk_while(:start, &chunk_fun_2_optimized/2, &after_fun_2_optimized/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp chunk_fun_2_optimized("", acc) do
    {:cont, acc, :start}
  end

  defp chunk_fun_2_optimized(chars, :start) do
    {:cont, String.to_charlist(chars)}
  end

  defp chunk_fun_2_optimized(chars, acc) do
    line = String.to_charlist(chars)
    {:cont, Enum.filter(acc, fn char -> char in line end)}
  end

  defp after_fun_2_optimized(:start) do
    {:cont, []}
  end

  defp after_fun_2_optimized(acc) do
    {:cont, acc, []}
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/06/forms.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
