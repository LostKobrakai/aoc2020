defmodule Aoc2020.Day8 do
  defmodule Bootloader do
    defstruct instructions: %{}, index: -1, acc: 0, visited_instructions: []

    def new(instructions) do
      map =
        for {instruction, index} <- Stream.with_index(instructions, 0), into: %{} do
          {index, parse_instruction(instruction)}
        end

      %__MODULE__{instructions: map}
    end

    defp parse_instruction(<<instruction::binary-size(3), " ", integer::binary>>)
         when instruction in ["acc", "jmp", "nop"] do
      {int, ""} = Integer.parse(integer)
      {String.to_atom(instruction), int}
    end

    def run(%__MODULE__{} = bootloader) do
      case tick(bootloader) do
        {:ok, {:exit, bootloader}} -> {:ok, bootloader}
        {:ok, bootloader} -> run(bootloader)
        error -> error
      end
    end

    def attempt_fixing(%__MODULE__{} = bootloader) do
      for i <- 0..(Enum.count(bootloader.instructions) - 1),
          (bootloader.instructions |> Map.fetch!(i) |> elem(0)) in [:nop, :jmp],
          bootloader = replace_instruction(bootloader, i),
          {:ok, bootloader} <- [run(bootloader)] do
        bootloader
      end
    end

    defp replace_instruction(bootloader, i) do
      struct!(bootloader,
        instructions:
          Map.update!(bootloader.instructions, i, fn
            {:nop, num} -> {:jmp, num}
            {:jmp, num} -> {:nop, num}
          end)
      )
    end

    def tick(%__MODULE__{} = bootloader) do
      bootloader
      |> move_index()
      |> execute_instruction()
    end

    defp move_index(bootloader) do
      Map.update!(bootloader, :index, &(&1 + 1))
    end

    defp execute_instruction(bootloader) do
      with {:ok, bootloader} <- prevent_infinite_loop(bootloader),
           {:ok, %_{} = bootloader} <- at_end(bootloader) do
        updated =
          case Map.fetch!(bootloader.instructions, bootloader.index) do
            {:acc, num} -> Map.update!(bootloader, :acc, &(&1 + num))
            {:jmp, num} -> Map.update!(bootloader, :index, &(&1 + num - 1))
            {:nop, _} -> bootloader
          end

        {:ok, updated}
      end
    end

    defp at_end(bootloader) do
      if bootloader.index >= Enum.count(bootloader.instructions) do
        {:ok, {:exit, bootloader}}
      else
        {:ok, Map.update!(bootloader, :visited_instructions, &[bootloader.index | &1])}
      end
    end

    defp prevent_infinite_loop(bootloader) do
      if bootloader.index in bootloader.visited_instructions do
        {:error, {:inf, bootloader}}
      else
        {:ok, Map.update!(bootloader, :visited_instructions, &[bootloader.index | &1])}
      end
    end
  end

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    input
    |> Bootloader.new()
    |> Bootloader.run()
    |> case do
      {:error, {:inf, bootloader}} -> bootloader.acc
    end
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    [bootloader | _] =
      input
      |> Bootloader.new()
      |> Bootloader.attempt_fixing()

    bootloader.acc
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/08/instructions.txt")

    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
