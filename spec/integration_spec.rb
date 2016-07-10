require 'spec_helper'
require 'mumukit/bridge'

describe 'integration test' do
  let(:bridge) { Mumukit::Bridge::Bridge.new('http://localhost:4567') }

  before(:all) do
    @pid = Process.spawn 'rackup -p 4567', err: '/dev/null'
    sleep 3
  end
  after(:all) { Process.kill 'TERM', @pid }

  it 'answers a valid hash when submission is ok' do
    response = bridge.run_tests!(test: '
    test "more truth" do
        assert true
    end',
                                 extra: '',
                                 content: "x = 2",
                                 expectations: [])

    expect(response[:result]).to include('0 failures')
    expect(response[:response_type]).to be(:unstructured)
    expect(response[:test_result]).to be_nil
    expect(response[:status]).to be(:passed)
    expect(response[:feedback]).to be_empty
    expect(response[:expectation_results]).to be_empty
  end

  it 'answers a valid hash when submission is not ok' do
    response = bridge.
        run_tests!(test: '
class TestFoo(unittest.TestCase):
    def test_true(self):
        self.assertFalse(foo())',
                   extra: '',
                   content: 'dsfsdf(asas',
                   expectations: []).
        reject { |k, _v| k == :result }

    expect(response).to eq(status: :failed,
                           expectation_results: [],
                           feedback: '',
                           test_results: [],
                           response_type: :unstructured)
  end

end
