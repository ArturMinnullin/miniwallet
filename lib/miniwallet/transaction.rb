require 'bitcoin'
require 'net/http';
require 'json';

module Miniwallet
  class Transaction
    ESPLORA_API_BASE = 'https://blockstream.info/testnet/api'
    TXS_PER_PAGE = 25
    FEE = 0.0001

    include Bitcoin::Builder

    attr_reader :address

    def initialize(address)
      @address = address
    end

    def unspent_tx_list
      res = Net::HTTP.get_response(URI("#{ESPLORA_API_BASE}/address/#{address}/utxo"))
      return [] unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)
    end

    def get_binary_by_id(id)
      res = Net::HTTP.get_response(URI("#{ESPLORA_API_BASE}/tx/#{id}/raw"))
      res.body
    end

    def create(to:, amount:, inputs:, key:)
      new_tx = build_tx do |t|
        inputs.each do |input|
          t.input do |i|
            i.prev_out input.obj
            i.prev_out_index input.index
            i.signature_key key
          end
        end

        t.output do |o|
          o.value amount * SATOSHIS_PER_BITCOIN
          o.script { |s| s.recipient to }
        end

        unspents_total = inputs.sum(&:amount) / SATOSHIS_PER_BITCOIN
        change = unspents_total - (amount + FEE)
        t.output do |o|
          o.value change * SATOSHIS_PER_BITCOIN
          o.script { |s| s.recipient address }
        end
      end

      req = Net::HTTP.post(
        URI("#{ESPLORA_API_BASE}/tx"), new_tx.payload.unpack("H*").first, 'Content-Type' => 'application/json'
      )
      req.body
    end
  end
end
