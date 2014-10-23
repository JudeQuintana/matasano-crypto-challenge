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

    expect(FixedXOR.new(encrypted_hex_str, key_hex_str).decrypt_msg).to eq(msg_hex_str)
  end
end

describe SingleByteXOR do
  it "Find the key, decrypt the message assuming it was encrypted with a single char" do
    hex_str = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

    potential_keys_arr = ('A'..'Z').to_a + ('a'..'z').to_a

    key_letterfreq_msg = {char: "X", char_freq: 29, possible_msg: "Cooking MC's like a pound of bacon"}

    expect(SingleByteXOR.new(hex_str, potential_keys_arr).decrypt_msg).to eq(key_letterfreq_msg)
  end
end

describe DetectSingleByteXOR do
  it "iterate through hex list and detect possible solutions" do
    hex_list_file_path = File.expand_path('../../lib/set-1/data/4.txt', __FILE__)

    potential_keys_arr = ('0'..'9').to_a

    hex_list_arr = File.read(hex_list_file_path).split("\n")

    solution = DetectSingleByteXOR.new(hex_list_arr, potential_keys_arr).build_best_solution

    key_charfreq_msg = {char: "5", char_freq: 27, possible_msg: "Now that the party is jumping\n"}

    expect(solution).to eq(key_charfreq_msg)
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

describe BreakRepeatKeyXOR  do
  include Conversion
  it "computes hamming distance" do

    def hamming_distance(string1, string2)

      ham_dist = 0
      iter = 0

      string1.length < string2.length ? shortest_length = string1.length : shortest_length = string2.length

      while iter < shortest_length
        ham_dist += (string1[iter].bytes.first ^ string2[iter].bytes.first).to_s(2).count("1")
        iter += 1
      end

      ham_dist
    end

    text1 = "this is a test"
    text2 = "wokka wokka!!!"

    expect(hamming_distance(text1, text2)).to eq(37)
  end

  it "breaks repeating key xor" do

    base64_file_path = File.expand_path('../../lib/set-1/data/6.txt', __FILE__)

    base_64_file = File.read(base64_file_path)

    guessed_keysize_range = (2..40)

    decipher = BreakRepeatKeyXOR.new(base_64_file, guessed_keysize_range)

    expect(decipher.crack).to eq("I'm back and I'm ringin' the bell \nA rockin' on the mike while the fly girls yell \nIn ecstasy in the back of me \nWell that's my DJ Deshay cuttin' all them Z's \nHittin' hard and the girlies goin' crazy \nVanilla's on the mike, man I'm not lazy. \n\nI'm lettin' my drug kick in \nIt controls my mouth and I begin \nTo just let it flow, let my concepts go \nMy posse's to the side yellin', Go Vanilla Go! \n\nSmooth 'cause that's the way I will be \nAnd if you don't give a damn, then \nWhy you starin' at me \nSo get off 'cause I control the stage \nThere's no dissin' allowed \nI'm in my own phase \nThe girlies sa y they love me and that is ok \nAnd I can dance better than any kid n' play \n\nStage 2 -- Yea the one ya' wanna listen to \nIt's off my head so let the beat play through \nSo I can funk it up and make it sound good \n1-2-3 Yo -- Knock on some wood \nFor good luck, I like my rhymes atrocious \nSupercalafragilisticexpialidocious \nI'm an effect and that you can bet \nI can take a fly girl and make her wet. \n\nI'm like Samson -- Samson to Delilah \nThere's no denyin', You can try to hang \nBut you'll keep tryin' to get my style \nOver and over, practice makes perfect \nBut not if you're a loafer. \n\nYou'll get nowhere, no place, no time, no girls \nSoon -- Oh my God, homebody, you probably eat \nSpaghetti with a spoon! Come on and say it! \n\nVIP. Vanilla Ice yep, yep, I'm comin' hard like a rhino \nIntoxicating so you stagger like a wino \nSo punks stop trying and girl stop cryin' \nVanilla Ice is sellin' and you people are buyin' \n'Cause why the freaks are jockin' like Crazy Glue \nMovin' and groovin' trying to sing along \nAll through the ghetto groovin' this here song \nNow you're amazed by the VIP posse. \n\nSteppin' so hard like a German Nazi \nStartled by the bases hittin' ground \nThere's no trippin' on mine, I'm just gettin' down \nSparkamatic, I'm hangin' tight like a fanatic \nYou trapped me once and I thought that \nYou might have it \nSo step down and lend me your ear \n'89 in my time! You, '90 is my year. \n\nYou're weakenin' fast, YO! and I can tell it \nYour body's gettin' hot, so, so I can smell it \nSo don't be mad and don't be sad \n'Cause the lyrics belong to ICE, You can call me Dad \nYou're pitchin' a fit, so step back and endure \nLet the witch doctor, Ice, do the dance to cure \nSo come up close and don't be square \nYou wanna battle me -- Anytime, anywhere \n\nYou thought that I was weak, Boy, you're dead wrong \nSo come on, everybody and sing this song \n\nSay -- Play that funky music Say, go white boy, go white boy go \nplay that funky music Go white boy, go white boy, go \nLay down and boogie and play that funky music till you die. \n\nPlay that funky music Come on, Come on, let me hear \nPlay that funky music white boy you say it, say it \nPlay that funky music A little louder now \nPlay that funky music, white boy Come on, Come on, Come on \nPlay that funky music \n")

  end

  it "breaks an easier repeating key xor" do

    encrypted_hex_str = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"

    base64_file = hex_to_base64(encrypted_hex_str)

    guessed_keysize_range = (2..6)

    decipher = BreakRepeatKeyXOR.new(base64_file, guessed_keysize_range)

    msg = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"

    expect(decipher.crack).to eq(msg)
  end


end

