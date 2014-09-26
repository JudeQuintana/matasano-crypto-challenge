# http://cryptopals.com/sets/1/challenges/5/
class RepeatingKeyXOR

  def initialize(msg,key)
    @msg = msg
    @key = key
  end

  def encrypt_msg
    encrypted_str =""
    k = 0

    for i in 0..(@msg.length-1)

      if k > @key.length-1
        k=0
      end

      #need to keep leading zero when inserting hex into string
      #this works too i just like the other better
      # encrypted_str << (@msg[i].bytes.first ^ @key[k].bytes.first).to_s(16).rjust(2,"0")
      encrypted_str << sprintf('%02x', (@msg[i].bytes.first ^ @key[k].bytes.first))

      k+=1
    end

    encrypted_str
  end

end


