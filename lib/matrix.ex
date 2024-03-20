defmodule Matrix do
  def create(rows, cols, default_value \\ nil) when is_integer(rows) and is_integer(cols) and rows > 0 and cols > 0 do
    Enum.map(1..rows, fn _ ->
      Enum.map(1..cols, fn _ ->
        default_value
      end)
    end)
  end
end
