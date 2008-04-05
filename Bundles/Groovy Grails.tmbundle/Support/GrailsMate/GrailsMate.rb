require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"
require "pstore"
require "erb"
include ERB::Util

class GrailsCommand
  
  attr_reader :location
  
  def initialize(grails, location, task, option_getter)
    @grails = grails
    @task = task
    @location = location
    @option_getter = option_getter
    @command = nil
  end
  
  def to_s
    command
  end
  
  def command
    if @command.nil?
      if (@option_getter.nil?)
        @command = "#{@task}"
      else
        prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.grailsmate"))
        pref_key = "#{@location}::#{@task}"
        last_value = prefs.transaction(true) { prefs[pref_key] }
        option = @option_getter[last_value]
        prefs.transaction { prefs[pref_key] = option }
        @command = "#{@task} #{option}"
      end
    end
    @command
  end
  
  def full_command
    @grails + " " + command
  end
  
  def run
    Dir.chdir(@location)
    rd, wr = IO.pipe
    rd.fcntl(Fcntl::F_SETFD, 1)
    stdin, stdout, stderr, pid = my_popen3(full_command)
    wr.close
    [stdout, stderr, rd, pid]
  end
  
end

class GrailsMate < CommandMate
  
  attr_reader :colorisations, :command
    
  def initialize(task, &option_getter) 
    super(GrailsCommand.new(ENV['TM_GRAILS'], ENV['TM_PROJECT_DIRECTORY'] || ENV['TM_DIRECTORY'], task, option_getter))
    setup_default_colorisations
  end

  def setup_default_colorisations
    @colorisations = {
      "green" => [/SUCCESS/,/Tests passed/,/Server running/],
      "red" => [/FAILURE/,/Tests failed/,/Compilation error/,/threw exception/, /Exception:/],
      "blue" => [/Environment set to/]
    }
  end
  
  def emit_header
    puts html_head(:window_title => "GrailsMate", :page_title => "GrailsMate", :sub_title => "#{@command.location}")
    puts "<pre>"
    puts "<strong>grails " + htmlize(@command.command) + "</strong><br>\n"
  end
  
  def filter_stderr(line)
    filter_stdout(line.chomp!)
  end
  
  def filter_stdout(line)
    line.chomp!
    match = false
    @colorisations.each do | color, patterns |
      if match == false and patterns.detect { |pattern| line =~ pattern }
        match = "<span style=\"color: #{color}\">#{line}</span><br>"
      end
    end
    match = (line) + "<br>" unless match 
    return match
  end
  
  def emit_html
    stdout, stderr, stack_dump, @pid = @command.run
    %w[INT TERM].each do |signal|
      trap(signal) do
        begin
          Process.kill("KILL", @pid)
          sleep 0.5
          Process.kill("TERM", @pid)
        rescue
          # process doesn't exist anymore
        end
      end
    end
    emit_header()
    TextMate::IO.exhaust(:out => stdout, :err => stderr, :stack => stack_dump) do |str, type|
      case type
        when :out   then print filter_stdout(str)
        when :err   then print filter_stderr(str)
        when :stack then @error << str
      end
    end
    emit_footer()
    Process.waitpid(@pid)
  end
  
end
