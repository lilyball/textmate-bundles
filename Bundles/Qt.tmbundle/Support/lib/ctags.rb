def replace_extension(filename, ext)
  f = filename.split(".")
  f[-1] = ext
  new_name = f.join(".")
  File.exists?(new_name) ? new_name : nil
end

class CTags
  class Tag < Struct.new(:name, :path, :pattern, :kind, :line, :klass, :inherits, :signature, :result_type)
    def initialize(*args)
      super
      self.kind = kind.nil? ? nil : kind.to_sym
      self.line = line.nil? ? nil : line.split(":")[1].to_i
      case kind
      when :class
        self.klass = name
        self.inherits = f(args, "inherits") { |p| p.chomp.split(",") }
        self.signature = nil
      when :function
        self.klass = f(args, "class") || ""
        self.inherits = nil
        self.signature = f(args, "signature") { |s| s.chomp } || ""
        self.result_type = $1 if pattern =~ /^\/\^\s*(.+)#{name}/
      end
    end
  
  private
    def f(args, name)
      f = args.find { |e| e =~ /^#{name}:/ }
      return nil if f.nil?
      val = f.split(":")[1]
      if block_given?
        yield val
      else
        val
      end
    end
  end

  class Tags < Hash
    def <<(tag)
      if has_key?(tag.name)
        self[tag.name] << tag
      else
        self[tag.name] = [tag]
      end
    end
  end

  attr_reader :tags, :classes, :functions

  def initialize(tags)
    @tags = tags
    @classes = Tags.new
    @functions = Tags.new

    tags.each do |tag|
      @classes << tag if tag.kind == :class
      @functions << tag if tag.kind == :function
    end
  end

  def self.create(lines)
    tags = Array.new

    lines.reject! { |e| e =~ /^!_/ }
    tags = lines.map do |line|
      Tag.new(*line.split("\t"))
    end
    
    return CTags.new(tags)
  end

  def +(other)
    CTags.new(self.tags + other.tags)
  end

  def class_parent(class_name)
    return nil if class_name.nil?
    return nil if !@classes.has_key?(class_name)
    tag = @classes[class_name].find { |e| !e.inherits.nil? }
    tag.nil? ? nil : tag.inherits.first
  end

  def self.parse(files)
    ctags = ENV['TM_BUNDLE_SUPPORT'] + '/../../CTags.tmbundle/Support/bin/ctags'
    flags = "--language-force=C++ --fields=KnisSafm --excmd=pattern"
    temp = `mktemp -t ctags`.chomp
    begin
      system("\"#{ctags}\" -f \"#{temp}\" #{flags} #{files.map{|f| "\"#{f}\""}.join(' ')}")
      tags = CTags.create(File.readlines(temp))
    ensure
	    File.delete(temp)
    end
    return tags
  end

  def self.parse_data(lines)
    temp = `mktemp -t ctags`.chomp
    begin
      File.open(temp, "w+") { |f| f << lines }
      tags = CTags.parse(temp)
      tags.tags.each { |t| t.path = nil }
      return tags
    ensure
      File.delete(temp)
    end
  end

  def self.run
    tags = parse_data($stdin.readlines)
    file = ENV['TM_FILEPATH']
    if !file.nil?
      files = [ "h", "cpp" ].map { |e| replace_extension(file, e) }.compact
      files -= [file]
      raise "No corresponding .h and .cpp files found for #{ENV['TM_FILEPATH']}" if files.empty?
      tags += CTags.parse(files)
    end
    return tags
  end
end
