require 'rspec/autorun'
require './src/document'
require './src/indexing'


describe 'search for a word in many documents' do
  context "when documents exist" do
    before do
      @doc1 = Document.new('/home/tamer/searchable_docs/spec/doc1.txt')
      @doc2 = Document.new('/home/tamer/searchable_docs/spec/doc2.txt')
      @doc3 = Document.new('/home/tamer/searchable_docs/spec/doc3.txt')
    end
    it "returns the name of the document where the word exists" do
      index = Indexing.new([@doc1,@doc2,@doc3])
      expect(index.search_by_word('the')).to eq(['doc1.txt','doc2.txt','doc3.txt'])
    end
    it "returns an empty array if the word is not found in any documents" do
      index = Indexing.new([@doc1,@doc2,@doc3])
      expect(index.search_by_word('notfoundword')).to eq([])
    end
  end
end
