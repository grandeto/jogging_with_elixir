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
