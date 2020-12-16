defmodule Aoc2020.Day16Test do
  use ExUnit.Case, async: true
  require Logger

  describe "part 1" do
    test "example 1" do
      input = """
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
      """

      assert 71 = Aoc2020.Day16.part1(input)
    end
  end

  # describe "part 2" do
  #   test "example 1" do
  #     input = """
  #     939
  #     7,13,x,x,59,x,31,19
  #     """

  #     assert 1_068_781 = Aoc2020.Day16.part2(input)
  #   end
  # end
end
