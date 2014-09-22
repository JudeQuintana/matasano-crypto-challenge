require 'pp'
#http://cryptopals.com/sets/1/challenges/6/
#only finished the hamming part here, lots more to do


def hamming(strand_1, strand_2)

  bin_str1 = strand_1.unpack("B*").first

  bin_str2 = strand_2.unpack("B*").first


  hamming = 0

  bin_str1 = bin_str1.split(//)

  bin_str2 = bin_str2.split(//)


  if bin_str1.length < bin_str2.length
    shortest_length = bin_str1.length
  else
    shortest_length = bin_str2.length
  end

  iter = 0
  while iter < shortest_length
    if bin_str1[iter].to_i != bin_str2[iter].to_i
      hamming += 1

    end
    iter += 1
  end

  hamming

end

pp hamming("this is a test", "wokka wokka!!!")

# "11101001101000110100111100111000001101001111001110000011000011000001110100110010111100111110100"
# "1110111110111111010111101011110000110000011101111101111110101111010111100001100001100001100001"

