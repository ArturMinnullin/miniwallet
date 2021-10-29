module Miniwallet
  class Balance
    attr_reader :address

    def initialize(privkey)
      @address = Bitcoin::Key.new(privkey).addr
    end

    def get
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
