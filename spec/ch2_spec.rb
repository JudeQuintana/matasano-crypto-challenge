require_relative '../set-1/ch2'

describe FixedXOR do
  it "takes 2 equal length buffers and produces their XOR combination" do
    hex_str1 = "1c0111001f010100061a024b53535009181c"
    hex_str2 = "686974207468652062756c6c277320657965"

    xor_combination = "746865206b696420646f6e277420706c6179"

    expect(FixedXOR.new(hex_str1,hex_str2).xor_combo).to eq(xor_combination)
  end
end