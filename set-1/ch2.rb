# http://cryptopals.com/sets/1/challenges/2/

hex_str1 = "1c0111001f010100061a024b53535009181c"

hex_str2 = "686974207468652062756c6c277320657965"

decoded_str1 = [hex_str1].pack("H*")

decoded_str2 = [hex_str2].pack("H*")


def fixed_xor(dec_str1, dec_str2)

  result =""

  for i in 0..(dec_str1.length-1)
    result << (dec_str1[i].bytes.first ^ dec_str2[i].bytes.first).to_s(16)
  end

  result

end

puts "result"
p fixed_xor(decoded_str1,decoded_str2)