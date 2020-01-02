require 'rspec/autorun'
require './src/document'

RSpec.describe Document do
  describe '.initialize' do
    # initialize is a class method
    before do
      @document = Document.new('./doc1.txt')
    end

    it 'has a name' do
        expect(@document.name).to eq('doc1.txt')
    end

    it 'has a path' do
        expect(@document.path).to eq('./doc1.txt')
    end
  end

  describe '#content' do
    # content is instant method
    context 'given file is read successfully' do
      before do
        @document = Document.new('the document path')
        allow(File).to receive(:read).and_return("the document content")
      end

    it "calls File to read the document" do
        expect(File).to receive(:read).with('the document path')
        @document.content
    end

    it 'returns the content' do
      expect(@document.content).to eq("the document content")
    end
  end

  context 'when reading the file failed' do
    it 'raises an error' do
      @document = Document.new('the document path')
      allow(File).to receive(:read).and_raise("something wrong")

      expect do
        @document.content
      end.to raise_error("something wrong")
    end
  end
  end
end
