defmodule LoveVsFriendship do
    @doc """
        If　a = 1, b = 2, c = 3 ... z = 26

        Then l + o + v + e = 54

        and f + r + i + e + n + d + s + h + i + p = 108

        So friendship is twice stronger than love :-)

        The input will always be in lowercase and never be empty.
    """
    def love_vs_friendship(s) do
        alphabet = make_alphabet_map()

        String.split(s, "", trim: true) |>
        Enum.reduce(0, fn x, acc -> alphabet[x] + acc end)
    end

    def make_alphabet_map() do
        alphabet_list = Enum.map(Enum.to_list(?a..?z),
            fn x -> <<x>>
        end)

        alphabet_template_map = Enum.reduce(Enum.to_list(?a..?z), %{},
            fn x, acc -> Map.put(acc, <<x>>, 0)
        end)

        make_alphabet_map(alphabet_template_map, alphabet_list, 0, Enum.count(Enum.to_list(?a..?z)), %{})
    end

    def make_alphabet_map(alphabet_template_map, alphabet_list, val, count, acc) do
        if val == count do
            acc
        else
            x = Enum.at(alphabet_list, (val))
            acc = Map.put(acc, x, val + 1)
            val = val + 1
            make_alphabet_map(alphabet_template_map, alphabet_list, val, count, acc)
        end
    end
end

defmodule Zoo do
    def fix_the_meerkat(tuple) do
        Tuple.to_list(tuple)
        |> Enum.reverse
        |> List.to_tuple
    end
end

defmodule Cashier do
    def format_money(amount) do
      "$" <> :erlang.float_to_binary(amount, [decimals: 2])
    end
end

defmodule MappingAndFiltering do
  # 1. Given a list `["Alice Addison", "Bob Benetton"]`, you should (using `Enum.map`) return a list `[["Alice", "Addison"], ["Bob", "Benetton"]]`\
  # 2. Given a list `[%{name: "Alice Addison", age: 14}, %{name: "Bob Benetton", age: 21}, %{name: "Eve Elliot", age: 18}]`, return the following list: `["Alice Addison: 14 years old", "Bob Benetton: 21 years old", "Eve Elliot: 18 years old"]`
  # 3. Given the list from the previous task, made an additional case for when the age is "1", then it should output "<name>: 1 year old"
  # 4. Given the following list: ["An example sentence", "Another sentence", "Third sentence"], remove every sentence that has at least one "a"
  # 5. Given the following matrix: [[1, 2, 3], [4, 5, 6], [7, 8, 9]] Double every element of it, preserving the structure. Make so that it doesn’t matter what size the dimensions are.
  # 6. Given the matrix from the previous exercise, return only the even numbers, preserving the structure

  def task_one do
    Enum.map(["Alice Addison", "Bob Benetton"], fn x -> String.split(x) end )
  end

  def task_two do
    Enum.map([%{name: "Alice Addison", age: 14}, %{name: "Bob Benetton", age: 21}, %{name: "Eve Elliot", age: 18}], fn %{name: name, age: age} -> name <> ": " <> Integer.to_string(age) <> " years old" end)
  end

  def task_three do
    Enum.map([%{name: "Alice Addison", age: 1}, %{name: "Bob Benetton", age: 21}, %{name: "Eve Elliot", age: 18}],
    fn %{name: name, age: age} ->
      name <> ": " <>
      if age == 1,
      do: Integer.to_string(age) <> " year old",
      else: Integer.to_string(age) <> " years old" end)
  end

  def task_four do
    Enum.filter(["An example sentence", "Another sentence", "Third sentence"],
    fn str ->
      !(str =~ "a") and !(str =~ "A")
    end)
  end

  def task_five do
    Enum.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]],
      fn list ->
        Enum.map(list, fn x -> x*2 end)
      end)
  end

  def task_six do
    require Integer
    Enum.map([[1, 2, 3], [4, 5, 6], [7, 8, 9]],
      fn list ->
        Enum.filter(list, fn x -> Integer.is_even(x) end)
      end)
  end
end

defmodule Numbers.Operations do
    import Integer, only: [is_even: 1, is_odd: 1]

    def sumOdd(num_start, num_end),
        do: sumOdd(num_start, num_end, 0)
    def sumOdd(num_start, num_end, acc) when num_start == num_end,
        do: acc
    def sumOdd(num_start, num_end, acc) when is_even(num_start),
        do: sumOdd(num_start+1, num_end, acc)
    def sumOdd(num_start, num_end, acc) when is_odd(num_start),
        do: sumOdd(num_start+1, num_end, acc+num_start)

    def sumEven(num_start, num_end),
        do: sumEven(num_start, num_end, 0)
    def sumEven(num_start, num_end, acc) when num_start == num_end,
        do: acc
    def sumEven(num_start, num_end, acc) when is_odd(num_start),
        do: sumEven(num_start+1, num_end, acc)
    def sumEven(num_start, num_end, acc) when is_even(num_start),
        do: sumEven(num_start+1, num_end, acc+num_start)
end

defmodule ModulePlayground do
    import IO, only: [puts: 1]
    import Kernel, except: [inspect: 1]

    alias ModulePlayground.Misc.Util.Math, as: MyMath

    require Integer

    def say_here do
        inspect "I am Here"
    end

    def inspect(param1) do
        puts "Starting output"
        puts param1
        puts "Ending output"
    end

    def print_sum(a,b) do
        MyMath.add(a,b)
    end

    def print_is_even(num) do
        puts "#{num} is even? #{Integer.is_even(num)}"
    end
end

defmodule ModulePlayground.Misc.Util.Math do
    def add(a,b) do
        a + b
    end
end

defmodule Sample.Calendar do
    import IO

    def is_leap_year(year) when rem(year, 400) == 0, do: true
    def is_leap_year(year) when rem(year, 100) == 0, do: false
    def is_leap_year(year) when rem(year, 4) == 0, do: true
    def is_leap_year(year), do: false

    def day_of_the_week(day) when is_atom(day) do
        cond do
            day == :Monday ->
                "Mon"
            day == :Tuesday ->
                "Tu"
            day == :Wednesday ->
                "Wed"
            day == :Thursday ->
                "Thu"
            day == :Friday ->
                "Fri"
            day == :Saturday ->
                "Sat"
            day == :Sunday ->
                "Sun"
            true -> "Invalid day"
        end
    end

    # Switch(case)
    def day_of_the_week_case(day) when is_atom(day) do
        case day do
            :Monday ->
                "Mon"
            :Tuesday ->
                "Tu"
            :Wednesday ->
                "Wed"
            :Thursday ->
                "Thu"
            :Friday ->
                "Fri"
            :Saturday ->
                "Sat"
            :Sunday ->
                "Sun"
            _ -> "Invalid day"
        end
    end

    # Functioanal approach
    def day_of_the_week_func(:Monday), do: "Mon"
    def day_of_the_week_func(:Tuesday), do: "Tue"
    def day_of_the_week_func(:Wednesday), do: "Wed"
    def day_of_the_week_func(:Thursday), do: "Thu"
    def day_of_the_week_func(:Friday), do: "Fri"
    def day_of_the_week_func(:Saturday), do: "Sat"
    def day_of_the_week_func(:Sunday), do: "Sun"
    def day_of_the_week_func(_), do: "Invalid day"

    # Good pattern matching example
    def describe_date(date) do
        case date do
            {1,_,_} -> "Brand new month"
            {25,12,_} -> "Merry Christmas"
            {25,month,_} -> "Just #{12 - month} months till Christmas"
            {31,10,1517} -> "The Reformation is starting"
            {31,10,_} -> "Happy Helloween"
            {_,month,_} when month <= 12 -> "Just an avarage day"
            {_,_,_} -> "Invalid date"
        end
    end

    def send_tweet(path) do
        case path do
            {:ok, data} -> puts "Tweet sent: #{data}"
            {:error, error} -> puts "#{error}"
        end
    end
end

defmodule Sample.Enum do
    def first(list) when length(list) == 0, do: nil
    def first(list) do
        hd(list)
    end

    def first_new([]) do
        nil
    end
    # alternative syntax
    # def first_new([]), do: nil

    # Pattern matching
    def first_new([head | _]) do
        head
    end
    # alternative syntax
    # def first_new(head | _), do: head

    def add(list, val \\ 0) when is_list(list) do
        [val | list]
    end

    def map([], _), do: []
    def map([hd | tail], f) do
        [f.(hd) | map(tail, f)]
    end

    # Body recursion 1+1+1+0 = 3 and it doesn't touch order of the list
    def length1([]), do: 0
    def length1([_ | tail]) do
        1 + length1(tail)
    end

    # Tail recursion - last operation should be recursion.Avoids overflowing the stack. Donwside is reverse order of the lists
    def tail_length([_ | tail]) do
        tail_length(tail, 1)
    end
    def tail_length([], len) do
        len
    end
    def tail_length([_ | tail], len) do
        tail_length(tail, len + 1)
    end

    #
    # def other_map([head | tail], f),
    #     do: other_map(tail, f, [f.(head)])
    # def other_map([], _, result),
    #     do: result
    # def other_map([head | tail], f, result),
    #     do: other_map(tail, f, [f.(head | result)])
end

defmodule Sample.Lyrics do
    defp get_sentence(2) do
        IO.puts "2 beers"
    end
    defp get_sentence(1) do
        IO.puts "1 beer"
    end
    defp get_sentence(number) do
        IO.puts "#{number} beers"
    end

    # recursion
    def lyrics(), do: lyrics(100..1)
    def lyrics(first..last) when first <= last, do: get_sentence(first)
    def lyrics(first..last) do
        get_sentence(first)
        lyrics(first - 1..last)
    end
end

defmodule Sample.Utils do
    def square(a) do
        a*a
    end

    def sum(a,b) do
        a+b
    end

    def custom_func(a,f) do
        f.(a)
    end
    # Sample.Utils.custom_func(3, &Sample.Utils.square/1)
    # Sample.Utils.custom_func(3, fn(x) -> IO.puts(x) end) # anonymous func
    # Sample.Utils.custom_func( 3, &( IO.puts(&1) ) ) # anonymous func short syntax
end

