defmodule Day9 do
  def main() do
    File.read!("lib/day9/input")
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> transform_integer_representation_to_memory()
    |> reschedule_memory()
    |> IO.inspect()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {val, idx}, acc -> acc + idx * val end)
  end

  def transform_integer_representation_to_memory(integers) do
    IO.puts("Making the memory!")
    do_transform(integers, 0, [], 0) |> Enum.reverse()
  end

  defp do_transform([], _file_id, acc, _idx), do: acc

  defp do_transform([h | t], file_id, acc, idx) do
    IO.puts(idx)
    value = if rem(idx, 2) == 0, do: file_id, else: -1 |> IO.inspect()
    block = List.duplicate(value, h) |> IO.inspect()
    new_acc = Enum.reverse(block) ++ acc
    new_file_id = if rem(idx, 2) == 0, do: file_id + 1, else: file_id |> IO.inspect()
    do_transform(t, new_file_id, new_acc, idx + 1)
  end

  def reschedule_memory(mem), do: do_reschedule(mem, mem)

  defp do_reschedule(full_mem, []), do: full_mem

  defp do_reschedule(full_mem, [_ | t]) do
    case List.last(full_mem) do
      -1 ->
        do_reschedule(Enum.drop(full_mem, -1), t)

      last ->
        case Enum.find_index(full_mem, &(&1 == -1)) do
          nil ->
            full_mem

          idx ->
            updated =
              full_mem
              |> List.replace_at(idx, last)
              |> List.replace_at(length(full_mem) - 1, -1)

            do_reschedule(updated, t)
        end
    end
  end
end
