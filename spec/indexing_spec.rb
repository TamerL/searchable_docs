require 'rspec/autorun'
require './src/indexing'

describe Indexing do
  context 'given the doc1 and doc2 are initialized with content already' do
    before do
      @doc1 = double("Document", content: 'The fox', name: 'doc1.txt')
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

      it 'returns an empty array when all documents content raises an error' do
        allow(@doc1).to receive(:content).and_raise("something bad hapended")
        index = Indexing.new(@doc1)
        expect(index.searchable_words).to eq([])
        expect(index.indexes).to eq({})
      end

      context 'when one of the document content raises an error' do
        before do
          allow(@doc1).to receive(:content).and_raise("something bad hapended")
          @index_with_error_doc = Indexing.new(@doc1, @doc2)
        end

        it 'returns searchable words which are only included in the normal document' do
          expect(@index_with_error_doc.searchable_words).to eq(['the', 'puppy'])
        end

        it 'returns the index hash having only the normal document' do
          expect(@index_with_error_doc.indexes).to eq({"doc2.txt" => "11"})
        end
      end

      it 'creates indexes for the passed documents mapped to the existence of the searchable_words' do
        expect(@index.indexes).to eq({"doc1.txt" => "110" , "doc2.txt" => "101"})
      end
    end

    describe '#search_by_word' do
      # content is instant method
      before do
        @index = Indexing.new(@doc1,@doc2)
      end
      it 'returns an array containing the documents which have the word case insensetive' do
        expect(@index.search_by_word("the")).to eq(["doc1.txt","doc2.txt"])
      end

      it 'returns an empty array if the word does not exist anywhere' do
        expect(@index.search_by_word("Mike")).to eq([])
      end

      it 'raises an error if the word is nil' do
        expect do
          @index.search_by_word(nil)
        end.to raise_error("please enter a word to search for")
      end
    end
  end
end
  # context 'Given the doc1 and doc2 are initialized with content already' do
  #   before do
  #     @doc1 = double("Document", content: 'the fox', name: 'doc1.txt')
  #     @doc2 = double("Document", content: 'the puppy', name: 'doc2.txt')
  #     # allow(doc1).to receive(:content).and_return("the fox")
  #   end
  #
  #   it
