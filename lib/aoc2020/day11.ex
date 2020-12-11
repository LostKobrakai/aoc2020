defmodule Aoc2020.Day11 do
  defmodule Simulation do
    use GenServer
    require Logger

    defmodule State do
      defstruct map: %{}, size: {0, 0}, stable?: false, calculator: :num_taken_seates_adjecent

      def new({input, taken_seats_calculator}) do
        new(input)
        |> struct!(calculator: taken_seats_calculator)
      end

      def new(input) do
        map =
          for {line, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
              {place, x} <- line |> String.split("", trim: true) |> Enum.with_index(),
              into: %{} do
            {{x, y}, type(place)}
          end

        keys = Map.keys(map)
        max_x = keys |> Enum.map(fn {x, _y} -> x end) |> Enum.max()
        max_y = keys |> Enum.map(fn {_x, y} -> y end) |> Enum.max()

        %__MODULE__{map: map, size: {max_x, max_y}}
      end

      def tick(%__MODULE__{map: map} = state) do
        changes =
          for coordinate <- Map.keys(map),
              current = Map.fetch!(map, coordinate),
              current != :floor,
              reduce: %{} do
            acc ->
              num = apply(__MODULE__, state.calculator, [state, coordinate])

              action =
                case state.calculator do
                  :num_taken_seates_adjecent -> :action
                  :num_taken_seates_visible -> :action_alternative
                end

              case apply(__MODULE__, action, [current, num]) do
                :take -> Map.put(acc, coordinate, {:seat, :taken})
                :leave -> Map.put(acc, coordinate, {:seat, :empty})
                _ -> acc
              end
          end

        updated_map = Map.merge(map, changes)
        stable? = map == updated_map

        struct!(state, map: updated_map, stable?: stable?)
      end

      @doc false
      def num_taken_seates_adjecent(state, coordinate) do
        for c <- coordinates_around(coordinate, state.size),
            current = Map.fetch!(state.map, c),
            current == {:seat, :taken},
            reduce: 0 do
          acc -> acc + 1
        end
      end

      @doc false
      def num_taken_seates_visible(state, coordinate) do
        [
          find_in_direction(state, coordinate, fn {x, y} -> {x - 1, y - 1} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x - 1, y} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x - 1, y + 1} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x, y - 1} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x, y + 1} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x + 1, y - 1} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x + 1, y} end),
          find_in_direction(state, coordinate, fn {x, y} -> {x + 1, y + 1} end)
        ]
        |> Enum.count(fn x -> x == :taken end)
      end

      defp find_in_direction(state, coordinate, direction) do
        coordinate = direction.(coordinate)

        if valid_coordinate?(coordinate, state.size) do
          case Map.fetch!(state.map, coordinate) do
            :floor -> find_in_direction(state, coordinate, direction)
            {:seat, :taken} -> :taken
            {:seat, :empty} -> :empty
          end
        else
          :none
        end
      end

      def num_seats_taken(%__MODULE__{map: map}) do
        Enum.count(map, fn {_, x} -> x == {:seat, :taken} end)
      end

      defp type("#"), do: {:seat, :taken}
      defp type("L"), do: {:seat, :empty}
      defp type("."), do: :floor

      defp type_reverse({:seat, :taken}), do: "#"
      defp type_reverse({:seat, :empty}), do: "L"
      defp type_reverse(:floor), do: "."

      defp coordinates_around({x, y} = self, size) do
        above = y - 1
        line = y
        below = y + 1

        left = x - 1
        column = x
        right = x + 1

        for y <- [above, line, below],
            x <- [left, column, right],
            {x, y} != self,
            valid_coordinate?({x, y}, size) do
          {x, y}
        end
      end

      defp valid_coordinate?({x, y}, {max_x, max_y}) do
        x in 0..max_x and y in 0..max_y
      end

      @doc false
      def action({:seat, :empty}, 0), do: :take
      def action({:seat, :taken}, num) when num >= 4, do: :leave
      def action(_, _), do: :nothing

      @doc false
      def action_alternative({:seat, :empty}, 0), do: :take
      def action_alternative({:seat, :taken}, num) when num >= 5, do: :leave
      def action_alternative(_, _), do: :nothing

      def to_string(%__MODULE__{map: map, size: {max_x, max_y}}) do
        for y <- 0..max_y, into: "" do
          for x <- 0..max_x, into: "" do
            map |> Map.fetch!({x, y}) |> type_reverse()
          end
          |> Kernel.<>("\n")
        end
      end

      defimpl String.Chars do
        def to_string(state) do
          State.to_string(state)
        end
      end
    end

    def start_link(input) do
      GenServer.start_link(__MODULE__, input)
    end

    def tick(pid) do
      GenServer.call(pid, :tick, 15000)
    end

    @impl GenServer
    def init(input) do
      state = State.new(input)
      {:ok, state}
    end

    @impl GenServer
    def handle_call(:tick, _from, state) do
      state = State.tick(state)
      {:reply, state, state}
    end
  end

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    {:ok, sim} = Simulation.start_link(input)
    state = tick_till_stable(sim)
    Simulation.State.num_seats_taken(state)
  end

  defp tick_till_stable(sim) do
    case Simulation.tick(sim) do
      %{stable?: true} = state -> state
      _ -> tick_till_stable(sim)
    end
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    {:ok, sim} = Simulation.start_link({input, :num_taken_seates_visible})
    state = tick_till_stable(sim)
    Simulation.State.num_seats_taken(state)
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/11/seating_area.txt")

    File.read!(path)
  end
end
