# http://cryptopals.com/sets/1/challenges/5/
require_relative '../set-1/modules/conversion'

class RepeatingKeyXOR
  include Conversion

  def initialize(msg,key)
    @msg = msg
    @key = key
  end

  def encrypt_msg
    encrypted_str =""
    k = 0

    for i in 0..(@msg.length-1)
      encrypted_str <<  (@msg[i].bytes.first ^ @key[k].bytes.first)
      k+1 > @key.length-1 ? k=0 : k+=1
    end

    encode_hex(encrypted_str)
  end

  def decrypt_msg
    encrypt_msg
  end
end


