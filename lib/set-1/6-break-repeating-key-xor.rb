#http://cryptopals.com/sets/1/challenges/6/
require 'Base64'
require_relative '../set-1/4-detect-single-byte-xor'
require_relative '../set-1/5-implement-repeating-key-xor'

class BreakRepeatKeyXOR
  attr_reader :encrypted_ascii_string, :keysize_range

  def initialize(base64_file, keysize_range)
    @encrypted_ascii_string = Base64.decode64(base64_file)
    @keysize_range = keysize_range
  end

  def crack
    self.find_keysize.build_key.decrypt_msg
  end

  def decrypt_msg
    decode_hex(RepeatingKeyXOR.new(encrypted_ascii_string, @key).decrypt_msg)
  end

  def build_key

    build_arr_from_keysize
    transpose_arr

    @key = @transposed_arr.each.inject("") do |key, block|
      result = DetectSingleByteXOR.new([block], ("\x0".."\x7F").to_a).build_solution_hash
      key << result[0][:char]
      key
    end

    self
  end

  def find_keysize

    @keysize = keysize_range.each.inject([]) do |ham_dist_arr, size|

      first = ((hamming_distance(encrypted_ascii_string[0..size-1],
                                 encrypted_ascii_string[size..(size*2)-1]
      ))
      .to_f/size)
      .round(2)

      second = ((hamming_distance(encrypted_ascii_string[(size*2)..(size*3)-1],
                                  encrypted_ascii_string[(size*3)..(size*4)-1]
      ))
      .to_f/size)
      .round(2)

      third = ((hamming_distance(encrypted_ascii_string[(size*4)..(size*5)-1],
                                 encrypted_ascii_string[(size*5)..(size*6)-1]
      ))
      .to_f/size)
      .round(2)

      fourth = ((hamming_distance(encrypted_ascii_string[(size*6)..(size*7)-1],
                                  encrypted_ascii_string[(size*7)..(size*8)-1]
      ))
      .to_f/size)
      .round(2)

      fifth = ((hamming_distance(encrypted_ascii_string[(size*8)..(size*9)-1],
                                 encrypted_ascii_string[(size*9)..(size*10)-1]
      ))
      .to_f/size)
      .round(2)

      sixth = ((hamming_distance(encrypted_ascii_string[(size*10)..(size*11)-1],
                                 encrypted_ascii_string[(size*11)..(size*12)-1]
      ))
      .to_f/size)
      .round(2)

      ham_dist_arr << {distance: ((first + second + third + fourth + fifth + sixth) / 6).round(2), keysize: size}
      ham_dist_arr
    end.sort_by { |metric| metric[:distance] }.first[:keysize]

    self
  end

  private

  def transpose_arr

    @transposed_arr = @keysize.times.inject([]) do |transposed_blocks_arr|
      tmpstr=""
      @block_arr.each do |block|
        unless block[0] == nil
          tmpstr << encode_hex(block.slice!(0))
        end
      end
      transposed_blocks_arr << tmpstr
      transposed_blocks_arr
    end

  end

  def build_arr_from_keysize
    modify_enc_ascii_str = encrypted_ascii_string.dup
    @block_arr = []
    until modify_enc_ascii_str == ""
      @block_arr << modify_enc_ascii_str.slice!(0..(@keysize-1))
    end
    @block_arr
  end

  def hamming_distance(string1, string2)

    ham_dist = 0
    iter = 0

    string1.length < string2.length ? shortest_length = string1.length : shortest_length = string2.length

    while iter < shortest_length
      ham_dist += (string1[iter].bytes.first ^ string2[iter].bytes.first).to_s(2).count("1")
      iter += 1
    end

    ham_dist
  end

  def encode_hex(ascii_str)
    ascii_str.unpack("H*").first
  end

  def decode_hex(hex_string)
    [hex_string].pack("H*")
  end

end