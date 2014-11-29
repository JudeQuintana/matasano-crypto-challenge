require_relative '../set-1/modules/conversion'

class DetectAESinECB
  include Conversion

  def initialize(hex_list_arr)
    @hex_list_arr = hex_list_arr
  end


  def detect
    @hex_list_arr.each_with_object([]) { |hex_str, arr|

      bytes = decode_hex(hex_str).bytes
      count = bytes.each_slice(16).to_a.uniq.count

      arr << {count: count, hex_str: hex_str}
      
    }.sort_by { |metric| metric[:count]}.first[:hex_str]
  end

end