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
# Estimated total run time: 21 s

# Benchmarking brute_force...
# Benchmarking for...
# Benchmarking half_half...

# Name                  ips        average  deviation         median         99th %
# half_half          4.67 K      213.96 μs     ±6.54%         212 μs         254 μs
# brute_force        3.65 K      274.19 μs     ±6.43%         271 μs         329 μs
# for                1.39 K      718.90 μs     ±3.24%         716 μs      804.58 μs

# Comparison:
# half_half          4.67 K
# brute_force        3.65 K - 1.28x slower +60.23 μs
# for                1.39 K - 3.36x slower +504.94 μs

Benchee.run(
  %{
    "half_half" => fn -> Aoc2020.Day1.day1_part1() end,
    "brute_force" => fn -> Aoc2020.Day1.day1_part1_alt() end,
    "for" => fn -> Aoc2020.Day1.day1_part1_for() end
  }
)
