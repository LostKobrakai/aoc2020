defmodule Aoc2020.Day11Test do
  use ExUnit.Case, async: true
  require Logger
  alias Aoc2020.Day11.Simulation

  describe "part 1" do
    test "example 1 - ticks" do
      stream = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      {:ok, sim} = Simulation.start_link(stream)

      Logger.info("Tick 1")

      assert """
             #.##.##.##
             #######.##
             #.#.#..#..
             ####.##.##
             #.##.##.##
             #.#####.##
             ..#.#.....
             ##########
             #.######.#
             #.#####.##
             """ = Simulation.tick(sim) |> to_string()

      Logger.info("Tick 2")

      assert """
             #.LL.L#.##
             #LLLLLL.L#
             L.L.L..L..
             #LLL.LL.L#
             #.LL.LL.LL
             #.LLLL#.##
             ..L.L.....
             #LLLLLLLL#
             #.LLLLLL.L
             #.#LLLL.##
             """ = Simulation.tick(sim) |> to_string()

      Logger.info("Tick 3")

      assert """
             #.##.L#.##
             #L###LL.L#
             L.#.#..#..
             #L##.##.L#
             #.##.LL.LL
             #.###L#.##
             ..#.#.....
             #L######L#
             #.LL###L.L
             #.#L###.##
             """ = Simulation.tick(sim) |> to_string()

      Logger.info("Tick 4")

      assert """
             #.#L.L#.##
             #LLL#LL.L#
             L.L.L..#..
             #LLL.##.L#
             #.LL.LL.LL
             #.LL#L#.##
             ..L.L.....
             #L#LLLL#L#
             #.LLLLLL.L
             #.#L#L#.##
             """ = Simulation.tick(sim) |> to_string()

      Logger.info("Tick 5")

      assert """
             #.#L.L#.##
             #LLL#LL.L#
             L.#.L..#..
             #L##.##.L#
             #.#L.LL.LL
             #.#L#L#.##
             ..L.L.....
             #L#L##L#L#
             #.LLLLLL.L
             #.#L#L#.##
             """ = Simulation.tick(sim) |> to_string()

      Logger.info("Tick 6")

      assert """
             #.#L.L#.##
             #LLL#LL.L#
             L.#.L..#..
             #L##.##.L#
             #.#L.LL.LL
             #.#L#L#.##
             ..L.L.....
             #L#L##L#L#
             #.LLLLLL.L
             #.#L#L#.##
             """ = Simulation.tick(sim) |> to_string()
    end

    test "example 1 - detects stable" do
      stream = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      {:ok, sim} = Simulation.start_link(stream)

      for _ <- 1..5, do: Simulation.tick(sim)

      assert %{stable?: true} = state = Simulation.tick(sim)
      assert 37 = Simulation.State.num_seats_taken(state)
    end
  end

  describe "part 2" do
    test "taken seats visible - example 1" do
      input = """
      .......#.
      ...#.....
      .#.......
      .........
      ..#L....#
      ....#....
      .........
      #........
      ...#.....
      """

      state = Simulation.State.new({input, :num_taken_seates_visible})
      assert 8 = Simulation.State.num_taken_seates_visible(state, {3, 4})
    end

    test "taken seats visible - example 2" do
      input = """
      .............
      .L.L.#.#.#.#.
      .............
      """

      state = Simulation.State.new({input, :num_taken_seates_visible})
      assert 0 = Simulation.State.num_taken_seates_visible(state, {1, 1})
    end

    test "taken seats visible - example 3" do
      input = """
      .##.##.
      #.#.#.#
      ##...##
      ...L...
      ##...##
      #.#.#.#
      .##.##.
      """

      state = Simulation.State.new({input, :num_taken_seates_visible})
      assert 0 = Simulation.State.num_taken_seates_visible(state, {3, 3})
    end

    test "example 1" do
      input = """
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
      """

      {:ok, sim} = Simulation.start_link({input, :num_taken_seates_visible})

      for _ <- 1..6, do: Simulation.tick(sim)

      assert %{stable?: true} = state = Simulation.tick(sim)
      assert 26 = Simulation.State.num_seats_taken(state)
    end
  end
end
