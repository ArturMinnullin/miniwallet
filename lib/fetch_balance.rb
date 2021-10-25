require 'uri'
require 'net/http'
require 'json'

class FetchBalance
  ESPLORA_API_BASE = 'https://blockstream.info/testnet/api'
  SATOSHIS_PER_BITCOIN = 100_000_000_000.0

  def self.call(address)
    new(address).call
    # new("tb1q0v47kzs36at4r43n7m0pukc6zmrftulelz32azlda76avycf6vwqj5wtm2").call
  end

  attr_reader :address

  def initialize(address)
    @address = address
  end

  def call
    address_values = get_txouts.select { |o| o['scriptpubkey_address'] == address }
    address_values.sum { |v| v['value'] } / SATOSHIS_PER_BITCOIN
  end

  private

  def get_txouts
    uri = URI("#{ESPLORA_API_BASE}/address/#{address}/txs")
    res = Net::HTTP.get_response(uri)
    raise "Can't fetch txouts" unless res.is_a?(Net::HTTPSuccess)

    JSON.parse(res.body).filter_map { |o| o['vout'] if o['status']['confirmed'] }.flatten.uniq
  end
end
