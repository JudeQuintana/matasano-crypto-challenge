# http://cryptopals.com/sets/1/challenges/3/
require 'pp'

str  = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

decoded_str = [str].pack("H*")


def fixed_xor( dec_str1, letter )

    result =""

    letter_count = 0

    for i in 0..(dec_str1.length-1)
      result << (dec_str1[i].bytes.first ^ letter.bytes.first)

      if result[-1] =~ /[a-z]/
        letter_count += 1
      end
    end

  [letter_count,result]
end


letter_map = ('A'..'Z').to_a + ('a'..'z').to_a

solution_list = {}

letter_map.each do |letter|

 possible_solution = fixed_xor(decoded_str, letter)

  solution_list[letter] = possible_solution
end

puts "result"
pp solution_list.sort_by {|k,v| v[0]}.reverse

