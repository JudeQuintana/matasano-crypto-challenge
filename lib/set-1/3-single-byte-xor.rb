# http://cryptopals.com/sets/1/challenges/3/

class SingleByteXOR

  def initialize(encoded_hex_string, char_key_arr)
    @enc_hex_str = encoded_hex_string
    @char_key_arr = char_key_arr
  end

  def decrypt_msg

    @char_key_arr.each.inject([]) do |possible_solutions, char|
      possible_solutions << {char: char}.merge(build_char_score(char))
      possible_solutions
    end.sort_by { |solution| solution[:char_freq] }.reverse.first

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

      if possible_msg[-1] =~ /[a-z]/
        char_frequency += 1
      elsif possible_msg[-1] =~ /[ ]/
        char_frequency += 1
      elsif possible_msg[-1] =~ /\W/
        char_frequency -= 1
      elsif possible_msg[-1] =~ /\d/
        char_frequency -= 1
      end
    end

    {char_freq: char_frequency, possible_msg: possible_msg}
  end

end

