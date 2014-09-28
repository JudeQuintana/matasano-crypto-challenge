#http://cryptopals.com/sets/1/challenges/6/
#only finished the hamming part here, lots more to do
class BreakRepeatKeyXOR

  def self.hamming_distance(string1,string2)

    ham_dist = 0
    iter = 0

    if string1.length < string2.length
      shortest_length = string1.length
    else
      shortest_length = string2.length
    end

    while iter < shortest_length
      ham_dist += (string1[iter].bytes.first ^ string2[iter].bytes.first).to_s(2).count("1")
      iter += 1
    end

    ham_dist
  end

  # private

  def self.base64_to_hex(base64_str)
    base64_str.unpack("m0").first.unpack("H*").first
  end

  def self.base64_to_ascii(base64_str)
    base64_str.unpack("m0").first
  end

end