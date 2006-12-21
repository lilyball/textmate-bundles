require 'strscan'
# The LaTeX module contains a lot of methods useful when dealing with LaTeX
# files.
#
# Author:: Charilaos Skiadas
# Date:: 12/21/2006
module LaTeX
  # Simple conversion of bib field names to a simpler form
  def e_var(name)
    name.gsub(/[^a-zA-Z0-9\-_]/,"").gsub(/\-/,"_")
  end
  # Implements general methods that give information about the LaTeX document. 
  # Most of these commands recurse into \included files.
  class <<self
    # Returns an array of the label names. If you want actual Label objects, 
    # then use FileScanner.label_scan
    def get_labels
      return FileScanner.label_scan(ENV["TM_LATEX_MASTER"] || ENV["TM_FILEPATH"]).map{|i| i.label}.sort
    end
    # Returns an array of the citation objects. If you only want the citekeys, 
    # use LaTeX.get_citekeys
    def get_citations
      return FileScanner.cite_scan(ENV["TM_LATEX_MASTER"] || ENV["TM_FILEPATH"]).map{|i| i}.sort { |a,b| a.citekey <=> b.citekey }
    end
    # Returns an array of the citekeys in the document.
    def get_citekeys
      self.get_citations.map{|i| i["citekey"]}.uniq
    end
    # Checks whether the path is set properly so that TeX binaries can be located.
    def check_tex_path
      raise "The tex binaries cannot be located!" if `which kpsewhich`.match(/^no kpsewhich/)
    end
    # Uses kpsewhich to locate the file with name +filename+ and +extension+.
    # +relative+ determines an explicit path that should be included in the
    # paths to look at when searching for the file. This will typically be the
    # path to the root document.
    def find_file(filename,extension,relative)
      LaTeX.check_tex_path
      @@paths ||= Hash.new
      @@paths[extension] ||= ([`kpsewhich -show-path=#{extension}`.chomp.split(/:!!|:/)].flatten.map{|i| i.sub(/\/*$/,'/')}).unshift(relative)
      return "#{filename}.#{extension}" if File.exist?("#{filename}.#{extension}")
      @@paths[extension].each do |path|
        testpath = File.expand_path(File.join(path,filename + "." + extension))
        return testpath if File.exist?(testpath)
      end
      return nil
    end
    # Processes the .bib file with title +file+, and returns an array of the
    # Citation objects.
    def parse_bibfile(file)
      text = File.read(file)
      entries = text.scan(/^\s*@[^{]*\{.*?(?=\n[ \t]*@|\z)/m)
      citations = entries.map do |text|
        c = Citation.new
        s = StringScanner.new(text)
        s.scan(/\s+@/)
        c["bibtype"] = s.scan(/[^\s\{]+/)
        s.scan(/\s*\{/)
        c["citekey"] = s.scan(/[\w:\-_]+(?=\s*,)/)
        # puts "Found citekey: #{c["citekey"]}"
        s.scan(/\s*,/)
        until s.eos? or s.scan(/\s*\,?\s*\}/) do
          s.scan(/\s+/)
          key = s.scan(/[\w\-]+/)
          raise "Choked on: #{s.matched}" unless s.scan(/\s*=\s*/)
          # puts "Found key: #{key}"
          s.scan(/\{/)
          contents = ""
          nest_level = 1
          until nest_level == 0 do
            contents << (s.scan(/[^\{\}]+/) || "")
            if s.scan(/\{/) then
              nest_level += 1
              contents << "\{"
            elsif s.scan(/\}/) then
              nest_level -= 1
              contents << "\}" unless nest_level == 0
            end
          end
          c[key] = contents
          # puts "Found contents: #{contents}"
          raise unless s.scan(/\s*(\,|\})\s*/)
        end
        c
      end
      return citations
    end
  end
  # A class implementing a recursive scanner.
  # +root+ is the file to start the scanning from.
  # +includes+ is a hash with keys regular expressions and values blocks of
  #   code called when that expression matches. The block is passed the
  #   matched object as argument, and must return the full path to the file
  #   to be recursively scanned.
  # +extractors+ is a similar hash, dealing with the bits of text to be
  #   matched. The block is passed as arguments the current filename, the
  #   current line number counting from 0, the matched object and finally the
  #   entire file contents.
  class FileScanner
    attr_accessor :root, :includes, :extractors
    # Creates a new scanner object. If the argument +old_scanner+ is a String,
    # then it is set as the +root+ file. Otherwise, it is used to read the
    # values of the three variables.
    def initialize(old_scanner=nil)
      if old_scanner then
        if old_scanner.is_a?(String) then
          @root = old_scanner
          self.set_defaults
        else
          @root = old_scanner.root
          @includes = old_scanner.includes
          @extractors = old_scanner.extractors
        end
      else
        self.set_defaults
      end
    end
    # Default values for the +includes+ hash.
    def set_defaults
      @includes = Hash.new
      @includes[/(?:\\include|\\input)\{([^\}]*)\}/] = Proc.new {|m| 
        LaTeX.find_file( m[1], "tex", File.dirname(root) )
      }
      @extractors = Hash.new
    end
    # Performs the recursive scanning.
    def recursive_scan
       raise "No root specified!" if @root.nil?
       text = File.read(@root)
       text.each_with_index do |line, index|
         includes.each_pair do |regexp, block|
 # Consider using scan instead of match For the case of multiple includes in one line.
            if m = line.match(regexp) then 
             newfile = block.call(m)
             scanner = FileScanner.new(self)
             scanner.root = newfile.to_s
             scanner.recursive_scan
           end
           extractors.each_pair { |regexp,block| 
             block.call(root,index,m,text) if m = line.match(regexp)
            }
         end
       end
    end
    # Creates a FileScanner object and uses it to read all the labels from the
    # document. Returns a list of Label objects.
    def self.label_scan(root)
      # LaTeX.set_paths
      labelsList = Array.new
      scanner = FileScanner.new(root)
      scanner.extractors[/\\label\{([^\}]*)\}/] = Proc.new do |filename, line, matched, text| 
        labelsList << Label.new(:file => filename, :line => line, :label => matched[1], :contents => text)
      end
      scanner.recursive_scan
      labelsList
    end
    # Creates a FileScanner object and uses it to read all the citations from
    # the document. Returns a list of Citation objects.
    def self.cite_scan(root)
      citationsList = Array.new
      scanner = FileScanner.new(root)
      bibitem_regexp = /\\bibitem(?:\[[^\]]*\])?\{([^\}]*)\}(.*)/
      biblio_regexp = /\\bibliography\{([^\}]*)\}/
      scanner.extractors[bibitem_regexp] = Proc.new do |filename, line, matched, text|
      citationsList << Citation.new( "citekey" => matched[1], "cite_data" => matched[2])
      end
      scanner.extractors[biblio_regexp] = Proc.new do |filename, line, matched, text|
        file = LaTeX.find_file( matched[1], "bib", File.dirname(root) )
        citationsList += LaTeX.parse_bibfile(file)
        citationsList += LaTeX.parse_bibfile(ENV["TM_LATEX_BIB"]) unless ENV["TM_LATEX_BIB"].nil?
      end
      scanner.recursive_scan
      citationsList
    end
  end
  class Label
    attr_accessor :file, :line, :label, :contents
    def initialize(hash)
      ["file","line","label","contents"].each do |key|
        eval("@#{key} = hash[:#{key}]")
      end
    end
    def to_s
      label
    end
    # Returns the text around the label.
    def context(chars = 40)
      return contents.gsub(/\s/,"").match(/.{#{chars/2}}\\label\{#{label}\}.{#{chars/2}}/)
    end
    def file_line_label
      "#{file}:#{line}:#{label}"
    end
  end
  class Citation
    def initialize(hash = Hash.new)
      @hash = Hash.new
      hash.each_pair do |key,value|
        @hash[key.downcase] = value
      end
    end
    def []=(key,value)
      @hash[key.downcase] = value
    end
    def [](key)
      @hash[key.downcase]
    end
    def author
      @hash["author"] || @hash["editor"]
    end
    def title
      @hash["title"]
    end
    def description
      @hash["cite_data"] || "#{self.author}, #{self.title}"
    end
    def citekey
      @hash["citekey"]
    end
  end
end
# Example of use:
#
# include LaTeX
# ar = FileScanner.cite_scan("/Users/haris/svnlocalrepos/repos/master.tex")
# puts ar.length
# ar.each do |citation|
#   puts citation.description
# end
