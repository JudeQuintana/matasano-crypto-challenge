# http://cryptopals.com/sets/1/challenges/5/

require 'pp'

str = "Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal"

key = 'ICE'

def repeating_key_xor(dec_str1, keys)

  result =""
  k = 0

  for i in 0..(dec_str1.length-1)

    if k > keys.length-1
      k=0
    end

    xord = (dec_str1[i].bytes.first ^ keys[k].bytes.first)

    result << sprintf('%02x', xord)

    k+=1

  end

  result
end

pp repeating_key_xor(str, key)

