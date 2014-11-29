# http://cryptopals.com/sets/1/challenges/4/
require_relative '3-single-byte-xor'

class DetectSingleByteXOR

  def initialize(hex_list_arr, char_key_arr)
    @hex_list_arr = hex_list_arr
    @char_key_arr = char_key_arr
  end

  def build_best_solution

    @hex_list_arr.each_with_object([]) { |hex, solution_list|
      solution_list << SingleByteXOR.new(hex, @char_key_arr).decrypt_msg
    }.sort_by { |sol| sol[:char_freq]}.reverse.first

  end
end