require_relative './spec_helper'

describe 'running' do
  let(:runner) { ElixirTestHook.new }
  let(:file) { File.new('spec/data/sample.exs') }

  describe '#run_test_command' do
    it { expect(runner.command_line(file.path)).to include('elixir spec/data/sample.exs') }
  end

  describe '#run!' do
    context 'on simple passed file' do
      let(:original_results) { ['.', :passed] }
      let(:results) { runner.post_process_file(file, *original_results) }

      it { expect(results).to eq([".", :passed]) }
    end
  end
end
