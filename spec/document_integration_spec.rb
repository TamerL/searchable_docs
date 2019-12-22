require 'rspec/autorun'
require './src/document'

describe 'document integration' do
  context "when the file exist" do
    it "returns the content of the file" do
      document = Document.new('/home/tamer/searchable_docs/spec/doc1.txt')
      expect(document.content).to eq("The quick brown fox\n")
    end
  end
end
