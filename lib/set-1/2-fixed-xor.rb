# http://cryptopals.com/sets/1/challenges/2/
require_relative '../set-1/modules/conversion'

class FixedXOR
  include Conversion

  def initialize(msg_hex_string, key_hex_string)
    @msg_hex_str = msg_hex_string
    @key_hex_str = key_hex_string

    raise ArgumentError, "Strings are not of the same length!" if @msg_hex_str.length != @key_hex_str.length
  end

  def encrypt_msg
    msg_ascii_string = decode_hex(@msg_hex_str)
    key_ascii_string = decode_hex(@key_hex_str)

    encrypted_string =""

    for i in 0..(msg_ascii_string.length-1)
      encrypted_string << (msg_ascii_string[i].bytes.first ^ key_ascii_string[i].bytes.first)
    end

    encode_hex(encrypted_string)
  end

  def decrypt_msg
    encrypt_msg
  end
end