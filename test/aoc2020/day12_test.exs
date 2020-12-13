defmodule Aoc2020.Day12Test do
  use ExUnit.Case, async: true
  require Logger

  describe "part 1" do
    test "example 1" do
      stream =
        """
        F10
        N3
        F7
        R90
        F11
        """
        |> String.split("\n", trim: true)

      assert 25 = Aoc2020.Day12.part1(stream)
    end
  end

  describe "part 2" do
    test "example 1" do
      stream =
        """
        F10
        N3
        F7
        R90
        F11
        """
        |> String.split("\n", trim: true)

      assert 286 = Aoc2020.Day12.part2(stream)
    end
  end
end
