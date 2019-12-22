class Indexing
  attr_reader :documents
  attr_reader :searchable_words
  attr_reader :indexes
  attr_reader :result

  def initialize(*documents)
    @documents = *documents
    @searchable_words = Indexing.build_searchable_words(@documents)
    @indexes = Indexing.build_indexes(@documents,@searchable_words)
  end


  def self.build_searchable_words(documents)
    searchable_words = []
    documents.each do |doc|
      searchable_words += doc.content.split(" ")
    end
    searchable_words.uniq
  end

  def self.build_indexes(documents,searchable_words)
    indexes = {}
    documents.each do |doc|
      indexes[doc.name] = []
      searchable_words.each do |word|
        if doc.content.split(" ").include?(word)
          indexes[doc.name] << "1"
        else
          indexes[doc.name] << "0"
        end
      end
      indexes[doc.name] = indexes[doc.name].join
    end
    indexes
    # indexes.each do |k,v|
    #   indexes[k] = v.to_i
    # end
    # p indexes
  end

  def search_by_word(word)
    returns [] if @searchable_words.include?(word) == false
    index = @searchable_words.index(word)
    @result = []
    p @indexes
    @indexes.each do |k,v|
      puts v
      puts v.split('')[index]
      @result << k if v.split('')[index] == "1"
    end
    p @result
    @result
  end
end
