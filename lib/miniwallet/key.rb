module Miniwallet
  class Key
    def create
      curve = OpenSSL::PKey::EC.new('secp256k1')
      curve.generate_key

      curve.private_key.to_s(16)
    end
  end
end
