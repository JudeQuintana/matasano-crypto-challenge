require 'spec_helper'

describe Hex2Base64Digest do
  it "hex encoded string should produce a base64 string" do
    hex_string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

    base64_string = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"

    expect(Hex2Base64Digest.new(hex_string).convert).to eq(base64_string)
  end
end

describe FixedXOR do
  it "takes 2 equal length buffers and produces their XOR combination" do
    hex_str1 = "1c0111001f010100061a024b53535009181c"

    hex_str2 = "686974207468652062756c6c277320657965"

    xor_combination = "746865206b696420646f6e277420706c6179"

    expect(FixedXOR.new(hex_str1, hex_str2).encrypt_msg_with_xor).to eq(xor_combination)
  end
end

describe SingleByteXOR do
  it "Find the key, decrypt the message assuming it was encrypted with a single char" do
    hex_str = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

    key_letterfreq_msg = ["X", 24, "Cooking MC's like a pound of bacon"]

    expect(SingleByteXOR.new(hex_str).decrypt_msg).to eq(key_letterfreq_msg)
  end

end

describe DetectSingleCharXOR do
  it "iterate through hex list" do
    hex_list_file_path = File.expand_path('../../lib/set-1/4.txt', __FILE__)

    list = DetectSingleCharXOR.new(File.read(hex_list_file_path))

    solultion_hash = list.build_solution_hash

    key_charfreq_msg = ["5", 23, "Now that the party is jumping\n"]

    expect(solultion_hash.has_value?(key_charfreq_msg)).to eq(true)
  end
end


describe RepeatingKeyXOR do
  it "encrypts msg with key" do
    msg = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"

    key = "ICE"

    encrypted_str = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"

    expect(RepeatingKeyXOR.new(msg, key).encrypt_msg).to eq(encrypted_str)
  end

end

describe BreakRepeatKeyXOR do
  it "compute hamming distance" do
    text1 = "this is a test"

    text2 = "wokka wokka!!!"
    
    expect(BreakRepeatKeyXOR.new(text1, text2).hamming_distance).to eq(37)
  end
end