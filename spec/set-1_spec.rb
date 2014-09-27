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
    key_hex_str = "1c0111001f010100061a024b53535009181c"

    msg_hex_str = "686974207468652062756c6c277320657965"

    encrypted_hex_str = "746865206b696420646f6e277420706c6179"

    expect(FixedXOR.new(msg_hex_str, key_hex_str).encrypt_msg).to eq(encrypted_hex_str)

    #decrypt msg
    expect(FixedXOR.new(encrypted_hex_str, key_hex_str).encrypt_msg).to eq(msg_hex_str)
  end

end

describe SingleByteXOR do
  it "Find the key, decrypt the message assuming it was encrypted with a single char" do
    hex_str = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

    potential_keys_arr = ('A'..'Z').to_a + ('a'..'z').to_a

    key_letterfreq_msg = ["X", 24, "Cooking MC's like a pound of bacon"]

    expect(SingleByteXOR.new(hex_str, potential_keys_arr).decrypt_msg).to eq(key_letterfreq_msg)
  end
end

describe DetectSingleByteXOR do
  it "iterate through hex list and detect possible solutions" do
    hex_list_file_path = File.expand_path('../../lib/set-1/4.txt', __FILE__)

    potential_keys_arr = ('0'..'9').to_a

    list = DetectSingleByteXOR.new(File.read(hex_list_file_path), potential_keys_arr)

    solution_hash = list.build_solution_hash

    key_charfreq_msg = ["5", 23, "Now that the party is jumping\n"]

    expect(solution_hash.has_value?(key_charfreq_msg)).to eq(true)
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

    expect(BreakRepeatKeyXOR.hamming_distance(text1, text2)).to eq(37)
  end

  it "test" do
    require 'pp'
    base64_file_path = File.expand_path('../../lib/set-1/6.txt', __FILE__)

    base_64_file = File.read(base64_file_path).split("\n").join

    # base_64_file.each do |line|
    #   p line
    #   puts line.length
    # end

    # pp base_64_file.length

    keysize = (2..40).to_a

    encrypted_hex_str = BreakRepeatKeyXOR.base64_to_hex(base_64_file)

    ham_dist_hsh = {}

    keysize.each do |size|
      # puts "keysize"
      # p size
      # puts "ham_dist"
      ham_dist_hsh[size] = ((BreakRepeatKeyXOR.hamming_distance(encrypted_hex_str[0..size-1], encrypted_hex_str[size..size+(size-1)])).to_f/size).round(2)
    end

    puts "top 5 smallest ham dist"
    # pp ham_dist_hsh
    #returns top 5 smallest hamming distances
    pp ham_dist_hsh.sort_by { |k, v| v }[0..4]


    #smallest hamming distance is for keysize 10

    #making ciphertext blocks of keysize 5
    # smllst_ham_dist = 4
    #
    # block_arr = []
    # until encrypted_hex_str == ""
    #   block_arr << encrypted_hex_str.slice!(0..smllst_ham_dist-1)
    # end
    # pp block_arr
    #
    # block_arr.each do |block|
    #   puts "block length"
    #   puts block.length
    #
    # end
  end
end