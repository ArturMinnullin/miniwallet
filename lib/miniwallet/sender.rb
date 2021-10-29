module Miniwallet
  class Sender
    attr_reader :key, :to_address

    def initialize(privkey, to_address)
      @key = Bitcoin::Key.new(privkey)
      @to_address = to_address
    end

    def send(amount)
      transaction = Miniwallet::Transaction.new(key.addr)
      inputs = get_inputs(transaction)
      if inputs.sum(&:amount) < amount + Miniwallet::Transaction::FEE
        raise 'Error: balance is lower than transaction value'
      end

      tx = transaction.build(to: to_address, amount: amount, inputs: inputs, key: key)
      tx.hash
    end

    private

    def get_inputs(transaction)
      @inputs ||= transaction.unspent_tx_list.map do |t|
        tx = transaction.get_binary_by_id(t['txid'])
        OpenStruct.new(obj: Bitcoin::P::Tx.new(tx), index: t['vout'], amount: t['value'])
      end
    end
  end
end
