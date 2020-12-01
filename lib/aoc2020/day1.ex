defmodule Aoc2020.Day1 do
  @magic 2020

  def day1_part1 do
    half = div(@magic, 2)
    list = load_report()

    {lower, higher} = Enum.split_with(list, fn x -> x < half end)

    Enum.reduce_while(lower, :error, fn num, :error ->
      case Enum.find(higher, fn x -> x + num == @magic end) do
        nil -> {:cont, :error}
        x -> {:halt, {:ok, num * x}}
      end
    end)
  end

  def day1_part1_alt do
    list = load_report()

    try do
      for x <- list, y <- list, x + y == @magic do
        throw(x * y)
      end

      :error
    catch
      num -> {:ok, num}
    end
  end

  def day1_part1_for do
    list = load_report()

    result = for x <- list, y <- list, x + y == @magic, do: x * y

    case result do
      [num | _] -> {:ok, num}
      _ -> :error
    end
  end

  def day1_part2 do
    list = load_report()

    try do
      for x <- list, y <- list, z <- list, x + y + z == @magic do
        throw(x * y * z)
      end

      :error
    catch
      num -> {:ok, num}
    end
  end

  def day1_part2_optimized do
    list = load_report()

    try do
      for x <- list,
          rest = @magic - x,
          y <- list,
          y < rest,
          rest = @magic - x - y,
          z <- list,
          z <= rest,
          x + y + z == @magic,
          do: throw(x * y * z)

      :error
    catch
      num -> {:ok, num}
    end
  end

  @doc false
  def load_report do
    path = Application.app_dir(:aoc_2020, "priv/inputs/01/expense_report.txt")

    path
    |> File.stream!()
    |> Stream.map(fn line ->
      line
      |> String.trim()
      |> String.to_integer()
    end)
    |> Enum.to_list()
  end
end
