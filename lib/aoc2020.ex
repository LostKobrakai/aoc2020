defmodule Aoc2020 do
  @moduledoc """
  Documentation for `Aoc2020`.
  """

  defdelegate day1_part1(), to: Aoc2020.Day1
  defdelegate day1_part2(), to: Aoc2020.Day1, as: :day1_part2_optimized

  defdelegate day2_part1(), to: Aoc2020.Day2, as: :part1
  defdelegate day2_part2(), to: Aoc2020.Day2, as: :part2

  defdelegate day3_part1(), to: Aoc2020.Day3, as: :part1
  defdelegate day3_part2(), to: Aoc2020.Day3, as: :part2

  defdelegate day4_part1(), to: Aoc2020.Day4, as: :part1
  defdelegate day4_part2(), to: Aoc2020.Day4, as: :part2

  defdelegate day5_part1(), to: Aoc2020.Day5, as: :part1
  defdelegate day5_part2(), to: Aoc2020.Day5, as: :part2

  defdelegate day6_part1(), to: Aoc2020.Day6, as: :part1
  defdelegate day6_part2(), to: Aoc2020.Day6, as: :part2

  defdelegate day7_part1(), to: Aoc2020.Day7, as: :part1
  defdelegate day7_part2(), to: Aoc2020.Day7, as: :part2

  defdelegate day8_part1(), to: Aoc2020.Day8, as: :part1
  defdelegate day8_part2(), to: Aoc2020.Day8, as: :part2

  defdelegate day9_part1(), to: Aoc2020.Day9, as: :part1
  defdelegate day9_part2(), to: Aoc2020.Day9, as: :part2_queue

  defdelegate day10_part1(), to: Aoc2020.Day10, as: :part1
  defdelegate day10_part2(), to: Aoc2020.Day10, as: :part2

  defdelegate day11_part1(), to: Aoc2020.Day11, as: :part1
  defdelegate day11_part2(), to: Aoc2020.Day11, as: :part2

  defdelegate day12_part1(), to: Aoc2020.Day12, as: :part1
  defdelegate day12_part2(), to: Aoc2020.Day12, as: :part2

  defdelegate day13_part1(), to: Aoc2020.Day13, as: :part1
  defdelegate day13_part2(), to: Aoc2020.Day13, as: :part2

  defdelegate day14_part1(), to: Aoc2020.Day14, as: :part1
  defdelegate day14_part2(), to: Aoc2020.Day14, as: :part2

  defdelegate day15_part1(), to: Aoc2020.Day15, as: :part1
  defdelegate day15_part2(), to: Aoc2020.Day15, as: :part2

  defdelegate day16_part1(), to: Aoc2020.Day16, as: :part1
  defdelegate day16_part2(), to: Aoc2020.Day16, as: :part2
end
