require_relative './spec_helper'
require 'ostruct'

describe ElixirQueryHook do
  let(:hook) { ElixirQueryHook.new(nil) }
  let(:file) { hook.compile(request) }
  let(:result) {
    hook.run!(file)
  }


  context 'integral query' do
    let(:request) { OpenStruct.new(query: '5') }
    it { expect(result[0]).to eq "5\n" }
  end

  context 'string query' do
    let(:request) { OpenStruct.new(query: '"hello"') }
    it { expect(result[0]).to eq "\"hello\"\n" }
  end

  context 'array query' do
    let(:request) { OpenStruct.new(query: '[1,2,3]') }
    it { expect(result[0]).to eq "[1, 2, 3]\n" }
  end

  context 'function query' do
    let(:request) { OpenStruct.new(query: 'def x do end') }
    it { expect(result[0]).to eq "<function>\n" }
  end

  context 'query with plus' do
    let(:request) { OpenStruct.new(query: '4+5') }
    it { expect(result[0]).to eq "9\n" }
  end

  context 'query and content' do
    context 'no cookie' do
      let(:request) { OpenStruct.new(query: 'x', content: 'x=2*2') }
      it { expect(result[0]).to eq "4\n" }
    end

    context 'with cookie' do
      let(:request) { OpenStruct.new(query: 'x + y', cookie: ['y = 5'], content: 'x = 4') }
      it { expect(result[0]).to eq "9\n" }
    end
  end

  context 'query and extra' do
    let(:request) { OpenStruct.new(query: 'y', extra: 'y=64+2') }
    it { expect(result[0]).to eq "66\n" }
  end
end
