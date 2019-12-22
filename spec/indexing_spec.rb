require 'rspec/autorun'
require './src/indexing'

RSpec.describe Indexing do
  context 'Given the doc1 and doc2 are initialized already' do
    before do
      @doc1 = double("Document", content: 'the fox', name: 'doc1.txt')
      @doc2 = double("Document", content: 'the puppy', name: 'doc2.txt')
      # allow(doc1).to receive(:content).and_return("the fox")
    end

    describe '.initialize' do
      # initialize is a class method
      before do
        @index = Indexing.new(@doc1,@doc2)
      end

      it 'store the documents array' do
        expect(@index.documents).to eq([@doc1,@doc2])
      end

      it 'store the words in an array of searchable_words' do
        expect(@index.searchable_words).to eq(['the','fox','puppy'])
      end

      it 'every document should have indexes for the words' do
        expect(@index.indexes).to eq({"doc1.txt" => "110" , "doc2.txt" => "101"})
      end
    end

    describe '#search_by_word' do
      # content is instant method
      it 'returns an array containing the documents which have the word' do
        index = Indexing.new(@doc1,@doc2)
        expect(index.search_by_word("the")).to eq(["doc1.txt","doc2.txt"])
      end
    end
  end
end
