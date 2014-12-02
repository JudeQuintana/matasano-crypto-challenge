# http://cryptopals.com/sets/1/challenges/2/
require_relative '../modules/conversion'

class FixedXOR
  include Conversion

  def initialize(msg_hex_string, key_hex_string)
    @msg_hex_str = msg_hex_string
    @key_hex_str = key_hex_string

    raise ArgumentError, "Strings are not of the same length!" if @msg_hex_str.length != @key_hex_str.length
  end

  def encrypt_msg
    msg_bytes = decode_hex(@msg_hex_str).bytes
    key_bytes = decode_hex(@key_hex_str).bytes

    encrypted_string =""

    for i in 0..(msg_bytes.length-1)
      encrypted_string << (msg_bytes[i] ^ key_bytes[i])
    end

    encode_hex(encrypted_string)
  end

  def decrypt_msg
    encrypt_msg
  end
end