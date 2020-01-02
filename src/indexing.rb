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
      begin
        searchable_words += doc.content.split(" ").map do |w|
          w.downcase
        end
      rescue => e
        puts e.message
        next
      end
    end

    searchable_words.uniq
  end

  def self.build_indexes(documents,searchable_words)
    return {} if searchable_words.empty?

    indexes = {}
    documents.each do |doc|
      begin
        doc_content = doc.content.split(" ")
      rescue => e
        puts e.message
        next
      end

      indexes[doc.name] = []

      searchable_words.each do |word|
        if doc_content.include?(word) || doc_content.include?(word.capitalize)
          indexes[doc.name] << "1"
        else
          indexes[doc.name] << "0"
        end
      end

      indexes[doc.name] = indexes[doc.name].join
    end
    # indexes.each do |k,v|
    #   indexes[k] = v.to_i
    # end
    indexes
  end

  def search_by_word(word)
    raise "please enter a word to search for" if word== nil

    downcase_word = word.downcase

    return [] if @searchable_words.include?(downcase_word) == false

    index = @searchable_words.index(downcase_word)
    @result = []
    @indexes.each do |k,v|
      puts v
      puts v.split('')[index]
      @result << k if v.split('')[index] == "1"
    end
    @result
  end
end
