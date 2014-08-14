# http://cryptopals.com/sets/1/challenges/4/
require 'pp'

enc_str_arr = File.read("4.txt").split("\n")
dec_str_arr = []

enc_str_arr.each do |enc_hex|
  dec_str_arr.push([enc_hex].pack("H*"))
end


def fixed_xor(dec_str1, char)

  result =""

  char_count = 0

  for i in 0..(dec_str1.length-1)

    result << (dec_str1[i].bytes.first ^ char.bytes.first)

    if result[-1] =~ /[a-z]/
      char_count += 1
    end
  end

  [char_count, result]
end


char_map = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a

solution_list = {}

all_solutions=[]

dec_str_arr.each_with_index do |dec_hex, index|

  char_map.each do |letter|

    solution_list[letter] = fixed_xor(dec_hex, letter)

  end

  all_solutions.push(index, solution_list.sort_by { |k, v| v[0] }.reverse.first)

end

pp all_solutions
