class File
  def self.read(filename)
    File.open(filename, "r") { |f| f.read }
  end
  
  def self.readlines(filename)
    File.open(filename, "r") { |f| f.readlines }
  end
  
  # TODO don't slurp the entire file but count lines until line is reached
  def self.line_at(filename, index)
    File.readlines(filename)[index]
  end
  
  def self.line_number(filename, &block)
    readlines(filename).each_with_index { |line, ix| return ix if yield(line) }
  end
  
  def self.write(filename, str)
    File.open(filename, "w"){ |f| f << str }    
  end
  
  def self.sub(filenames, pattern, replacement)
    pattern = Regexp.new(Regexp.escape(pattern))
    filenames.each do |filename|
      str = File.read(filename)
      if str.sub!(pattern, replacement)
        File.write(filename, str)
      end
    end
  end
end