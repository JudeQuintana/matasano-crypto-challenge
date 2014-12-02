require 'spec_helper'

require_relative '../lib/set-2/9-implement-PKSC7-padding'
require_relative '../lib/set-2/10-implement-CBC-mode'

describe PKSC7padding do
  it "pads string up to number provided" do

    str = "YELLOW SUBMARINE"

    expect(PKSC7padding.new(str, 20).pad.padded_str).to eq(str + "\u0000\u0000\u0000\u0000")
  end

end


describe CBCmode do
  include Conversion

  it "implements CBC mode by hand, encrypt" do

    plain_text = "thisISmyPLAINtextOFeven16BYTElengthNOTthatTHISmessageISimportantBUTitCOULDbeINtheREALworldBREAKINGrealWORLDcryptoIStheSHITTTTTT!"
    iv = "AAAAAAAAAAAAAAAA"
    key = "IamTHEkeyMASTER!"

    encrypted_hex_str = "8a19834832d0f733d55199496095bdf187fb9fca83521845375719d9dbfb31b5467ab93b9d1c7013f24a9b1c7490fe5b79560367e6d1368cf9c512105f35dcafc68da20be0923740bdd6ebd2e8a72cd2efcca358dcc0581a237b31f6eb8df5a397179d771f31c8a9ef655f56a1c12846cc8ae4d3c2cf80bb0c781a5ca2aac6e0f049a4a80cc2ad3abd2c769e642166b41c1ead6f405f3e77a95b9f4784f076774be9354d8dfefddba170f2d519cd337a67b2cab5a58bb0fdb36dd806a93dee29e1a645aa82e8a97d371820751870545e5a27717aa7cbd5ef864e9966cb46aa0eab2c5095fd30c9361b2b884c7820f4856f9d682957f9038bd78736f6df93b4c4"
    # encrypted_hex_str = "\x8A\x19\x83H2\xD0\xF73\xD5Q\x99I`\x95\xBD\xF1\x87\xFB\x9F\xCA\x83R\x18E7W\x19\xD9\xDB\xFB1\xB5Fz\xB9;\x9D\x1Cp\x13\xF2J\x9B\x1Ct\x90\xFE[yV\x03g\xE6\xD16\x8C\xF9\xC5\x12\x10_5\xDC\xAF\xC6\x8D\xA2\v\xE0\x927@\xBD\xD6\xEB\xD2\xE8\xA7,\xD2\xEF\xCC\xA3X\xDC\xC0X\x1A\#{1\xF6\xEB\x8D\xF5\xA3\x97\x17\x9Dw\x1F1\xC8\xA9\xEFe_V\xA1\xC1(F\xCC\x8A\xE4\xD3\xC2\xCF\x80\xBB\fx\x1A\\\xA2\xAA\xC6\xE0\xF0I\xA4\xA8\f\xC2\xAD:\xBD,v\x9Ed!f\xB4\x1C\x1E\xADo@_>w\xA9[\x9FG\x84\xF0vwK\xE95M\x8D\xFE\xFD\xDB\xA1p\xF2\xD5\x19\xCD3zg\xB2\xCA\xB5\xA5\x8B\xB0\xFD\xB3m\xD8\x06\xA9=\xEE)\xE1\xA6E\xAA\x82\xE8\xA9}7\x18 u\x18pT^Z'qz\xA7\xCB\xD5\xEF\x86N\x99f\xCBF\xAA\x0E\xAB,P\x95\xFD0\xC96\e+\x88Lx \xF4\x85o\x9Dh)W\xF9\x03\x8B\xD7\x876\xF6\xDF\x93\xB4\xC4"

    # p CBCmode.new(plain_text, iv, key).encrypt
    expect(CBCmode.new(plain_text, iv, key).encrypt).to eq(encrypted_hex_str)
  end

  it "implements CBC mode by hand, decrypt" do

    plain_text = "thisISmyPLAINtextOFeven16BYTElengthNOTthatTHISmessageISimportantBUTitCOULDbeINtheREALworldBREAKINGrealWORLDcryptoIStheSHITTTTTT!"
    iv = "AAAAAAAAAAAAAAAA"
    key = "IamTHEkeyMASTER!"

    encrypted_hex_str = "8a19834832d0f733d55199496095bdf187fb9fca83521845375719d9dbfb31b5467ab93b9d1c7013f24a9b1c7490fe5b79560367e6d1368cf9c512105f35dcafc68da20be0923740bdd6ebd2e8a72cd2efcca358dcc0581a237b31f6eb8df5a397179d771f31c8a9ef655f56a1c12846cc8ae4d3c2cf80bb0c781a5ca2aac6e0f049a4a80cc2ad3abd2c769e642166b41c1ead6f405f3e77a95b9f4784f076774be9354d8dfefddba170f2d519cd337a67b2cab5a58bb0fdb36dd806a93dee29e1a645aa82e8a97d371820751870545e5a27717aa7cbd5ef864e9966cb46aa0eab2c5095fd30c9361b2b884c7820f4856f9d682957f9038bd78736f6df93b4c4"

    expect(CBCmode.new(decode_hex(encrypted_hex_str), iv, key).decrypt).to eq(plain_text)
  end

end