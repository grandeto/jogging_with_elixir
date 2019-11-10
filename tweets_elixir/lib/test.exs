defmodule Test do
    def prev(a,b), do: a+b

    def next(c,d), do: c+d

    def last(e), do: e*e

    def test do
        Enum.reduce([1,2,3], 0, fn el, acc -> calc(el, acc) end)
    end

    def mest do
        Enum.reduce([1,2,3], 0, fn _, acc -> acc + 1 end)
    end

    def rest do
        Enum.reduce([1, "not a number", 2, :x, 3], 0, 
            fn el, acc when is_number(el) -> acc + 1
               _, acc -> acc
        end)
    end

    defp calc(el, acc) when is_integer(el) and is_integer(acc) do
        if el > 1 do
            acc + 1
        else
            acc
        end
    end
end