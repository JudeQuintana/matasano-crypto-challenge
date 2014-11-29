require 'OpenSSL'
require_relative '../set-1/modules/conversion'

class AESinECB
  include Conversion

  def initialize(base64_str, key)
    @content = base64_to_ascii(base64_str)
    @key = key
  end

  def decrypt
    cipher = OpenSSL::Cipher.new('AES-128-ECB')
    cipher.decrypt
    cipher.key = @key
    cipher.update(@content) + cipher.final
  end


end