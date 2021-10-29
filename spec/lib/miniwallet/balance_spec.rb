# frozen_string_literal: true

require_relative '../../spec_helper'

describe MiniWallet::Balance do
  let(:privkey) { 'privkey' }
  let(:service) { described_class.new.get(privkey) }

  before do
    allow_any_instance_of(Bitcoin::Key).to recieve(:addr).and_return('secureaddress')
  end

  context 'when response is successful' do
    let(:body) { File.read(File.expand_path(File.join('spec', 'fixtures', 'txs.json'))) }

    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/secureaddress/txs/chain")
        .to_return(status: 200, body: body )
    end

    it 'returns value' do
      expect(service).to eq(1.0e-06)
    end
  end

  context 'when response is failure' do
    before do
      stub_request(:get, "https://blockstream.info/testnet/api/address/#{address}/txs/chain")
        .to_return(status: 404)
    end

    it 'fails' do
      expect { service }.to raise_error("Can't fetch txouts")
    end
  end
end
