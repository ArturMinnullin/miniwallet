module Miniwallet
  SATOSHIS_PER_BITCOIN = 100_000_000.0
end

require_relative 'miniwallet/balance'
require_relative 'miniwallet/key'
require_relative 'miniwallet/sender'
require_relative 'miniwallet/transaction'
