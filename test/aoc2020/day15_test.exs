defmodule Aoc2020.Day15Test do
  use ExUnit.Case, async: true
  require Logger

  describe "part 1" do
    test "example 1" do
      assert 436 = Aoc2020.Day15.part1("0,3,6")
    end
  end

  describe "part 2" do
    test "example 1" do
      assert 175_594 = Aoc2020.Day15.part2("0,3,6")
    end
  end
end
