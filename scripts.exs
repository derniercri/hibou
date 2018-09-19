defmodule Helper do
  def process([line | tail], lines) do
    new_lines =
      case String.contains?(line, "{:phoenix,") do
        false ->
          [line]

        true ->
          [
            line,
            "      {:hibou, path: \"../\"},",
            "      {:guardian, \"~> 1.0\"},"
          ]
      end

    process(tail, lines ++ new_lines)
  end

  def process([], lines) do
    lines
  end
end

path = "#{List.first(System.argv())}/mix.exs"
lines = Helper.process(File.read!(path) |> String.split("\n"), [])
File.write!(path, Enum.join(lines, "\n"))
