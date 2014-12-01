#http://cryptopals.com/sets/2/challenges/9/

class PKSC7padding
  attr_reader :padded_str

  def initialize(str, num)
    @str = str
    @num = num
  end

  def pad

    @padded_str = @str.dup

    if need_padding?

      num_to_pad = @num - @str.length

      num_to_pad.times {
        @padded_str << 0x04
      }
    else
      @padded_str
    end

    self

  end

  private

  def need_padding?
    @str.length < @num
  end

end