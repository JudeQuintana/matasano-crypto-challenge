require_relative '../set-1/ch1'


describe Hex2Base64Digest do
  it "hex encoded string should produce a base64 string" do
    the_string = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    this_string = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    expect(Hex2Base64Digest.new(the_string).convert).to eq(this_string)
  end
end