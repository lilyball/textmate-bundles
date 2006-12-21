require 'strscan'
module LaTeX
  def e_var(name)
    name.gsub(/[^a-zA-Z0-9\-_]/,"").gsub(/\-/,"_")
  end
  class <<self
    def get_labels
      return FileScanner.label_scan(ENV["TM_LATEX_MASTER"] || ENV["TM_FILEPATH"]).map{|i| i.label}.sort
    end
    def get_citations
      return FileScanner.cite_scan(ENV["TM_LATEX_MASTER"] || ENV["TM_FILEPATH"]).map{|i| i}.sort { |a,b| a.citekey <=> b.citekey }
    end
    def get_citekeys
      self.get_citations.map{|i| i["citekey"]}
    end
    def check_tex_path
      raise "The tex binaries cannot be located!" if `which kpsewhich`.match(/^no kpsewhich/)
    end
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
    # Accepts a hash with the following keys:
    # (1) +root+ The filename to start from
    # (2) +include+ An array of pairs +regexp, block+. The +regexp+ indicates what
    #               text to search for for the files to traverse. +block+ is passed
    #               the matched object as an argument, and should return the
    #               filename to be used.
    # (3) +match+   An array of pairs +regexp, block+. The block is yielded with
    #               the filename, line number, matched object, and entire file
    #               contents.
  class FileScanner
    attr_accessor :root, :includes, :extractors
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
    def set_defaults
      @includes = Hash.new
      @includes[/(?:\\include|\\input)\{([^\}]*)\}/] = Proc.new {|m| 
        LaTeX.find_file( m[1], "tex", File.dirname(root) )
      }
      @extractors = Hash.new
    end
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
