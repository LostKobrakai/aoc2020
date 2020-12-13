defmodule Aoc2020.Day13 do
  def part1() do
    part1(load_input())
  end

  def part1(input) do
    [ts, list] = String.split(input, "\n", trim: true)

    running_ids =
      String.split(list, ",", trim: true)
      |> Enum.reject(fn id -> id == "x" end)
      |> Enum.map(&String.to_integer/1)

    ts = String.to_integer(ts)

    map =
      Map.new(running_ids, fn id ->
        next_departure = trunc((div(ts, id) + 1) * id)

        {next_departure - ts, id}
      end)

    min_wait_time = map |> Map.keys() |> Enum.min()
    id = Map.fetch!(map, min_wait_time)

    id * min_wait_time
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    [_ts, list] = String.split(input, "\n", trim: true)

    String.split(list, ",", trim: true)
    |> Enum.with_index()
    |> Enum.reject(fn {id, _} -> id == "x" end)
    |> Enum.reduce({0, 1}, fn {bus, index}, {t, step} ->
      bus = String.to_integer(bus)

      t =
        Stream.unfold(t, fn t -> {t, t + step} end)
        |> Stream.filter(fn t -> rem(t + index, bus) == 0 end)
        |> Enum.at(0)

      {t, lcm(step, bus)}
    end)
    |> elem(0)
  end

  defp lcm(a, b) do
    div(a * b, Integer.gcd(a, b))
  end

  def part2_bruteforce(input) do
    [_ts, list] = String.split(input, "\n", trim: true)

    ids =
      String.split(list, ",", trim: true)
      |> Enum.with_index()
      |> Enum.reject(fn {id, _} -> id == "x" end)
      |> Enum.map(fn {num, index} -> {String.to_integer(num), index} end)

    Stream.iterate(0, &(&1 + 1))
    |> Stream.filter(fn ts ->
      Enum.all?(ids, fn {id, offset} ->
        rem(ts + offset, id) == 0
      end)
    end)
    |> Enum.at(0)
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/13/notes.txt")

    File.read!(path)
  end
end
