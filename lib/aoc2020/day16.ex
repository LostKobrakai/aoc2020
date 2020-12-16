defmodule Aoc2020.Day16 do
  defmodule Parser do
    import NimbleParsec
    require Aoc2020.Day16.Parser.Helper, as: Helper

    # class: 1-3 or 5-7
    # row: 6-11 or 33-44
    # seat: 13-40 or 45-50

    # your ticket:
    # 7,1,14

    # nearby tickets:
    # 7,3,47
    # 40,4,50
    # 55,2,20
    # 38,6,12

    field =
      repeat(
        lookahead_not(ascii_char([?:]))
        |> utf8_char([])
      )
      |> reduce({List, :to_string, []})
      |> unwrap_and_tag(:name)

    range =
      Helper.number_until(?-)
      |> ignore(string("-"))
      |> concat(Helper.number_until(?\s))
      |> Helper.to_range()
      |> unwrap_and_tag(:range)

    rule =
      field
      |> ignore(string(": "))
      |> repeat(
        lookahead_not(ascii_char([?\n]))
        |> choice([
          ignore(string(" or ")),
          range
        ])
      )
      |> tag(:rule)

    rules =
      repeat(
        lookahead_not(ascii_string([?\n], 2))
        |> choice([
          ignore(ascii_char([?\n])),
          rule
        ])
      )

    ticket_number = Helper.number_until([?,])

    ticket =
      repeat(
        lookahead_not(ascii_char([?\n]))
        |> choice([
          ignore(ascii_char([?,])),
          ticket_number
        ])
      )
      |> tag(:ticket)

    tickets =
      repeat(
        choice([
          eos(),
          ascii_string([?\n], 2)
        ])
        |> lookahead_not()
        |> choice([
          ignore(ascii_char([?\n])),
          ticket
        ])
      )

    my_ticket =
      eventually(ignore(string("your ticket:\n")))
      |> concat(tickets)
      |> unwrap_and_tag(:mine)

    other_tickets =
      eventually(ignore(string("nearby tickets:\n")))
      |> concat(tickets)
      |> tag(:others)

    defparsec(:notes, rules |> concat(my_ticket) |> concat(other_tickets) |> reduce(:format))

    defp format(x) do
      Enum.reduce(x, %{rules: %{}, ticket: [], others: []}, fn
        {:rule, details}, acc ->
          name = Keyword.fetch!(details, :name)
          ranges = Keyword.get_values(details, :range)
          Map.update!(acc, :rules, &Map.put(&1, name, ranges))

        {:mine, {:ticket, values}}, acc ->
          Map.put(acc, :ticket, values)

        {:others, tickets}, acc ->
          tickets = Keyword.get_values(tickets, :ticket)
          Map.put(acc, :others, tickets)
      end)
    end
  end

  def part1() do
    part1(load_input())
  end

  def part1(input) do
    case Parser.notes(input) do
      {:ok, [data], "", _, _, _} ->
        ranges = for {_name, ranges} <- data.rules, range <- ranges, do: range

        for numbers <- data.others, number <- numbers, reduce: 0 do
          acc ->
            result = Enum.any?(ranges, fn range -> number in range end)
            if result, do: acc, else: acc + number
        end

      _ ->
        :error
    end
  end

  def part2() do
    part2(load_input())
  end

  def part2(input) do
    case Parser.notes(input) do
      {:ok, [data], "", _, _, _} ->
        ranges = for {_name, ranges} <- data.rules, range <- ranges, do: range

        valid =
          Enum.filter(data.others, fn numbers ->
            Enum.all?(numbers, fn number ->
              Enum.any?(ranges, fn range -> number in range end)
            end)
          end)

        columns = valid |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

        indexes =
          data.rules
          |> Map.new(fn {name, ranges} ->
            indexes =
              columns
              |> Enum.with_index()
              |> Enum.filter(fn {numbers, _} ->
                Enum.all?(numbers, fn number ->
                  Enum.any?(ranges, fn range -> number in range end)
                end)
              end)
              |> Enum.map(fn {_, i} -> i end)

            {name, indexes}
          end)
          |> Enum.sort_by(fn {_, indexes} -> length(indexes) end, :asc)
          |> Enum.map_reduce([], fn {name, indexes}, acc ->
            [last] = indexes -- acc
            {{name, last}, [last | acc]}
          end)
          |> elem(0)
          |> Map.new()

        for {<<"departure", _::binary>>, index} <- indexes, reduce: 1 do
          acc ->
            value = Enum.at(data.ticket, index)
            acc * value
        end

      _ ->
        :error
    end
  end

  @doc false
  def load_input do
    path = Application.app_dir(:aoc_2020, "priv/inputs/16/notes.txt")

    File.read!(path)
  end
end
