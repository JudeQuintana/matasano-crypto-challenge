# http://cryptopals.com/sets/1/challenges/2/

class FixedXOR

  def initialize(msg_enc_hex_string, key_enc_hex_string)
    @msg_enc_str = msg_enc_hex_string
    @key_enc_str = key_enc_hex_string

    raise ArgumentError, "Strings are not of the same length!" if @msg_enc_str.length != @key_enc_str.length
  end

  def encrypt_msg_with_xor
    msg_decoded_string = [@msg_enc_str].pack("H*")
    key_decoded_string = [@key_enc_str].pack("H*")

    xor_result =""

    for i in 0..(msg_decoded_string.length-1)
      xor_result << (msg_decoded_string[i].bytes.first ^ key_decoded_string[i].bytes.first).to_s(16)
    end

    xor_result
  end

end