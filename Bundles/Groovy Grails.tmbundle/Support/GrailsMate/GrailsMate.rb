#!/usr/bin/env ruby -w

require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "GrailsTask"
require "pstore"
require "erb"
include ERB::Util

class GrailsMate
  
  VERSION = "1.0.0".freeze

  attr_reader :green_patterns, :red_patterns
  
  def initialize(task, &option_getter)

    @location = (ENV["TM_PROJECT_DIRECTORY"] || ENV["TM_DIRECTORY"]).freeze
    Dir.chdir(@location)
    header()
    
    @green_patterns = [/SUCCESS/,/Tests passed/,/Server running/]
    @red_patterns = [/FAILURE/,/Tests failed/,/Compilation error/,/threw exception/]
    
    @task = task
    @option_getter = option_getter
    
    
    @grails = ENV["TM_GRAILS"]
    if @grails.nil? or not File.exist? @grails
      error("grails not found.  Please set TM_GRAILS.")
    end
  end
  
  def run()
    command = get_full_command()
    print "#{command}<br />"
    task = GrailsTask.new(command)
    
    task.run do |line, mode|
      if @green_patterns.detect { |pattern| line =~ pattern }
        print "<span style=\"color: green\">#{line.chomp}</span><br />"
      elsif @red_patterns.detect { |pattern| line =~ pattern }
        print "<span style=\"color: red\">#{line.chomp}</span><br />"
      else
        print htmlize(line)
      end
      $stdout.flush
    end
      
  end
  
  private
  
  def get_full_command()
    if (@option_getter.nil?)
      return "#{@grails} #{@task}"
    else
      prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.grailsmate"))
      pref_key = "#{@location}::#{@task}"
      last_value = prefs.transaction(true) { prefs[pref_key] }
      option = @option_getter[last_value]
      prefs.transaction { prefs[pref_key] = option }
      return "#{@grails} #{@task} #{option}"
    end
  end
  
  def header()
    html_header("GrailsMate", "grails")
    puts "<pre>"
    puts "GrailsMate v#{VERSION} running on Ruby v#{RUBY_VERSION} (#{ENV["TM_RUBY"].strip})"
    $stdout.flush
  end
  
  def error(error)
    puts error
    footer()
    exit
  end

  def footer
    puts "</pre>"
    html_footer
  end

end
