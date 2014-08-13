# http://cryptopals.com/sets/1/challenges/1/


string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

def hex_to_base64_digest(hexdigest)
  [[hexdigest].pack("H*")].pack("m0")
end

base64 = hex_to_base64_digest(string)

puts "string"
p base64