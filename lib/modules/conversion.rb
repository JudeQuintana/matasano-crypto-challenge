require 'Base64'

module Conversion

  def decode_hex(hex_string)
    [hex_string].pack("H*")
  end

  def encode_hex(ascii_str)
    ascii_str.unpack("H*").first
  end

  def hex_to_base64(hex_str)
    [[hex_str].pack("H*")].pack("m0")
  end

  def base64_to_hex(base64_str)
    base64_str.unpack("m0").first.unpack("H*").first
  end

  def base64_to_ascii(base64_str)
    Base64.decode64(base64_str)
  end

  def ascii_to_base64(ascii_str)
    Base64.encode64(ascii_str)
  end

end