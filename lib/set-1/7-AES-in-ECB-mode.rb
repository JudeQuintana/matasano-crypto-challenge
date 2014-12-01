#http://cryptopals.com/sets/1/challenges/7/
require 'OpenSSL'
require_relative '../modules/conversion'

class AESinECB
  include Conversion

  def initialize(base64_str, key, iv = nil, cipher_type = 'AES-128-ECB')
    @content = base64_to_ascii(base64_str)
    @key = key
    @iv = iv
    @cipher_type = cipher_type
  end

  def encrypt
    aes = OpenSSL::Cipher::Cipher.new(@cipher_type)
    aes.encrypt
    aes.key = key
    aes.iv = iv if @iv
    aes.update(@content) + aes.final
  end

  def decrypt
    cipher = OpenSSL::Cipher.new(@cipher_type)
    cipher.decrypt
    cipher.key = @key
    cipher.iv = @iv if @iv
    cipher.update(@content) + cipher.final
  end

end