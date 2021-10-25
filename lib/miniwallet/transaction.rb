module Miniwallet
  class Transaction
    ESPLORA_API_BASE = 'https://blockstream.info/testnet/api'

    attr_reader :address

    def initialize(address)
      @address = address
    end

    def list
      result = []

      loop do
        last_id = result.last&.[]('txid')
        txs = next_page(last_id)
        result += txs
        break if txs.count < 25
      end

      result
    end

    def last
      next_page.first
    end

    private

    def next_page(last_id = nil)
      res = Net::HTTP.get_response(url(last_id))

      return [] unless res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    end

    def url(last_id)
      base_url = "#{ESPLORA_API_BASE}/address/#{address}/txs/chain"
      return URI(base_url) if last_id.nil?

      URI("#{base_url}/#{last_id}")
    end
  end
end
