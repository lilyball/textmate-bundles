require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/tm/process"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/tm/htmloutput"

require "shellwords"
require "pstore"

class GrailsCommand
  
  attr_reader :colorisations
  
  def initialize(task, &option_getter)
    @grails = ENV['TM_GRAILS']
    @location = ENV['TM_PROJECT_DIRECTORY'] || ENV['TM_DIRECTORY']
    @task = task
    @option_getter = option_getter
    @command = []
    @colorisations = {
      "green" => [/SUCCESS/,/Tests passed/,/Server running/],
      "red" => [/FAILURE/,/Tests failed/,/Compilation error/,/threw exception/, /Exception:/],
      "blue" => [/Environment set to/]
    }
  end

  def command
    if @command.empty?
      @command << @task unless @task.nil? or @task.empty?
      unless @option_getter.nil?
        prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.grailsmate"))
        pref_key = "#{@location}::#{@task}"
        last_value = prefs.transaction(true) { prefs[pref_key] }
        option = @option_getter[last_value]
        prefs.transaction { prefs[pref_key] = option }
        Shellwords.shellwords(option).each { |option| @command << option }
      end
    end
    @command
  end
      
  def run
    Dir.chdir(@location) do 
      TextMate::HTMLOutput.show(:window_title => "GrailsMate", :page_title => "GrailsMate", :sub_title => "#{@location}") do |io|
        cmd = command
        io << "<pre>"
        io << "<strong>grails " + htmlize(cmd.join(' ')) + "</strong><br/>"
        TextMate::Process.run(@grails, cmd) do |line|
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