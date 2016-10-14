require 'spec_helper'
require 'mumukit/bridge'

describe 'integration test' do
  let(:bridge) { Mumukit::Bridge::Runner.new('http://localhost:4567') }

  before(:all) do
    @pid = Process.spawn 'rackup -p 4567', err: '/dev/null'
    sleep 3
  end
  after(:all) { Process.kill 'TERM', @pid }

  it 'answers a valid hash when submission is ok' do
    response = bridge.run_tests!(
        test: '
    test "more truth" do
        assert true
    end',
        extra: '',
        content: 'x = 2',
        expectations: [])

    expect(response.except(:result)).to eq response_type: :unstructured,
                                           test_results: [],
                                           status: :passed,
                                           feedback: '',
                                           expectation_results: []
  end


  it 'answers a valid hash when submission fails' do
    response = bridge.run_tests!(
        test: '
    test "more truth" do
        assert false
    end',
        extra: '',
        content: 'x = 2',
        expectations: [])

    expect(response.except(:result)).to eq response_type: :unstructured,
                                           test_results: [],
                                           status: :failed,
                                           feedback: '',
                                           expectation_results: []
  end

  it 'answers a valid hash when compilation fails' do
    response = bridge.run_tests!(
        test: '
    "more truth"
        assert false
    end',
        extra: '',
        content: 'x = 2',
        expectations: [])

    expect(response.except(:result)).to eq response_type: :unstructured,
                                           test_results: [],
                                           status: :errored,
                                           feedback: '',
                                           expectation_results: []
  end


  it 'supports queries that pass' do
    response = bridge.run_query!(query: 'x', extra: '', content: 'x = 1')

    expect(response[:status]).to eq(:passed)
    expect(response[:result]).to eq "1\n"
  end

  it 'supports queries that fails' do
    response = bridge.run_query!(query: 'raise "foo"', extra: '', content: 'x = 1')

    expect(response[:status]).to eq(:failed)
    expect(response[:result]).to include "** (RuntimeError) foo\n"
  end

  it 'supports queries that don\'t compile' do
    response = bridge.run_query!(query: 'bleh', extra: '', content: '')

    expect(response[:status]).to eq(:errored)
    expect(response[:result]).to include 'undefined function bleh/0'
  end
end
