ExUnit.start
defmodule.ElixirServer do
  def the_truth do
    true
  end
  use ExUnit.Case, async: true

    test "the truth" do
        assert true
    end
    test "more truth" do
        assert the_truth
    end
end