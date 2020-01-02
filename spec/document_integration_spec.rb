require 'rspec/autorun'
require './src/document'

describe 'document integration' do
  context "when the file exist" do
    it "returns the content of the file" do
      document = Document.new('/home/tamer/searchable_docs/spec/doc1.txt')
      expect(document.content).to eq("The quick brown fox\n")
    end

    it "returns an error if the document doesn't exist" do
      document = Document.new('/etc/tamer')
      expect do
        document.content
      end.to raise_error("No such file or directory @ rb_sysopen - /etc/tamer")
    end
  end
end
