module Miniwallet
  class Key
    def self.create
      key = new.create

      File.write('private_key', key)
    end

    def create
      generate_key
    end

    private

    def generate_key
      curve = OpenSSL::PKey::EC.new('secp256k1')
      curve.generate_key

      private_key = curve.private_key.to_s(16)
      public_key = curve.public_key.to_bn.to_s(16)

      private_key
    end

    def public_key_hash(hex)
      Digest::RMD160.hexdigest([hex].pack("H*"))
    end
  end
end
