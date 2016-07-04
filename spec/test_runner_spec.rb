require_relative './spec_helper'


class File
  def unlink
  end
end


describe 'running' do
  let(:runner) { TestHook.new('exunit_command' => 'elixir') }
  let(:file) { File.new('spec/data/sample.exs') }

  describe '#run_test_command' do
    it { expect(runner.command_line(file.path)).to include('elixir spec/data/sample.exs') }
  end

  describe '#run!' do
    context 'on simple passed file' do
      let(:original_results) { ['.', :passed] }
      let(:results) { runner.post_process_file(file, *original_results) }

      it { expect(results).to eq(["```\n.\n```", :passed]) }
    end
  end
end
