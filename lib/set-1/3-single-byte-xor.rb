# http://cryptopals.com/sets/1/challenges/3/

class SingleByteXOR

  def initialize(encoded_hex_string)
    @enc_hex_str = encoded_hex_string
  end

  def build_char_score(possible_key)

    dec_str = [@enc_hex_str].pack("H*")

    possible_msg = ""

    char_frequency = 0

    for i in 0..(dec_str.length-1)
      possible_msg << (dec_str[i].bytes.first ^ possible_key.bytes.first)

      if possible_msg[-1] =~ /[a-z]/
        char_frequency += 1
      end
    end

    [char_frequency, possible_msg]
  end

  def char_map
    ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
  end

  def decrypt_msg
    possible_solutions = {}

    char_map.each do |char|
      possible_solutions[char] = build_char_score(char)
    end

    possible_solutions.sort_by{ |k, v| v[0] }.reverse.first.flatten

  end

end

