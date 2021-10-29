# frozen_string_literal: true

require_relative '../../spec_helper'

describe Miniwallet::Balance do
  let(:privkey) { 'privkey' }
  let(:address) { 'secureaddress' }
  let(:service) { described_class.new(privkey).get }

  before do
    key = double
    allow(Bitcoin::Key).to receive(:new).and_return(key)
    allow(key).to receive(:addr).and_return(address)
  end

  context 'when response is successful' do
    let(:body) { File.read(File.expand_path(File.join('spec', 'fixtures', 'utxo.json'))) }

    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/secureaddress/utxo")
        .to_return(status: 200, body: body )
    end

    it 'returns value' do
      expect(service).to eq(1457938 / 100_000_000.0)
    end
  end

  context 'when response is failure' do
    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/#{address}/utxo")
        .to_return(status: 404)
    end

    it 'fails' do
      expect { service }.to raise_error("Can't fetch utxo")
    end
  end
end
