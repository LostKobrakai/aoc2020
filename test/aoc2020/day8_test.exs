defmodule Aoc2020.Day8Test do
  use ExUnit.Case, async: true

  describe "part 1" do
    test "example 1" do
      instructions =
        """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        |> String.split("\n", trim: true)

      assert 5 = Aoc2020.Day8.part1(instructions)
    end
  end

  describe "part 2" do
    test "example 1" do
      instructions =
        """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        |> String.split("\n", trim: true)

      assert 8 = Aoc2020.Day8.part2(instructions)
    end
  end
end
