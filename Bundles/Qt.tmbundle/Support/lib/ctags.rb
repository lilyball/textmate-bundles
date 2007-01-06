def replace_extension(filename, ext)
  f = filename.split(".")
  f[-1] = ext
  new_name = f.join(".")
  File.exists?(new_name) ? new_name : nil
end

class CTags
  class Tag < Struct.new(:name, :path, :pattern, :kind, :line, :klass, :inherits, :signature)
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

  def initialize(lines)
    @tags = Tags.new
    @classes = Tags.new
    @functions = Tags.new

    lines.reject! { |e| e =~ /^!_/ }
    lines.each do |line|
      tag = Tag.new(*line.split("\t"))
      @tags << tag
      @classes << tag if tag.kind == :class
      @functions << tag if tag.kind == :function
    end
  end

  def class_parent(class_name)
    return nil if class_name.nil?
    return nil if !@classes.has_key?(class_name)
    tag = @classes[class_name].find { |e| !e.inherits.nil? }
    tag.nil? ? nil : tag.inherits.first
  end

  def self.parse(files)
    ctags = ENV['TM_BUNDLE_SUPPORT'] + '/../../CTags.tmbundle/Support/bin/ctags'
    flags = "--language-force=C++ --fields=KnisS --excmd=pattern"
    temp = `mktemp -t ctags`.chomp
    begin
      system("\"#{ctags}\" -f \"#{temp}\" #{flags} #{files.map{|f| "\"#{f}\""}.join(' ')}")
	    tags = CTags.new(File.readlines(temp))
    ensure
	    File.delete(temp)
    end
    return tags
  end

  def self.run
    file = ENV['TM_FILEPATH']
    if file.nil?
      temp = `mktemp -t ctags`.chomp
      begin
        File.open(temp, "w+") { |f| f << $stdin.readlines }
        return CTags.parse(temp)
      ensure
        File.delete(temp)
      end
    else
      files = [ "h", "cpp" ].map { |e| replace_extension(file, e) }.compact
      raise "No corresponding .h and .cpp files found for #{ENV['TM_FILEPATH']}" if files.empty?
      return CTags.parse(files)
    end
  end
end
