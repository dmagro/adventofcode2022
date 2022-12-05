defmodule Day2 do
  @play_points %{R: 1, P: 2, S: 3}
  @win_against %{R: :S, P: :R, S: :P}
  @lose_against %{R: :P, P: :S, S: :R}

  def runner(rounds, strategy) do
    Enum.map(rounds, fn r -> String.split(r, " ") end)
    |> Enum.map(fn r -> strategy.(r) end)
    |> Enum.sum()
  end

  def part_1(round) do
    [opponents, my] = round
    opponent_play = decode_opponent_play(opponents)
    my_play = decode_my_play(my)
    my_play_wins_against = @win_against[my_play]

    round_outcome = case opponent_play do
      ^my_play_wins_against -> 6
      ^my_play -> 3
      _ -> 0
    end

    round_outcome + @play_points[my_play]
  end

  def part_2(round) do
    [opponents, outcome] = round
    opponent_play = decode_opponent_play(opponents)
    outcome_points = round_outcome_points(outcome)
    my_play= my_play(opponent_play, outcome_points)

    outcome_points + @play_points[my_play]
  end

  def decode_opponent_play(play) do
    case play do
      "A" -> :R
      "B" -> :P
      "C" -> :S
    end
  end

  def decode_my_play(play) do
    case play do
      "X" -> :R
      "Y" -> :P
      "Z" -> :S
    end
  end

  def round_outcome_points(round_outcome) do
    case round_outcome do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
    end
  end

  def my_play(opponent_play, outcome_points) do
    case outcome_points do
      0 -> @win_against[opponent_play]
      3 -> opponent_play
      6 -> @lose_against[opponent_play]
    end
  end

  def solution() do
    file_path = System.argv
    contents = Util.readFile(file_path)
    rounds = contents |> String.split("\n", trim: true)

    IO.inspect(Day2.runner(rounds, &part_1/1))
    IO.inspect(Day2.runner(rounds, &part_2/1))
  end
end
