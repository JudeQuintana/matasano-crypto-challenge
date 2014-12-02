#http://cryptopals.com/sets/2/challenges/10/
require_relative '../../lib/set-1/2-fixed-xor'
require_relative '../../lib/set-1/7-AES-in-ECB-mode'
require_relative '../modules/conversion'

class CBCmode
  include Conversion

  def initialize(msg, iv, key)
    @msg = msg
    @iv = iv
    @key = key
  end

  def encrypt
    plain_text_bytes = @msg.bytes.each_slice(16).to_a
    iv_hex = encode_hex(@iv)
    first_block_hex = byte_arr_to_hex(plain_text_bytes.slice!(0))
    puts "first block"
    p first_block_hex.size

    cipher_text_arr = []

    xord_str = decode_hex(xor(first_block_hex, iv_hex))
    cipher_text = AESinECB.new(ascii_to_base64(xord_str), @key).encrypt
    cipher_text_arr << encode_hex(cipher_text)

    # to_decrypt = encode_hex(cipher_text)
    # decrypt = AESinECB.new(hex_to_base64(to_decrypt),@key).decrypt
    #
    # puts "cipher text"
    # p cipher_text
    #
    # puts "to decrypt"
    # p decrypt
    # p xord_str

    plain_text_bytes.inject(cipher_text) { |cipher_text_to_xor, byte_block_arr|
      plain_text_hexstr_block = byte_arr_to_hex(byte_block_arr)
      xord_str = decode_hex(xor(cipher_text_to_xor, plain_text_hexstr_block))
      cipher_text = AESinECB.new(ascii_to_base64(xord_str), @key).encrypt
      cipher_text_arr << encode_hex(cipher_text)
      cipher_text
    }

    cipher_text_arr.join

  end

  def decrypt
    cipher_msg_bytes = @msg.bytes.each_slice(16).to_a
    iv_hex = encode_hex(@iv)
    cipher_first_block_hex = byte_arr_to_hex(cipher_msg_bytes.slice!(0))

    plain_text_arr = []

    str_to_xor = AESinECB.new(ascii_to_base64(decode_hex(cipher_first_block_hex)), @key).decrypt

    xord_hex_str = xor(encode_hex(str_to_xor), iv_hex)

    plain_text_arr << decode_hex(xord_hex_str)

    cipher_msg_bytes.inject(cipher_first_block_hex) { |cipher_text_to_xor, byte_block_arr|

      cipher_text_hexstr_block = byte_arr_to_hex(byte_block_arr)

      str_to_xor = AESinECB.new(hex_to_base64(cipher_first_block_hex), @key).decrypt

      xord_hex_str = xor(encode_hex(str_to_xor), cipher_text_to_xor)

      plain_text_arr << decode_hex(xord_hex_str)

      cipher_text_hexstr_block

    }

    plain_text_arr.join

  end

  private

  def xor(hex_str1, hex_str2)
    FixedXOR.new(hex_str1, hex_str2).encrypt_msg
  end

  def byte_arr_to_hex(byte_arr)
    byte_arr.map { |byte| byte.to_s(16) }.join
  end

end