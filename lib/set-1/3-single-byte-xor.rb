# http://cryptopals.com/sets/1/challenges/3/

class SingleByteXOR

  def initialize(encoded_hex_string, char_key_arr)
    @enc_hex_str = encoded_hex_string
    @char_key_arr = char_key_arr
  end

  def decrypt_msg
    possible_solutions = {}

    @char_key_arr.each do |char|
      possible_solutions[char] = build_char_score(char)
    end

    possible_solutions.sort_by { |k, v| v[0] }.reverse.first.flatten

  end

  private

  def decode_hex(hex_str)
    [hex_str].pack("H*")
  end

  def build_char_score(possible_key)

    dec_str = decode_hex(@enc_hex_str)

    possible_msg = ""

    char_frequency = 0

    for i in 0..(dec_str.length-1)
      possible_msg << (dec_str[i].bytes.first ^ possible_key.bytes.first)

      char_frequency += 1 if possible_msg[-1] =~ /[a-z]/
    end

    [char_frequency, possible_msg]
  end

end

