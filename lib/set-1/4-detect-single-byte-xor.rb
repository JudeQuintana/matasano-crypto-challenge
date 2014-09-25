# http://cryptopals.com/sets/1/challenges/4/
require_relative '../../lib/set-1/3-single-byte-xor'

class DetectSingleCharXOR
  attr_reader :enc_hex_list_arr

  def initialize(hex_file_list,char_key_arr)
    @enc_hex_list_arr = hex_file_list.split("\n")
    @char_key_arr = char_key_arr
  end

  def build_solution_hash

    solution_list = {}

    @enc_hex_list_arr.each_with_index do |enc_hex, index|
      solution_list[index] = SingleByteXOR.new(enc_hex,@char_key_arr).decrypt_msg
    end

    solution_list
  end


end