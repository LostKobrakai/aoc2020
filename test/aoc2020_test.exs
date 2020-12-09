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

  describe "Day 2: Password Philosophy - Part 1" do
    test "invalid password count" do
      assert 416 = Aoc2020.day2_part1()
    end
  end

  describe "Day 2: Password Philosophy - Part 2" do
    test "invalid password count" do
      assert 688 = Aoc2020.day2_part2()
    end
  end

  describe "Day 3: Toboggan Trajectory - Part 1" do
    test "tree count on path" do
      assert 169 = Aoc2020.day3_part1()
    end
  end

  describe "Day 3: Toboggan Trajectory - Part 2" do
    test "invalid password count" do
      assert 7_560_370_818 = Aoc2020.day3_part2()
    end
  end

  describe "Day 4: Passport Processing - Part 1" do
    test "tree count on path" do
      assert 245 = Aoc2020.day4_part1()
    end
  end

  describe "Day 4: Passport Processing - Part 2" do
    test "invalid password count" do
      assert 133 = Aoc2020.day4_part2()
    end
  end

  describe "Day 5: Binary Boarding - Part 1" do
    test "tree count on path" do
      assert 826 = Aoc2020.day5_part1()
    end
  end

  describe "Day 5: Binary Boarding - Part 2" do
    test "invalid password count" do
      assert 678 = Aoc2020.day5_part2()
    end
  end

  describe "Day 6: Custom Customs - Part 1" do
    test "tree count on path" do
      assert 6778 = Aoc2020.day6_part1()
    end
  end

  describe "Day 6: Custom Customs - Part 2" do
    test "invalid password count" do
      assert 3406 = Aoc2020.day6_part2()
    end
  end

  describe "Day 7: Handy Haversacks - Part 1" do
    test "tree count on path" do
      assert 242 = Aoc2020.day7_part1()
    end
  end

  describe "Day 7: Handy Haversacks - Part 2" do
    test "invalid password count" do
      assert 176_035 = Aoc2020.day7_part2()
    end
  end

  describe "Day 8: Handheld Halting - Part 1" do
    test "tree count on path" do
      assert 1753 = Aoc2020.day8_part1()
    end
  end

  describe "Day 8: Handheld Halting - Part 2" do
    test "invalid password count" do
      assert 733 = Aoc2020.day8_part2()
    end
  end

  describe "Day 9: Encoding Error - Part 1" do
    test "tree count on path" do
      assert 105_950_735 = Aoc2020.day9_part1()
    end
  end

  describe "Day 9: Encoding Error - Part 2" do
    test "invalid password count" do
      assert 13_826_915 = Aoc2020.day9_part2()
    end
  end
end
