module MiniWallet
  class Sender
    attr_reader :key, :to_address

    def initialize(privkey, to_address)
      @key = Bitcoin::Key.new(privkey)
      @to_address = to_address
    end

    def send(value)
      balance = Miniwallet::Balance.new(key.priv).get
      raise 'Error: balance is lower than transaction value' if balance < value

      transaction = Miniwallet::Transaction.new(key.addr)
      prev_tx = Bitcoin::P::Tx.new(transaction.last)
      prev_out_index = 0

      tx = transaction.build(to_address, value, prev_tx, prev_out_index, key)
      JSON.parse(tx.to_json)['hash']
    end
  end
end
