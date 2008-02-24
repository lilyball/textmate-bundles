#!/usr/bin/env ruby -w

# require "stdin_dialog"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

require "pstore"
require "cgi"
require "open3"

TextMate::IO.sync = false

$SCRIPTMATE_VERSION = "$Revision: 8136 $"

class MavenProfileManager
  
  def initialize()
    @location = MavenMate.location
    @key = "#{@location}::profiles"
    @profiles = nil
  end
  
  def set_profiles
    newprofiles = TextMate::UI.request_string( 
      :title => "MavenMate - Profile Manager",
      :prompt => 'Enter a comma delimited list of profiles to activate',
      :default => profiles
    )
    MavenMate.prefs.transaction { MavenMate.prefs[@key] = newprofiles }
  end
  
  def profiles
    MavenMate.prefs.transaction { @profiles = MavenMate.prefs[@key] } if @profiles.nil?
    @profiles
  end
  
  def add_profiles_to_command(command)
    if profiles.nil? or profiles.empty?
      return command
    else  
      return command + ' -P "' + profiles + '"'
    end
  end
  
end

class MavenCommand
  
  attr_reader :stdin, :stdout, :stderr, :pid, :task , :location
    
  def to_s
    return "MavenMate"
  end
  
  def initialize(task)
    
    @task = task
    @previous_args_for_task_pref_key = "#{@location}::#{@task}::previousargs"
    @previous_command_pref_key = "#{@location}::previouscommand"
    @full_command = nil
    
  end
  
  def full_command
    if @full_command.nil?
      prefs = MavenMate.prefs
      previous_args_for_task = prefs.transaction(true) { prefs[@previous_args_for_task_pref_key] }
      args_for_task = TextMate::UI.request_string( 
        :title => (@task.empty? ? "MavenMate" : "MavenMate - #{@task}"),
        :prompt => 'Enter any command options',
        :default => previous_args_for_task
      )
      prefs.transaction { prefs[@previous_args_for_task_pref_key] = args_for_task }
      command = ""
      command += " #{@task}" unless @task.empty?
      command += " #{args_for_task}" unless args_for_task.empty?
      
      profilemanager = MavenProfileManager.new
      command = profilemanager.add_profiles_to_command(command)
      prefs.transaction { prefs[@previous_command_pref_key] = command }
      
      @full_command = command
    end
    return @full_command
  end
  
  def run

    rd, wr = IO.pipe
    rd.fcntl(Fcntl::F_SETFD, 1)
    @stdin, @stdout, @stderr, @pid = my_popen3(MavenMate.mvn + full_command)
    wr.close
    [@stdout, @stderr, rd, @pid]
  end

end

class PreviousMavenCommand < MavenCommand
  def full_command
    @@prefs.transaction { @@prefs[@previous_command_pref_key] }
  end
end

class MavenMate < CommandMate
  
  @@prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.mavenmate"))
  def self.prefs; @@prefs end
  
  @@mvn = ENV["TM_MVN"]
  def self.mvn; @@mvn end
  
  @@location = (ENV["TM_PROJECT_DIRECTORY"] || ENV["TM_DIRECTORY"]).freeze
  def self.location; @@location end
  
  attr_reader :colorisations
  
  def initialize(command, location = nil)
    Dir.chdir(@@location)
    super command
    @colorisations = {
      "green" => [/BUILD SUCCESSFUL/, /Tests run: ([^0]\d*), Failures: 0, Errors: 0/],
      "red" => [/\[ERROR\]/, /Tests run: ([^0]\d*)(.)+(Failures: ([^0]\d*)|Errors: ([^0]\d*)+)/],
      "orange" => [/\[WARNING\]/, /There are no tests to run\./, /Tests run: 0,/],
      "blue" => [/\[INFO\] \[(.)+:(.)+\]/]
    }
  end
  
  def emit_header
    puts html_head(:window_title => "#{@command}", :page_title => "#{@command}", :sub_title => "#{@command.location}")
    puts "<pre>"
    puts "<strong>mvn" + htmlize(@command.full_command) + "</strong><br>\n"
  end
  
  def filter_stdout(line)
    match = false
    @colorisations.each do | color, patterns |
      if match == false and patterns.detect { |pattern| line =~ pattern }
        match = "<span style=\"color: #{color}\">#{htmlize line.chomp}</span><br>"
      end
    end
    match = (htmlize line.chomp) + "<br>" unless match 
    return match
  end
end
