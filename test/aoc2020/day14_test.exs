defmodule Aoc2020.Day4Test do
  use ExUnit.Case, async: true
  require Logger

  describe "part 1" do
    test "example 1" do
      input =
        """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
        """
        |> String.split("\n", trim: true)

      assert 165 = Aoc2020.Day14.part1(input)
    end
  end

  describe "part 2" do
    test "example 1" do
      input =
        """
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
        """
        |> String.split("\n", trim: true)

      assert 208 = Aoc2020.Day14.part2(input)
    end
  end
end
