require 'bitcoin'

module Miniwallet
  class Balance
    attr_reader :address

    def initialize(privkey)
      @address = Bitcoin::Key.new(privkey).addr
    end

    def get
      txs = Miniwallet::Transaction.new(address).unspent_tx_list
      total = txs.filter_map { |o| o['value'] if o['status']['confirmed'] }.sum

      total / SATOSHIS_PER_BITCOIN
    end
  end
end
