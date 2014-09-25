# http://cryptopals.com/sets/1/challenges/2/

class FixedXOR

  def initialize(msg_hex_string, key_hex_string)
    @msg_hex_str = msg_hex_string
    @key_hex_str = key_hex_string

    raise ArgumentError, "Strings are not of the same length!" if @msg_hex_str.length != @key_hex_str.length
  end

  def encrypt_msg_with_xor
    msg_bin_string = decode_hex(@msg_hex_str)
    key_bin_string = decode_hex(@key_hex_str)

    xor_result =""

    for i in 0..(msg_bin_string.length-1)
      xor_result << (msg_bin_string[i].bytes.first ^ key_bin_string[i].bytes.first).to_s(16)
    end

    xor_result
  end

  private

  def decode_hex(hex_string)
    [hex_string].pack("H*")
  end

end