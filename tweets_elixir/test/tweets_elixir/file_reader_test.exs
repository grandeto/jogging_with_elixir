defmodule FileReaderTest do
    use ExUnit.Case
    import TweetsElixir.FileReader
    import Mock

    doctest TweetsElixir.FileReader
    test "Passing a file should return a string" do
        str = get_strings_to_tweet("priv/sample.txt")

        assert str != nil
    end

    test "Over 1400 lines are skipped" do
        str = get_strings_to_tweet("priv/test/too_long.txt")

        assert str == "short line"
    end

    @tag watching: true
    test "An empty string returns empty string" do
        with_mock File, [read!: fn(_) -> "" end] do
            str = get_strings_to_tweet("mocked-file.txt")

            assert str == ""
        end
    end

    @tag watching: true
    test "The string should be trimmed" do
        with_mock File, [read!: fn(_) -> " ABC " end] do
            str = get_strings_to_tweet("mocked-file.txt")

            assert str == "ABC"
        end
    end
end