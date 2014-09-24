# http://cryptopals.com/sets/1/challenges/3/

class SingleByteXOR

  def initialize(encoded_hex_string)
    @enc_hex_str = encoded_hex_string
  end

  def build_letter_score(possible_key)

    dec_str = [@enc_hex_str].pack("H*")

    possible_msg = ""

    letter_frequency = 0

    for i in 0..(dec_str.length-1)
      possible_msg << (dec_str[i].bytes.first ^ possible_key.bytes.first)

      if possible_msg[-1] =~ /[a-z]/
        letter_frequency += 1
      end
    end

    [letter_frequency, possible_msg]
  end

  def letter_map
    ('A'..'Z').to_a + ('a'..'z').to_a
  end

  def decrypt_msg
    possible_solutions = {}

    letter_map.each do |letter|
      possible_solutions[letter] = build_letter_score(letter)
    end

    possible_solutions.sort_by{ |k, v| v[0] }.reverse.first.flatten

  end

end

