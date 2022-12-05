defmodule Day1 do
  def part_1(list) do
    calories_per_elf(list)
    |>Enum.max()
  end

  def part_2(list) do
    calories_per_elf(list)
    |>Enum.sort(:desc)
    |>Enum.take(3)
    |>Enum.sum()
  end

  def calories_per_elf(list) do
    parse_elves_inventories(list)
    |>Enum.map(fn ei -> compute_elve_inventory(ei) end)
  end

  def parse_elves_inventories(list) do
    Enum.map(list, fn ei -> String.split(ei, "\n") end)
  end

  def compute_elve_inventory(list) do
    Enum.filter(list, fn i-> i != ""end)
    |>Enum.map(fn e -> String.to_integer(e) end)
    |>Enum.sum()
  end

  def solution() do
    file_path = System.argv
    contents = Util.readFile(file_path)
    inventories = contents |> String.split("\n\n")

    IO.inspect(Day1.part_1(inventories))
    IO.inspect(Day1.part_2(inventories))
  end
end
