class GetKey
  def self.call(address)
    new(address).call
  end

  attr_reader :address

  def initialize(address)
    @address = address
  end

  def call
    key = generate_key

    File.write('private_key', key)
  end

  private

  def generate_key
    curve = OpenSSL::PKey::EC.new('secp256k1')
    curve.generate_key

    private_key = curve.private_key.to_s(16)
    public_key = curve.public_key.to_bn.to_s(16)

    pub_key_hash = public_key_hash(public_key_hex)
  end

  def public_key_hash(hex)
    Digest::RMD160.hexdigest([hex].pack("H*"))
  end
end
