require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/tm/process"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/tm/htmloutput"

require "shellwords"
require "pstore"

class GriffonCommand
  
  attr_reader :colorisations
  
  def initialize(task, &option_getter)
    @griffon = ENV['TM_GRIFFON']
    @location = ENV['TM_PROJECT_DIRECTORY'] || ENV['TM_DIRECTORY']
    @task = task
    @option_getter = option_getter
    @command = nil
    @colorisations = {
      "green" => [/SUCCESS/,/Server running/, /Tests PASSED/, /Running test (\w+)...PASSED/],
      "red" => [/FAILURE/,/Tests FAILED/,/Compilation error/,/threw exception/, /Exception:/, /...FAILED/],
      "blue" => [/Environment set to/],
    }
  end

  def command
    if @command.nil?
      option = nil
      unless @option_getter.nil?
        prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.griffonmate"))
        pref_key = "#{@location}::#{@task}"
        last_value = prefs.transaction(true) { prefs[pref_key] }
        option = @option_getter[last_value]
        prefs.transaction { prefs[pref_key] = option }
      end
      @command = construct_command(@task, option)
    end
    @command
  end
  
  def construct_command(task, option) 
    command = []
    command << task unless task.nil? or task.empty?
    unless option.nil? or option.empty?
      (Shellwords.shellwords(option).each { |option| command << option })
    end
    command
  end
      
  def run
    Dir.chdir(@location) do 
      cmd = command
      TextMate::HTMLOutput.show(:window_title => "GriffonMate", :page_title => "GriffonMate", :sub_title => "#{@location}") do |io|
        if cmd.nil?
          io << "Command cancelled."
        else
          io << "<pre>"
          io << "<strong>griffon " + htmlize(cmd.join(' ')) + "</strong><br/>"
          TextMate::Process.run(@griffon, cmd) do |line|
            line.chomp!
            match = false
            if line =~ /^(Running test )(\S+)(\.\.\.)$/
              match = $1 + "<a href='txmt://open?url=file://#{@location}/test/reports/plain/TEST-#{$2}.txt'>#{$2}</a>" + $3 + "</br>"
            else 
              @colorisations.each do | color, patterns |
                if match == false and patterns.detect { |pattern| line =~ pattern }
                  match = "<span style=\"color: #{color}\">#{htmlize line}</span><br/>"
                end
              end
            end
            io << (match ? match : "#{htmlize line}<br/>")
          end
          io << "</pre>"
        end
      end
    end
  end
  
end