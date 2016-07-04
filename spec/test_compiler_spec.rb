require_relative 'spec_helper'

describe TestHook do
  def req(test, extra, content)
    OpenStruct.new(test:test, extra:extra, content: content)
  end

  true_test = <<elixir
    test "the truth" do
      assert true
    end
elixir

  compiled_test_submission = <<elixir
x = 2


ExUnit.start
defmodule AssertionTest do
  use ExUnit.Case, async: true
    test "the truth" do
      assert true
    end

end
elixir

  describe '#compile' do
    let(:compiler) { TestHook.new(nil) }
    it { expect(compiler.compile_file_content(req(true_test, 'x = 2',  ''))).to eq(compiled_test_submission) }
  end
end
