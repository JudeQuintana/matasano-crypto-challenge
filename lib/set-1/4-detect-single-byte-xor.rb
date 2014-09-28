# http://cryptopals.com/sets/1/challenges/4/
require_relative '../set-1/3-single-byte-xor'

class DetectSingleByteXOR
  attr_reader :hex_list_arr

  def initialize(hex_list_arr,char_key_arr)
    @hex_list_arr = hex_list_arr
    @char_key_arr = char_key_arr
  end

  def build_solution_hash

    solution_list = {}

    @hex_list_arr.each_with_index do |hex, index|
      solution_list[index] = SingleByteXOR.new(hex,@char_key_arr).decrypt_msg
    end

    solution_list
  end


end