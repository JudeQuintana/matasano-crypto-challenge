# http://cryptopals.com/sets/1/challenges/1/

class Hex2Base64Digest

  def initialize(hex_string)
    @hex_str = hex_string
  end

  def convert
    [[@hex_str].pack("H*")].pack("m0")
  end

end