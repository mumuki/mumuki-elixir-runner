require_relative 'spec_helper'

describe ElixirTestHook do
  def req(test, extra, content)
    OpenStruct.new(test:test, extra:extra, content: content)
  end

  true_test = <<elixir
test "the truth" do
  assert true
end
elixir

  compiled_test_submission = "ExUnit.start\ndefmodule ElixirServer do\n  def x do 2 end\n  \n  use ExUnit.Case, async: true\n  test \"the truth\" do\n  assert true\nend\n\nend\n"

  describe '#compile' do
    let(:compiler) { ElixirTestHook.new }
    it { expect(compiler.compile_file_content(req(true_test, 'def x do 2 end',  ''))).to eq(compiled_test_submission) }
  end
end
