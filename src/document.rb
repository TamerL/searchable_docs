class Document
  attr_reader :name
  attr_reader :path

  def initialize(path)
      @name = path.split('/').last
      @path = path
  end

  def content
    # "the document content"
    File.read(@path)
    # @content = ""
    # File.open(@path).each do |line|
    #   @content = line
    # end
    # @content
  end
end
