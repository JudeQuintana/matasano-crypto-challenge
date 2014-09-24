# http://cryptopals.com/sets/1/challenges/1/

class Hex2Base64Digest

  def initialize(hex_encoded_string)
    @enc_str = hex_encoded_string
  end

  def convert
    [[@enc_str].pack("H*")].pack("m0")
  end

end