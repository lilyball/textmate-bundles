require "#{File.dirname(__FILE__)}/JavaProjectClassTree"
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require "find"
require "pathname"
class Project
    
  attr_reader :classes, :path
  
  def initialize(path)
    @path = path
    @pathname = Pathname.new(path)
    @classes = JavaProjectClassTree.new
  end
  
  def scan
    scan_at("")
  end

  def scan_at(rel_path)
    TextMate.scan_dir(@path, self.method(:inspect_file), TextMate::ProjectFileFilter.new)
  end
  
  def inspect_file(path)
    if is_class? path
      package = get_package_from_class_file(path)
      class_name = get_class_name_from_class_file(path)
      rel_path = Pathname.new(path).relative_path_from(@pathname).to_s
      @classes.add_class(package, class_name, rel_path)
    end
  end
  
  def is_class?(path)
    [".java", ".groovy"].member? File.extname(path)
  end

  def get_package_from_class_file(path)
    package = nil
    File.open(path, "r") do |f|
      while (line = f.gets)
        if line =~ /\s*package\s+([^\s;]+)/
          package = $1
          break
        end
      end
    end
    package
  end
  
  def get_class_name_from_class_file(path)
    basename = File.basename(path)
    basename =~ /(.+)\..+$/
    $1
  end
end