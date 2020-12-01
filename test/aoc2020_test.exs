defmodule Aoc2020Test do
  use ExUnit.Case, async: true
  doctest Aoc2020

  describe "Day 1: Report Repair - Part 1" do
    test "expense report" do
      assert {:ok, 651_651} = Aoc2020.day1_part1()
    end
  end

  describe "Day 1: Report Repair - Part 2" do
    test "expense report" do
      assert {:ok, 214_486_272} = Aoc2020.day1_part2()
    end
  end
end
