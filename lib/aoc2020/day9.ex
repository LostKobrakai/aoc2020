defmodule Aoc2020.Day9 do
  def part1() do
    part1(load_input())
  end

  def part1(input, preamble \\ 25) do
    input
    |> Stream.chunk_every(preamble + 1, 1)
    |> Enum.find_value(fn list ->
      {total, options} = List.pop_at(list, -1)

      combinations =
        for a <- options, b <- options, uniq: true do
          [a, b] |> Enum.sort() |> List.to_tuple()
        end

      valid? = Enum.any?(combinations, fn {a, b} -> a + b == total end)

      unless valid?, do: total
    end)
  end

  def part2() do
    input = load_input()
    part2(input, part1(input))
  end

  def part2(input, search) do
    list =
      input
      |> Stream.chunk_while([], chunk_fun(search), &after_fun/1)
      |> Enum.at(0)

    Enum.min(list) + Enum.max(list)
  end

  defp chunk_fun(total) do
    fn element, acc ->
      with_element = [element | acc]
      check_sum(with_element, total)
    end
  end

  defp check_sum(with_element, total) do
    case Enum.sum(with_element) do
      ^total -> {:cont, with_element, List.delete_at(with_element, -1)}
      t when t < total -> {:cont, with_element}
      t when t > total -> check_sum(List.delete_at(with_element, -1), total)
    end
  end

  defp after_fun(acc), do: {:cont, acc}

  def part2_queue() do
    input = load_input()
    part2_queue(input, part1(input))
  end

  def part2_queue(input, search) do
    list =
      input
      |> Stream.chunk_while(:queue.new(), chunk_fun_queue(search), &after_fun/1)
      |> Enum.at(0)

    Enum.min(list) + Enum.max(list)
  end

  defp chunk_fun_queue(total) do
    fn element, acc ->
      with_element = :queue.in(element, acc)
      check_sum_queue(with_element, total)
    end
  end

  defp check_sum_queue(with_element, total) do
    case with_element |> :queue.to_list() |> Enum.sum() do
      ^total ->
        {_, rest} = :queue.out(with_element)
        {:cont, with_element |> :queue.to_list(), rest}

      t when t < total ->
        {:cont, with_element}

      t when t > total ->
        {_, rest} = :queue.out(with_element)
        check_sum_queue(rest, total)
    end
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/09/stream.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end
end
