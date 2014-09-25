# http://cryptopals.com/sets/1/challenges/4/
require_relative '../../lib/set-1/3-single-byte-xor'

class DetectSingleCharXOR
  attr_reader :enc_hex_list_arr

  def initialize(hex_file_list)
    @enc_hex_list_arr = hex_file_list.split("\n")
  end

  def build_solution_hash

    solution_list = {}

    @enc_hex_list_arr.each_with_index do |enc_hex, index|
      solution_list[index] = SingleByteXOR.new(enc_hex).decrypt_msg
    end

    solution_list
  end


end