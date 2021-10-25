# frozen_string_literal: true

require_relative '../spec_helper'

describe FetchBalance do
  let(:address) { 'secureaddress' }
  let(:service) { described_class.call(address) }

  context 'when response is successful' do
    let(:body) { File.read(File.expand_path(File.join('spec', 'fixtures', 'txs.json'))) }

    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/#{address}/txs")
        .to_return(status: 200, body: body )
    end

    it 'returns value' do
      expect(service).to eq(1.0e-06)
    end
  end

  context 'when response is failure' do
    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/#{address}/txs")
        .to_return(status: 404)
    end

    it 'fails' do
      expect { service }.to raise_error("Can't fetch txouts")
    end
  end
end
