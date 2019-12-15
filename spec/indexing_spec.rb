require 'rspec/autorun'
require './src/week_days_numbers_tostring'

describe 'week_days_numbers_tostring' do
  context "when the input is a valid expression" do
    it "returns the answer Mon-Sun when the input is 1,2,3,4,5,6,7" do
      result = convert_to_string_from("1,2,3,4,5,6,7")
      expect(result).to eq("Mon-Sun")
    end
    it "returns the answer Mon-Sun when the input is 1,2,3,6,7" do
      result = convert_to_string_from("1,2,3,6,7")
      expect(result).to eq("Mon-Wed, Sat, Sun")
    end
    it "returns the answer Mon, Wed-Sat when the input is 1,3,4,5,6" do
      result = convert_to_string_from("1,3,4,5,6")
      expect(result).to eq("Mon, Wed-Sat")
    end
    it "returns the answer Tue-Thu, Sat, Sun when the input is 2,3,4,6,7" do
      result = convert_to_string_from("2,3,4,6,7")
      expect(result).to eq("Tue-Thu, Sat, Sun")
    end
    it "returns the answer Mon, Wed, Thu, Sat, Sun when the input is 1,3,4,6,7" do
      result = convert_to_string_from("1,3,4,6,7")
      expect(result).to eq("Mon, Wed, Thu, Sat, Sun")
    end
    it "returns the answer Sun when the input is 7" do
      result = convert_to_string_from("7")
      expect(result).to eq("Sun")
    end
    it "returns the answer Mon, Sun when the input is 1,7" do
      result = convert_to_string_from("1,7")
      expect(result).to eq("Mon, Sun")
    end
  end
end
