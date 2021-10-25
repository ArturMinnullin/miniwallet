module MiniWallet
  class Sender
    # FEE = 0.0001

    # include Bitcoin::Builder

    # def self.send(to_address, value)
    #   new(to_address, value).call
    # end

    # attr_reader :to_address, :value

    # def initialize(to_address, value)
    #   @to_address = to_address
    #   @value = value
    # end

    # def call
    #   Bitcoin.network = :testnet3

    #   prev_tx = Transaction.new(from_address).last
    #   prev_hash = prev_tx['txid']
    #   prev_out_index = 0

    #   # the key needed to sign an input that spends the previous output
    #   key = Bitcoin::Key.from_base58("92ZRu28m2GHSKaaF2W7RswJ2iJYpTzVhBaN6ZLs7TENCs4b7ML8")

    #   new_tx = build_tx do |t|
    #     # add the input you picked out earlier
    #     t.input do |i|
    #       i.prev_out prev_tx
    #       i.prev_out_index prev_out_index
    #       i.signature_key key
    #     end

    #     # add an output that sends some bitcoins to another address
    #     t.output do |o|
    #       o.value 50000000 # 0.5 BTC in satoshis
    #       o.script { |s| s.recipient to_address }
    #     end

    #     # add another output spending the remaining amount back to yourself
    #     # if you want to pay a tx fee, reduce the value of this output accordingly
    #     # if you want to keep your financial history private, use a different address
    #     t.output do |o|
    #       o.value 49000000 # 0.49 BTC, leave 0.01 BTC as fee
    #       o.script { |s| s.recipient key.addr }
    #     end
    #   end
    # end
  end
end
