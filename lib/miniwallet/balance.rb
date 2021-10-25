require 'uri'
require 'net/http'
require 'json'

module Miniwallet
  class Balance
    def self.get
      new.call
    end

    attr_reader :address

    def initialize
      @address = "tb1q0v47kzs36at4r43n7m0pukc6zmrftulelz32azlda76avycf6vwqj5wtm2"
    end

    def call
      values = get_txouts.select { |o| o['scriptpubkey_address'] == address }
      values.sum { |v| v['value'] } / SATOSHIS_PER_BITCOIN
    end

    private

    def get_txouts
      txs = Miniwallet::Transaction.new(address).list
      txs.filter_map { |o| o['vout'] if o['status']['confirmed'] }.flatten.uniq
    end
  end
end
