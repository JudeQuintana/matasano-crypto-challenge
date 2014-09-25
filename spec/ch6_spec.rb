require_relative '../set-1/ch6'

describe BreakRepeatKeyXOR do
  it "compute hamming distance" do

    text1 = "this is a test"
    text2 = "wokka wokka!!!"
    expect(BreakRepeatKeyXOR.new(text1,text2).hamming_distance).to eq(37)
  end
end