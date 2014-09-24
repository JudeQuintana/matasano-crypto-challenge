require_relative '../set-1/ch3'
require 'pp'

describe SingleByteXOR do
  it "Find the key, decrypt the message" do
    hex_str = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

    key_letterfreq_msg = ["X", 24, "Cooking MC's like a pound of bacon"]

    expect(SingleByteXOR.new(hex_str).decrypt_msg).to eq(key_letterfreq_msg)

  end

end