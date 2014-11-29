#http://cryptopals.com/sets/1/challenges/6/
require_relative '../set-1/3-single-byte-xor'
require_relative '../set-1/5-implement-repeating-key-xor'
require_relative '../set-1/modules/conversion'

class BreakRepeatKeyXOR
  include Conversion
  attr_reader :cipher_text, :keysize_range, :msg, :key

  def initialize(base64_file, keysize_range)
    @cipher_text = base64_to_ascii(base64_file)
    @keysize_range = keysize_range
  end

  def crack
    self.find_keysize.build_key.decrypt_msg.msg
  end

  def decrypt_msg
    @msg = decode_hex(RepeatingKeyXOR.new(cipher_text, @key).decrypt_msg)
    self
  end

  def build_key
    build_block_arr_from_keysize
    transpose_arr
    extract_key
    self
  end

  def find_keysize

    cipher_length = cipher_text.length

    @keysize = keysize_range.each_with_object([]) { |keysize, ham_dist_arr|

      start_index = 0
      offset = keysize * 2

      next if offset > cipher_length

      distance_arr = []

      while (start_index + offset) <= cipher_length

        first = cipher_text[start_index...start_index + keysize]
        second = cipher_text[start_index + keysize...start_index + offset]

        distance_arr << (hamming_distance(first, second) / keysize)

        start_index += offset
      end

      avg_distance = average_distances(distance_arr)

      ham_dist_arr << {distance: avg_distance, keysize: keysize}

    }.sort_by { |metric| metric[:distance] }.first[:keysize]

    self
  end

  private

  def transpose_arr
    @transposed_arr = @keysize.times.each_with_object([]) { |_, transposed_blocks_arr|
      tmpstr=""
      @block_arr.each do |block|
        if block[0]
          tmpstr << encode_hex(block.slice!(0))
        end
      end
      transposed_blocks_arr << tmpstr
    }
  end

  def build_block_arr_from_keysize
    @block_arr = cipher_text.scan(/[\w\W]{1,#{@keysize}}/)
  end

  def extract_key
    @key = @transposed_arr.each_with_object("") { |block, key|
      result = SingleByteXOR.new(block, ("\x0".."\x7F")).decrypt_msg
      key << result[:char]
    }
  end

  def hamming_distance(str1, str2)

    arr1 = str1.bytes
    arr2 = str2.bytes

    ham_dist = 0

    for i in 0..arr1.length-1 #arr1 and arr2 will always be same length
      ham_dist += (arr1[i] ^ arr2[i]).to_s(2).count("1")
    end

    ham_dist.to_f
  end

  def average_distances(distance_arr)
    distance_arr.inject(:+)/distance_arr.length
  end

end