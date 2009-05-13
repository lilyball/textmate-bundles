# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes analyzing of a Griffon path + filename easier.
# 
# Mercileslly ripped off from the Rails bundle by Luke Daley.

require 'misc'
require 'TextMate'
require 'buffer'

module AssociationMessages
  # Return associated_with_*? methods
  def method_missing(method, *args)
    case method.to_s
    when /^associated_with_(.+)\?$/
      return associations[$1.to_sym].include?(file_type)
    else
      super(method, *args)
    end
  end

  @@associations = {
    :controller => [:view, :domain_class, :service, :taglib, :controller_test],
    :view => [:controller, :domain_class, :taglib],
    :domain_class => [:controller, :service, :domain_class_test],
    :service => [:controller, :domain_class, :taglib, :service_test],
    :taglib => [:controller, :view, :taglib_test],
    :controller_test => [:controller, :domain_class],
    :domain_class_test => [:domain_class],
    :service_test => [:service, :controller],
    :taglib_test => [:taglib] 
  }

  # Make associations hash publicly available to each object
  def associations; self.class.class_eval("@@associations") end
end

class GriffonPath
  attr_reader :filepath

  include AssociationMessages

  def initialize(filepath = TextMate.filepath)
    if filepath[0..0] == '/'
      # Absolute file, treat as is
      @filepath = filepath
    else
      # Relative file, prepend griffon_root
      @filepath = File.join(griffon_root, filepath)
    end
  end

  def buffer
    @buffer ||= Buffer.new_from_file(self)
  end

  def exists?
    File.file?(@filepath)
  end
  
  def basename
    File.basename(@filepath)
  end
  
  def dirname
    File.dirname(@filepath)
  end

  def touch_directories
    return if dirname[0..0] != '/'
    dirs = dirname[1..-1].split('/')
    for i in 0..(dirs.size)
      new_dir = '/' + File.join(dirs[0..i])
      Dir.mkdir(new_dir) if !File.exist?(new_dir)
    end
  end
  
  # Make sure the file exists by creating it if it doesn't
  def touch
    if !exists?
      touch_directories
      f = File.open(@filepath, "w"); f.close
    end
  end
  
  def artifact_base_name
    name = basename
    # Remove extension
    name.sub!(/\.\w+$/, '')
    # Remove extras
    case file_type
      when :controller then name.sub!(/Controller$/, '')
      when :view then name = dirname.split('/').pop.capitalize
      when :domain_class then name
      when :service then name.sub!(/Service$/, '')
      when :taglib then name.sub!(/TagLib$/, '')
      when :controller_test then name.sub!(/ControllerTests$/, '')
      when :domain_class_test then name.sub!(/Tests$/, '')
      when :service_test then name.sub!(/ServiceTests$/, '')
      when :taglib_test then name.sub!(/TagLibTests$/, '')
    end
    
    return name
  end
  
  def action_name
    name =
      case file_type
      when :controller
        buffer.find_method(:direction => :backwards).first rescue nil
      when :view
        basename
      # when :unit_test
      #   buffer.find_method(:direction => :backwards).first.sub('^test_', '')
      else nil
      end
    
    return name.sub(/\.\w+$/, '') rescue nil # Remove extension
  end
  
  def griffon_root
    return TextMate.project_directory
    # TODO: Look for the root_indicators inside TM_PROJECT_DIRECTORY and return nil if not found

    #self.class.root_indicators.each do |i|
    #  if index = @filepath.index(i)
    #    return @filepath[0...index]
    #  end
    #end
  end
  
  # This is used in :file_type and :griffon_path_for_view
  VIEW_EXTENSIONS = %w( gsp )

  def file_type
    return @file_type if @file_type
    
    @file_type =
      case @filepath
        when %r{/griffon-app/controllers/(.+Controller\.(groovy))$}      then :controller
        when %r{/griffon-app/views/(.+\.(#{VIEW_EXTENSIONS * '|'}))$}    then :view
        when %r{/griffon-app/domain/(.+\.(groovy))$}                     then :domain_class
        when %r{/griffon-app/services/(.+Service\.(groovy))$}             then :service
        when %r{/griffon-app/taglib/(.+TagLib\.(groovy))$}               then :taglib
        when %r{/test/unit/(.+ControllerTests\.(groovy))$}       then :controller_test
        when %r{/test/unit/(.+ServiceTests\.(groovy))$}          then :service_test
        when %r{/test/unit/(.+TagLibTests\.(groovy))$}           then :taglib_test
        when %r{/test/unit/(.+Tests\.(groovy))$}                 then :domain_class_test
        else nil
      end
    # Store the tail (modules + file) after the regexp
    # The first set of parens in each case will become the "tail"
    @tail = $1
    # Store the file extension
    @extension = $2
    return @file_type
  end
  
  def tail
    # Get the tail if it's not set yet
    file_type unless @tail
    return @tail
  end
  
  def extension
    # Get the extension if it's not set yet
    file_type unless @extension
    return @extension
  end
  
  # View file that does not begin with _
  def partial?
    file_type == :view and basename !~ /^_/
  end
  
  def artifact_base_name_modified_for(type)
    case type
      when :controller then artifact_base_name + 'Controller'
      when :service then artifact_base_name + 'Service'
      when :taglib then artifact_base_name + 'TagLib'
      when :controller_test then artifact_base_name + 'ControllerTests'
      when :domain_class_test then artifact_base_name + 'Tests'
      when :service_test then artifact_base_name + 'ServiceTests'
      when :taglib_test then artifact_base_name + 'TagLibTests'
      else artifact_base_name
    end
  end

  def default_extension_for(type)
    case type
      when :view       then '.gsp'
      else '.groovy'
    end
  end
  
  def griffon_path_for(type)
    return griffon_path_for_view if type == :view
    if TextMate.project_directory
      GriffonPath.new(File.join(griffon_root, stubs[type], artifact_base_name_modified_for(type) + default_extension_for(type)))
    else
      puts "There needs to be a project associated with this file."
    end
  end
  
  def griffon_path_for_view
    return ask_for_view("index") if action_name.nil?
    
    file_exists = false
    VIEW_EXTENSIONS.each do |e|
      filename_with_extension = action_name + "." + e
      existing_view = File.join(griffon_root, stubs[:view], artifact_base_name.downcase, filename_with_extension)
      return GriffonPath.new(existing_view) if File.exist?(existing_view)
    end
    default_view = File.join(griffon_root, stubs[:view], artifact_base_name.downcase, action_name + default_extension_for(:view))
    return GriffonPath.new(default_view)
  end
  
  def ask_for_view(default_name = action_name)
    if designated_name = TextMate.input("Enter the name of the new view file:", default_name + default_extension_for(:view))
      view_file = File.join(griffon_root, stubs[:view], artifact_base_name.downcase, designated_name)
      # FIXME: For some reason the following line freezes TextMate
      # TextMate.refresh_project_drawer
      return GriffonPath.new(view_file)
    end
    return nil
  end
  
  def self.stubs
    { 
      :controller => 'griffon-app/controllers',
      :view => 'griffon-app/views/',
      :domain_class => 'griffon-app/domain',
      :service => 'griffon-app/services',
      :taglib => 'griffon-app/taglib',
      :controller_test => 'test/unit',
      :domain_class_test => 'test/unit',
      :service_test => 'test/unit',
      :taglib_test => 'test/unit'
    }
  end
  
  def stubs; self.class.stubs end
    
  def ==(other)
    other = other.filepath if other.respond_to?(:filepath)
    @filepath == other
  end
end