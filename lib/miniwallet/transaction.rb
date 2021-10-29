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

    def list
      result = []

      loop do
        last_id = result.last.nil? ? nil : result.last['txid']
        txs = next_page(last_id)
        result += txs
        break if txs.count < TXS_PER_PAGE
      end

      result
    end

    def last
      id = next_page.first['txid']
      res = Net::HTTP.get_response(URI("#{ESPLORA_API_BASE}/tx/#{id}/raw"))

      res.body
    end

    def build(to, value, prev_tx, prev_out_index, key)
      build_tx do |t|
        t.input do |i|
          i.prev_out prev_tx
          i.prev_out_index prev_out_index
          i.signature_key key
        end

        t.output do |o|
          o.value value * SATOSHIS_PER_BITCOIN
          o.script { |s| s.recipient to }
        end

        t.output do |o|
          o.value (value - FEE) * SATOSHIS_PER_BITCOIN
          o.script { |s| s.recipient address }
        end
      end
    end

    private

    def next_page(last_id = nil)
      base_url = "#{ESPLORA_API_BASE}/address/#{address}/txs/chain"
      url = last_id.nil? ? URI(base_url) : URI("#{base_url}/#{last_id}")
      res = Net::HTTP.get_response(url)
      return [] unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)
    end
  end
end
