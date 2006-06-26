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
  PROJECT_BEGIN_REGEXP = /^\s*(project)\s*(.*)$/
  PROJECT_END_REGEXP   = /^\s*(end)\s*$/
  ACTION_REGEXP        = /^\s*@(\S+)\s+((?:[^\[]+)(?:\s*\[\d+\])?)(?:\s+due:\[(\d{4}-\d{2}-\d{2})\])?\s*$/
  NOTE_REGEXP          = /^\[(\d+)\]\s+(.*)$/
  COMPLETED_REGEXP     = /^#completed:\[(\d{4}-\d{2}-\d{2})\]\s*@(\S+)\s+((?:[^\[]+)(?:\s*\[\d+\])?)(?:\s+due:\[(\d{4}-\d{2}-\d{2})\])?\s*$/
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
        else pp l; raise "Parse error: #{l}"
      end
    end
    return instructions
  end

# A class managing +gtd+ files.
  class GTDFile
    @@contexts = ["email"]
    if (defaultContexts = ENV['TM_GTD_CONTEXT']) != nil then
      @@contexts |= defaultContexts.chomp.split(" ")
    end
    @@objects = Array.new
    @@files = Array.new

    # Returns an array of all gtd files in given directory, or ENV['TM_GTD_DIRECTORY'] if
    # that is nil, or the default directory otherwise.
    def self.get_files(directory = nil)
      path = if directory then
                  directory
             elsif ENV['TM_GTD_DIRECTORY'] && ENV['TM_GTD_DIRECTORY'].to_s != ""
                ENV['TM_GTD_DIRECTORY'].to_s
              else
                Pathname.new(`pwd`.chomp)
              end
      return  Dir::glob("*.gtd").map{|f| path + f}
    end
    # Reads all files in given directory and processes them. Returns an array of
    # GTDFile objects, one for each file.
    def self.process_directory(directory = nil)
      files = get_files(directory)
      for filename in files do
        @@objects << self.new(filename)
      end
      @@objects
    end
    # Add the array newContexts to the contexts.
    def self.add_contexts(*newContexts)
      @@contexts += newContexts
    end
    # Returns an array of all contexts, alphabetized.
    def self.get_contexts
      @@contexts.sort
    end
    # Returns the actions for a particular context from among all objects.
    def self.actions_for_context(context)
      return @@objects.map{|i| i.actions_for_context(context)}.flatten
    end
    # Returns all next actions from all projects
    def self.next_actions
      return @@objects.map { |i| i.next_actions }.flatten.compact
    end

    attr_reader :projects, :actions, :notes, :completed_actions, :current_file, :other_lines
    # Loads the data in filename and creates an object representing all projects/actions.
    def initialize(filename)
      @current_project = nil
      @@files << @current_file
      @current_file = filename
      # @current_line = 0
      @projects = Array.new
      @actions = Array.new
      @notes = Hash.new
      @other_lines = Array.new
      @completed_actions = Array.new
      File.open(filename, "r") do |f|
        instructions = GTD::parse(f.read)
        process_instructions(instructions)
      end
    end
    # Processes an array of instructions. Not to be called directly.
    def process_instructions(instructions)
      @current_project = nil
      @current_line = 0
      until instructions.empty?
        code, name, context, due = instructions.shift
        @current_line += 1
        case code
          when :project
            proj = Project.new(name,@current_project,@current_file,@current_line)
            @current_project.subitems << proj if @current_project
            @current_project = proj
            @projects << proj
          when :end
            raise "'end' without corresponding 'project'. Line:#{@current_line} of file #{@current_file}." unless @current_project
            @current_project.end_line = @current_line
            @current_project = @current_project.parent
          when :action
            name =~ /^\s*(\S.*?\S)\s*(?:\[(\d+)\])?$/
            thename, noteid = $1, $2
            act = Action.new(thename,context, @current_project, @current_file, @current_line,due)
            @actions << act
            act.note = noteid
            @notes[noteid] = act if noteid != ""
            @@contexts |= [context]
            @current_project.subitems << act  if @current_project
          when :note
            act = @notes[context]
            # raise "Could not find action for Note: [#{context}] #{name}" unless act
            act.note = name unless act==nil || act == ""
          when :completed
            act = Action.new(name,context, @current_project, @current_file, @current_line,due)
            act.completed = true
            @completed_actions << act
          else
            @other_lines << Comment.new(name,@current_file,@current_line)
        end
      end
      raise "'project' without 'end'." if @current_project != nil
    end
    # Returns an array of the actions with given context.
    def actions_for_context(context)
      return @actions.find_all {|a| a.context == context}
    end
    # Returns an array of the next actions.
    def next_actions
      return @projects.map { |i| i.next_action }
    end
    # Returns the string representing the object.
    def dump_object
      objects = @actions + @projects + @other_lines + @completed_actions
      objects += @projects.map{|p| EndMarker.new(p.end_line)}
      objects = objects.sort {|a,b| a.line <=> b.line}
      indent = 0
      indent_inc = 2
      s = []
      endA = []
      index = 0
      objects.each do |o|
        case o
        when Project
          t = " " * indent
          s << t + "project #{o.name}"
          indent += indent_inc
        when Action
          t = " " * indent
          t << "@#{o.context} #{o.name}"
          if o.note != nil then
            index += 1
            t << " [#{index}]"
            endA << "[#{index}] #{o.note}"
          end
          if o.due != nil  then
            t << " due:[#{o.due}]"
          end
          s << t
        when Comment
          # t = " " * indent
          s << "#{o.name}"
        when EndMarker
          indent -= indent_inc
          t = " " * indent
          s << t + "end"
        end
      end
      return (s + endA).join("\n")
    end
    # Removes completed projects and actions and returns an array of references to them.
    # It also deletes all actions that have been marked as completed. You can call the
    # MyLogger class, and MyLogger.dump it.
    def cleanup_projects
      until @completed_actions.empty? do
        a = @completed_actions.shift
        MyLogger.log "/#{a.due}/#{if a.project then a.project.name else "none" end}/@#{a.context} #{a.name}"
      end
      comp, @projects = *@projects.partition {|i| i.completed?}
      comp.each do |p|
        MyLogger.log "/#{Date.today}/#{p.name}"
      end
    end
  end

  class Project
    include Linkable
    # Contains both subprojects and independent actions
    attr_accessor :subitems
    attr_accessor :name, :parent, :file, :line, :end_line
    def initialize(name,parent,file,line)
      @name = name
      @file = file
      @line = line
      @subitems = []
      @parent = parent
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
      return @subitems.find { |e| Action === e }
    end
  end

  class Action
    include Linkable
    # If the action is completed, then its completion date. Otherwise its due date or +nil+.
    attr_accessor :due
    # The text in the note, not the actual Note object.
    attr_accessor :note
    attr_accessor :context, :name, :project, :file, :line, :completed
    def initialize(name,context,project,file,line,due = nil)
      @due = due
      @context = context
      @name = name
      @project = project
      @file = file
      @line = line
      @note = ""
      @completed = false
    end
    def to_s
      @name + "from project: " + @project.to_s + " @" + @context
    end
    def completed?
      completed
    end
  end
  class Comment
    attr_accessor :name, :file, :line
    def initialize(name,file,line)
      @name = name
      @file = file
      @line = line
    end
  end
  class EndMarker
    attr_reader :line
    def initialize(line)
      @line = line
    end
  end
end