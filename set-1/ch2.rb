# http://cryptopals.com/sets/1/challenges/2/

class FixedXOR

  def initialize(encoded_string_1, encoded_string_2)
    @enc_str_1 = encoded_string_1
    @enc_str_2 = encoded_string_2

    raise ArgumentError, "Strings are not of the same length!" if @enc_str_1.length != @enc_str_2.length
  end

  def xor_combo
    decoded_string_1 = [@enc_str_1].pack("H*")
    decoded_string_2 = [@enc_str_2].pack("H*")

    result =""

    for i in 0..(decoded_string_1.length-1)
      result << (decoded_string_1[i].bytes.first ^ decoded_string_2[i].bytes.first).to_s(16)
    end

    result
  end

end