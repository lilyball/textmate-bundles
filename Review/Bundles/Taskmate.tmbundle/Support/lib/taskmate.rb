$KCODE = 'u'

require File.dirname(__FILE__) + "/taskmate/datetime"
require File.dirname(__FILE__) + "/taskmate/file"
require File.dirname(__FILE__) + "/taskmate/source"
require File.dirname(__FILE__) + "/taskmate/project"
require File.dirname(__FILE__) + "/taskmate/item"
require File.dirname(__FILE__) + "/taskmate/taglist"

class Taskmate
  attr_reader :dir, :sources
    
  PATTERNS = {
    :project => /^\s*[^:\n]{1,99}:[ \t]*$/,
    :item => /^\s*[-✓+]+\s*.+$/,      # TODO used in source.rb and item.rb 
    :item_text => "^[-✓+]+\s*(.*)*$"  # respectively. can they be unified?
  }
  
  class << self
    def env_dir
      ENV['TM_TASKMATE_DIRECTORY'] ||
      ENV['TM_TASKPAPER_DIRECTORY'] ||
      ENV['TM_PROJECT_DIRECTORY'] ||
      ENV['TM_DIRECTORY']  
    end
    
    def status_symbols
      [completed_symbol, pending_symbol]
    end
    
    def completed_symbol
      ENV['TASKMATE_COMPLETED_SYMBOL'] or '+'
    end
    
    def pending_symbol
      ENV['TASKMATE_PENDING_SYMBOL'] or '-'
    end
  end
  
  def initialize(dir = nil)
    @dir = dir || Taskmate.env_dir
    # @sources = unmarshal_sources
    # unless @sources      
      @sources = []
      readdir
    #   marshal_sources
    # end
  end
  
  def marshal_sources
    File.write(marshal_file, Marshal.dump(@sources))
  end
  
  def unmarshal_sources
    @sources = Marshal.load(File.read(marshal_file)) rescue nil
  end  
  
  def marshal_file
    marshal_dir + dir.sub(/^\//, '').gsub(/[\/\. ]/, '-') + '.marshal' # TODO use some hash here?
  end 
  
  def marshal_dir
    dir = File.dirname(__FILE__) + '/../data/' # TODO use the tmp directory
    Dir.mkdir(dir) unless File.exists?(dir)
    dir
  end 
  
  def stats
    completed = items.select { |i| i.completed? }.size
    "You have #{items.size} tasks (#{completed} completed) in #{projects.size} projects and #{@sources.size} files."
  end
  
  def items
    projects.collect{|p| p.items}.flatten
  end
  
  def projects
    sources.collect{|s| s.projects}.flatten
  end
  
  def tags
    @tags ||= Taglist.new(self)
  end
  
  def completed_items
    @completed_items ||= collect_completed_items
  end
  
  def collect_completed_items
    items = sources.collect{|s| s.completed_items}.flatten
    # just comparing the Datetime objects doesn't work for some weird reason
    items.sort!{ |a, b| b.completed_datetime.strftime(Item::DATE_FORMAT) <=> a.completed_datetime.strftime(Item::DATE_FORMAT) }
    items.inject([]) do |result, item|
      if result.last.nil? || result.last[0] != item.project.name
        result << [item.project.name, [item]] 
      else
        result.last[1] << item
      end
      result
    end
  end
  
  def readdir
    Dir.glob(@dir + '/**/[^@]*.todo') { |file| @sources << Source.new(file) }
  end
  
  def jump_from_tag(file, line, tag)
    is_tag_file?(file) ? jump_to_sourcefile(file, line) : jump_to_tagfile(tag)
  end
  
  def jump_to_sourcefile(file, line)
    line = File.line_at(file, line.to_i - 1).strip
    filename = if line =~ PATTERNS[:item]
      source = find_item_source(Item.new(line))
    elsif  line =~ PATTERNS[:project]
      source = find_project_source(Project.new(line))
    end
    return if source.nil?
    line = File.line_number(source.filename) { |l| l.strip == line }
    Taskmate.open(source.filename, line)
  end
  
  def jump_to_tagfile(tag)
    Taskmate.open tag_filename(tag)
  end
  
  def tag_filename(tag)
    "#{@dir}/#{tag}.todo"
  end
  
  def is_tag_file?(file)
    File.basename(file) =~ /^@[^@]+.todo$/
  end
  
  def rebuild_files
    remove_tag_files
    filenames = tags.collect do |tag, projects| 
      if tag == :@completed
        rebuild_completed_file
      else
        rebuild_tag_file(tag, projects) 
      end
    end.compact
  end
  
  def rebuild_completed_file
    return if completed_items.empty?
    contents = completed_items.collect do |project_name, items|
      "#{project_name}:\n" + items.each { |item| "#{item.to_s}" }.join("\n")
    end.join("\n\n")
    File.write(filename = "#{@dir}/@completed.todo", contents)
    filename
  end
  
  def rebuild_tag_file(tag, projects)
    contents = projects.collect do |project, items|
      next if project.nil? || items.empty?
      "#{project.name}:\n" + items.collect { |item| "#{item.to_s}\n" if item.pending? ^ (tag == :@completed) }.join
    end.join("\n")
    File.write(filename = tag_filename(tag), contents)
    filename
  end
  
  def remove_tag_files
    Dir.glob(@dir + '/@*.todo') { |file| File.delete file }
  end
  
  def toggle_completed(file, line)
    line = File.line_at(file, line.to_i - 1).strip
    if Item.is_item?(line)
      item = Item.new(line)
      item.toggle_completed!
      update_with_item(item)
      File.sub(filenames_for_item(item), line, item.to_s)
      @tags = Taglist.new(self)
    end
  end
  
  def add_tag(file, line, tag)
    tag = tag.to_s.intern
    line = File.line_at(file, line.to_i - 1).strip
    if Item.is_item?(line)
      item = Item.new(line)
      item.add_tag(tag)
      update_with_item(item)
      File.sub(filenames_for_item(item), line, item.to_s)
      @tags = Taglist.new(self)
    end
  end
  
  def update_with_item(item)
    items.each { |i| i.attributes = item.attributes if i == item }    
  end
  
  def filenames_for_item(item)
    filenames = item.tags.collect { |tag| "#{@dir}/#{tag}.todo" }
    source = find_item_source(item)
    filenames << source.filename unless source.nil?
    filenames.select { |filename| File.exists?(filename) }
  end
  
  def find_project_source(project)
    @sources.each do |source|
      return source if source.contains_project?(project)
    end
    nil
  end
  
  def find_item_source(item)
    @sources.each do |source|
      return source if source.contains_item?(item)
    end
    nil
  end
  
  class << self
    
    # shamelessly stolen from the Ruby on Rails bundle  
    def open_url(url)
      `open "#{url}"`
    end

    # Open a file in textmate using the txmt:// protocol.  Uses 0-based line and column indices.
    def open(filename, line_number = nil, column_number = nil)
      options = []
      options << "url=file://#{filename}"
      options << "line=#{line_number + 1}" if line_number
      options << "column=#{column_number + 1}" if column_number
      open_url "txmt://open?" + options.join("&")
    end  
  end
  
end

