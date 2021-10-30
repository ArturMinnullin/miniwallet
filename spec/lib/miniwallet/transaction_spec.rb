# frozen_string_literal: true

require_relative '../../spec_helper'

describe Miniwallet::Transaction do
  let(:privkey) { 'privkey' }
  let(:address) { 'secureaddress' }
  let(:service) { described_class.new(privkey) }

  before do
    key = double
    allow(Bitcoin::Key).to receive(:new).and_return(key)
    allow(key).to receive(:addr).and_return(address)
  end

  describe '#get_binary_by_id' do
    before do
      allow(Net::HTTP).to receive(:get_response).with(URI("https://blockstream.info/testnet/api/tx/tx_id/raw"))
        .and_return(double(body: ''))
    end

    it 'makes request to raw' do
      service.get_binary_by_id('tx_id')

      expect(Net::HTTP).to have_received(:get_response)
        .with(URI("https://blockstream.info/testnet/api/tx/tx_id/raw"))
        .once
    end
  end
end
