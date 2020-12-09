# Operating System: macOS
# CPU Information: AMD Ryzen 5 3600X 6-Core Processor
# Number of Available Cores: 12
# Available memory: 16 GB
# Elixir 1.11.1
# Erlang 23.0

# Benchmark suite executing with the following configuration:
# warmup: 2 s
# time: 5 s
# memory time: 0 ns
# parallel: 1
# inputs: none specified
# Estimated total run time: 14 s

# Benchmarking list...
# Benchmarking queue...

# Name            ips        average  deviation         median         99th %
# queue        561.57        1.78 ms    ±16.02%        1.67 ms        3.13 ms
# list         458.77        2.18 ms     ±2.21%        2.17 ms        2.38 ms

# Comparison:
# queue        561.57
# list         458.77 - 1.22x slower +0.40 ms

input = Aoc2020.Day9.load_input()
search = Aoc2020.Day9.part1(input)

Benchee.run(%{
  "list" => fn -> Aoc2020.Day9.part2(input, search) end,
  "queue" => fn -> Aoc2020.Day9.part2_queue(input, search) end
})
