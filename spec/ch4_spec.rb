require_relative '../set-1/ch4'

describe BruteForceHexList do
  it "iterate through hex list" do

    hex_list_file_path = File.expand_path('../../set-1/4.txt', __FILE__)
    list = BruteForceHexList.new(File.read(hex_list_file_path))
    solultion_hash = list.build_solution_hash

    key_charfreq_msg = ["5", 23, "Now that the party is jumping\n"]
    expect(solultion_hash.has_value?(key_charfreq_msg)).to eq(true)
  end
end