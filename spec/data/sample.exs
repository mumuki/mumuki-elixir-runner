ExUnit.start
defmodule AssertionTest do
  use ExUnit.Case, async: true

    test "the truth" do
        assert true
    end

    test "more truth" do
        assert (true || false)
    end
end