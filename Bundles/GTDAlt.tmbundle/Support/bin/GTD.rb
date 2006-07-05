#
#  GTD.rb library for "getting things done".
#
#  Author:: Charilaos Skiadas
#  Version:: 0.1
require File.join(File.dirname(__FILE__),"GTDUtils.rb")
require 'pp'
require 'pathname'
# require 'dir'
# Module GTD. Used as a name-space for all other classes and methods.
module GTD
#--
  include GTDLight
  PROJECT_BEGIN_REGEXP = /^\s*(project)\s*(.*)$/
  PROJECT_END_REGEXP   = /^\s*(end)\s*$/
  ACTION_REGEXP        = /^\s*@(\S+)\s+((?:[^\[]+)(?:\s*\[\d+\])?)(?:\s+due:\[(\d{4}-\d{2}-\d{2})\])?\s*$/
  NOTE_REGEXP          = /^\[(\d+)\]\s+(.*)$/
  COMPLETED_REGEXP     = /^#completed:\[(\d{4}-\d{2}-\d{2})\]\s*@(\S+)\s+(([^\[]+)(?:\s*\[\d+\])?)(?:\s+(due:\[?:\d{4}-\d{2}-\d{2}\]))?\s*$/
  COMMENT_REGEXP       = /^\s*#(.*)$/
#++
  def GTD::parse(data)
    instructions = []
    d = data.split("\n")
    until d.empty?
      l = d.shift.chomp
      case l
        when PROJECT_BEGIN_REGEXP
          instructions << [:project,$2,nil,nil]
        when PROJECT_END_REGEXP
          instructions << [:end,nil,nil,nil]
        when ACTION_REGEXP
          instructions << [:action,$2,$1,$3]
        when COMPLETED_REGEXP
          instructions << [:completed,$3,$2,$1]
        when NOTE_REGEXP
          instructions << [:note,$2,$1,nil]
        when COMMENT_REGEXP
          instructions << [:comment,$1,nil,nil]
        when /^(\s*)$/
          instructions << [:comment,$1,nil,nil]
        else raise "Parse error on line: #{l}\n. This is not a line I recognize."
      end
    end
    return instructions
  end

  class << self
    @@contexts = ["email"]
    @@objects = Array.new
    @@files = Array.new
    def objects
      @@objects
    end
    def clear_objects
      # pp "here"
      @@objects = []
    end
    def add_object(object)
      @@objects << object
    end
    # Add the array newContexts to the contexts.
    def add_contexts(*newContexts)
      # pp ENV['TM_GTD_CONTEXT']
      @@contexts |= newContexts
      @@contexts.uniq!
      @@contexts.sort!
    end
    # Returns an array of all contexts, alphabetized.
    def get_contexts
      self.contexts
    end
    def contexts
      @@contexts
    end
    def clear_contexts
      @@contexts = []
    end
    GTD.add_contexts(*GTDLight.get_env_contexts)
    # Returns an array of all gtd files in given the directory, or in ENV['TM_GTD_DIRECTORY'] if
    # that is nil, or in the default directory otherwise.
    def get_gtd_directory(directory = nil)
      if directory then
        directory
      elsif (ENV['TM_GTD_DIRECTORY'] || "").to_s != ""
        ENV['TM_GTD_DIRECTORY'].to_s
      else
        Pathname.new(`pwd`.chomp)
      end
    end
    def gtd_files_in_directory(directory = nil)
      path = get_gtd_directory(directory)
    
      return  Dir::glob(File.join(path,"*.gtd"))
    end
    # Reads all files in given directory and processes them. Returns an array of
    # GTDFile objects, one for each file.
    def process_directory(directory = nil)
      files = gtd_files_in_directory(directory)
      for filename in files do
        # puts "processing #{filename}."
        @@objects << GTDFile.new(filename)
      end
      @@objects
    end
    def all_lines
      @actions + @projects + @other_lines + @completed_actions
    end
    # Returns the actions for a particular context from among all objects.
    def actions_for_context(context)
      return @@objects.map{|i| i.flatten.find_all{|action| Action === action && action.context == context}}.flatten
    end
    # Returns all next actions from all projects
    def next_actions
      return @@objects.map { |i| i.next_actions}.flatten.compact
    end
    def actions
      return @@objects.map{|i| i.flatten.find_all{|a| Action === a}}.flatten
    end
    def projects
      return @@objects.map { |i| i.projects }.flatten
    end
  
  end
    
  # Module for updating container objects (Project, GTDFile)
  # that have underlying file structure.
  module Container
    attr_accessor :subitems, :name, :file, :line
    include Linkable
    def update!(update_info = nil)
      if update_info then
        self.file = update_info[:file]
        self.line = update_info[:line]
      else
        update_info = {:file => self.file, :line => self.line}
      end
      if self.line == nil
        self.subitems.each { |item| item.update!(update_info) }
        return nil
      else
        cur_line = self.line + 1
        for item in self.subitems do
          cur_line = item.update!(update_info.update(:line => cur_line))
        end
        return cur_line + (GTDFile === self ? 0 : 1)
      end
    end
    def flatten
      self.subitems.map{|i| i.flatten}.flatten
    end
    def <<(object)
      self.subitems << object
    end
    def next_action
      self.subitems.find{|i| Action === i}
    end
    def next_actions
      self.flatten.map{|i| i.next_action}.compact
    end
    def projects
      self.flatten.find_all{|i| Project === i}
    end
    def actions
      self.flatten.find_all{|i| Action === i && !i.completed?}
    end
    def completed_actions
      self.flatten.find_all{|i| Action === i && i.completed?}
    end
    def flatten
      self.subitems.map{|i| i.flatten}.flatten.unshift(self)
    end
    def add_item(item)
      self.subitems << item
      item.parent = self
    end
    def remove_item(item)
      self.subitems.delete item
    end
    def push(item)
      add_item(item)
    end
    def pop
      self.subitems.pop
    end
    def unshift(item)
      self.subitems.unshift(item)
      item.parent = self
    end
    def shift
      self.subitems.shift
    end
    # Returns the string representing the object.
    def dump_object(indent = "", indent_inc = "  ", notes = [])
      s = []
      case self
      when Project
        s << indent + "project #{self.name}"
        for obj in subitems do
          s << obj.dump_object(indent + indent_inc,indent_inc,notes)
        end
        s << indent + "end"
      when GTDFile
        for obj in subitems do
          s << obj.dump_object(indent,indent_inc,notes)
        end
        notes.each_with_index { |note, index| s<<"[#{index+1}] #{note}" }
      end
      return s.join("\n")
    end
  end
    
  # A class managing +gtd+ files.
  class GTDFile
    include Container
    attr_reader :notes,  :other_lines, :subitems, :file, :line
    # Loads the data in filename and creates an object representing all projects/actions.
    # It can be provided by the data string instead.
    def initialize(filename)
      @subitems = Array.new
      @current_project = self
      @line = 0
      @notes = Hash.new
      if filename =~/gtd\z/ # Case where we were fed a filename
        @current_file = filename
        @file = @current_file
        if File.exist?(filename) then
          f = File.open(filename, "r")
          instructions = GTD::parse(f.read)
          process_instructions(instructions)
          f.close
        else
          File.open(filename, "a"){|f|}
        end
      else # Case where we were fed a string of data
        @file = nil
        @current_file = nil
        instructions = GTD::parse(filename)
        process_instructions(instructions)
      end
    end
    def name
      self.file.split("/").last
    end
    def root
      self
    end
    def process_instructions(instructions)
      until instructions.empty?
        code, name, context, due = instructions.shift
        case code
          when :project
            proj = Project.new(:name => name,:parent => @current_project)
            @current_project << proj
            @current_project = proj
          when :end
            raise "'end' without corresponding 'project'. Line:#{@current_line} of file #{@current_file}." if @current_project == self
            @current_project = @current_project.parent
          when :action
            name =~ /^\s*(\S.*?\S)\s*(?:\[(\d+)\])?$/
            thename, noteid = $1, $2
            due =~ /^(due|at|from):\[(\d{4}\-\d{2}\-\d{2})\]/
            due_type, date = $1, $2
            act = Action.new(:name => thename, 
                             :context => context,
                             :parent =>  @current_project,
                             :due => due, :due_type => due_type)
            if noteid != "" then
              act.note = noteid
              @notes[noteid] = act
            end
            GTD.add_contexts(context)
            @current_project << act
          when :note
            act = @notes[context]
            act.note = name unless act==nil
          when :completed
            name =~ /^\s*(\S.*?\S)\s*(?:\[(\d+)\])?$/
            thename, noteid = $1, $2
            act = Action.new(:name => thename, :context => context,:parent =>  @current_project,:due => due, :completed => true)
            if noteid != "" then
              act.note = noteid
              @notes[noteid] = act
            end
            @current_project << act
          else
            cmt = Comment.new(:name => name, :parent => @current_project)
            @current_project << cmt
        end
      end
      raise "'project' without 'end'." if @current_project != self
      update!
    end
    # Removes completed projects and actions and returns an array of references to them.
    # It also deletes all actions that have been marked as completed. You can call the
    # MyLogger class, and MyLogger.dump it.
    def cleanup_projects
      c_actions = self.completed_actions
      until c_actions.empty? do
        a = c_actions.shift
        note = (a.note.nil? || ENV['TM_ARCHIVE_NOTES'].nil?) ? "" : "\n  Note: #{a.note}"
        MyLogger.log "/#{a.due}/#{a.parent.name}/@#{a.context} #{a.name}#{note}"
        a.parent.remove_item(a)
      end
      
      completed_projects = self.projects.find_all {|i| i.completed?}
      completed_projects.each do |project|
        # pp project
        MyLogger.log "/#{Date.today}/#{project.name}"
        project.parent.remove_item(project)
        project.root.update!
      end
    end
  end
  # Thin class to incorporate the idea of an *item* in a file/project etc.
  # For a project, this is the line it starts at. For anything else, it is the
  # line it is at.
  class GTDItem
    attr_accessor :parent, :file, :line, :name, :completed
    def initialize(hash)
      @parent = hash[:parent]
      @name = hash[:name]
      @completed = true if @completed == nil
      self.update!(hash)
    end
    def update!(update_info)
      @file = update_info[:file]
      @line = update_info[:line]
      if @line then
        return @line + 1
      else
        return @line
      end
    end
    def completed?
      completed
    end
    def root
      parent.root
    end
    def flatten
      [self]
    end
    def next_action
      return nil
    end
    def dump_object(indent = "",inc_indent = "  ",notes = [])
      return indent + self.name
    end
  end
  
  class Project < GTDItem
    include Container
    # Contains both subprojects and independent actions
    attr_accessor :subitems
    # attr_accessor :end_line # this doesn't seem necessary on hindsight
    def initialize(hash)
      @subitems = []
      super
    end
    def to_s
      name
    end
    def completed?
      for i in @subitems do
        return false unless i.completed?
      end
      return false if name =~ /^!/
      return true
    end
    def next_action
      return @subitems.find { |e| Action === e && !e.completed? }
    end
    # Updates its subitems. Returns its end line plus 1.
  end

  class Action < GTDItem
    include Linkable
    # If the action is completed, then its completion date. Otherwise its due date or +nil+.
    attr_accessor :due
    # The type of the date. Should be <tt>"due"</tt>, <tt>"at"</tt> or <tt>"from"</tt>.
    attr_accessor :due_type
    # The text in the note, not the actual Note object. Empty if no note.
    attr_accessor :note
    attr_accessor :context, :completed
    def initialize(hash)
      @due = hash[:due]
      @due_type = hash[:due_type]
      @context = hash[:context]
      @note = hash[:note]
      @completed = hash[:completed] || false
      super
    end
    def to_s
      name + "from project: " + project.to_s + " @" + context
    end
    def project
      parent
    end
    def completed?
      completed
    end
    def dump_object(indent = "",inc_indent = "  ", notes = [])
      if self.completed? then
        return "\#completed:[#{self.due}]" + indent + "@#{self.context} #{self.name}"
      else
        notes << self.note if self.note
        return indent + "@#{self.context} #{self.name}" + 
               (self.note ? " [#{notes.length}]" : "") +
               (self.due ? " due:[#{self.due}]" : "")
      end
    end
  end
  class Comment < GTDItem
  end
  # class EndMarker < GTDItem
  # end
end
