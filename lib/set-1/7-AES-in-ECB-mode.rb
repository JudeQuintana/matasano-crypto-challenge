#http://cryptopals.com/sets/1/challenges/7/
require 'OpenSSL'
require_relative '../modules/conversion'

class AESinECB
  include Conversion

  def initialize(base64_str, key, iv = nil)
    @content = base64_to_ascii(base64_str)
    @key = key
    @iv = iv
  end

  def decrypt
    cipher = OpenSSL::Cipher.new('AES-128-ECB')
    cipher.decrypt
    cipher.key = @key
    cipher.iv = @iv if @iv
    cipher.update(@content) + cipher.final
  end

end