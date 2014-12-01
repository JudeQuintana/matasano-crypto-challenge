require 'spec_helper'

require_relative '../lib/set-2/9-implement-PKSC7-padding'

describe PKSC7padding do
  it "pads string up to number provided" do

    str = "YELLOW SUBMARINE"

    expect(PKSC7padding.new(str,20).pad.padded_str).to eq(str + "\u0000\u0000\u0000\u0000")
  end

end