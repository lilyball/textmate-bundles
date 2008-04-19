#!/usr/bin/env ruby -w

require ENV["TM_SUPPORT_PATH"] + "/lib/scriptmate"
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

require "pstore"

$SCRIPTMATE_VERSION = "$Revision: 8136 $"
$VERBOSE = nil

class MavenCommand
  
  attr_reader :location
  
  def initialize(mvn, location, task)
    @mvn = mvn
    @task = task
    @location = location
    @command = nil
    @previous_args_pref_key = "#{@location}::#{@task}::previousargs"
    @previous_command_pref_key = "#{@location}::previouscommand"
  end
  
  def to_s
    command
  end
  
  def command
    if @command.nil?
      previous_args_for_task = MavenMate.get_pref(@previous_args_pref_key)
      
      args_for_task = TextMate::UI.request_string( 
        :title => (@task.empty? ? "MavenMate" : "MavenMate - #{@task}"),
        :prompt => 'Enter any command options',
        :default => previous_args_for_task
      )
      exit if args_for_task.nil?
      
      MavenMate.set_pref(@previous_args_pref_key, args_for_task) if args_for_task != previous_args_for_task

      @command = ""
      @command += "#{@task}" unless @task.empty?
      
      unless args_for_task.empty?
        @command += " " unless @command.empty?
        @command += "#{args_for_task}"
      end
      MavenMate.set_pref(@previous_command_pref_key, @command)
      @command = MavenMate.add_profiles_to_command(@location, @command)
    end
    @command
  end
  
  def full_command
    @mvn + " " + command
  end
  
  def run
    Dir.chdir(@location)
    rd, wr = IO.pipe
    rd.fcntl(Fcntl::F_SETFD, 1)
    stdin, stdout, stderr, pid = my_popen3(full_command)
    wr.close
    [stdout, stderr, rd, pid]
  end
  
  def html
    mavenmate = MavenMate.new(self)
    mavenmate.emit_html
    mavenmate
  end
  
  def shell
    mavenmate = MavenMate.new(self)
    mavenmate.shell
    mavenmate    
  end
  
end

class PreviousMavenCommand < MavenCommand
  def initialize(mvn, location)
    super(mvn, location, '')
  end
  
  def command
    if @command.nil?
      @command = MavenMate.get_pref(@previous_command_pref_key)
      @command = MavenMate.add_profiles_to_command(@location, @command)
    end
    @command
  end
end

class MavenFocusedTestCommand < MavenCommand
  def initialize(mvn, location, test)
    super(mvn, location, 'test -Dtest=' + test.sub(/\.\w+$/, ''))
  end
end

class MavenMate < CommandMate
  
  @@prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.mavenmate"))
  def self.get_pref(key) 
    @@prefs.transaction { @@prefs[key] }
  end
  def self.set_pref(key, value) 
    @@prefs.transaction { @@prefs[key] = value }
  end

  attr_reader :colorisations, :command
    
  def initialize(command) 
    super(command)
    setup_default_colorisations
  end

  def setup_default_colorisations
    @colorisations = {
      "green" => [/BUILD SUCCESSFUL/, /Tests run: ([^0]\d*), Failures: 0, Errors: 0/],
      "red" => [/\[ERROR\]/, /Tests run: ([^0]\d*)(.)+(Failures: ([^0]\d*)|Errors: ([^0]\d*)+)/],
      "orange" => [/\[WARNING\]/, /There are no tests to run\./, /Tests run: 0,/],
      "blue" => [/\[INFO\] \[(.)+:(.)+\]/]
    }
  end
  
  def build_command(task, location)
    
    MavenCommand(@command, @location)
  end
  
  def emit_header
    puts html_head(:window_title => "MavenMate", :page_title => "MavenMate", :sub_title => "#{@command.location}")
    puts "<pre>"
    puts "<strong>mvn " + htmlize(@command.command) + "</strong><br>\n"
  end
  
  def filter_stdout(line)
    line.chomp!
    
    if line =~ /^Running (\S+)/ 
      line = "Running <a href='txmt://open?url=file://#{command.location}/target/surefire-reports/#{$1}.txt'>#{$1}</a>"
    else
      line = htmlize(line)
    end
    
    match = false
    @colorisations.each do | color, patterns |
      if match == false and patterns.detect { |pattern| line =~ pattern }
        match = "<span style=\"color: #{color}\">#{line}</span><br>"
      end
    end
    match = (line) + "<br>" unless match 
    return match
  end
  
  def self.profiles_pref_key(location)
    "#{location}::profiles"
  end
  
  def self.set_profiles(location)
    newprofiles = TextMate::UI.request_string( 
      :title => "MavenMate - Profile Manager",
      :prompt => 'Enter a comma delimited list of profiles to activate',
      :default => profiles(location),
      :button2 => "Clear"
    )
    if newprofiles.nil?
      puts "Profiles cleared"
    else
      puts "Profiles: #{newprofiles}"
    end
    set_pref(profiles_pref_key(location), newprofiles)
  end
  
  def self.profiles(location)
    get_pref(profiles_pref_key(location))
  end
  
  def self.add_profiles_to_command(location, command)
    p = profiles(location)
    return command if p.nil? or p.empty?
      
    command += " " unless command.empty?
    command += "-P #{p}"
    command
  end
  
  def shell
    system "osascript -e 'tell application \"Terminal\"\n do script \"cd #{@command.location}; clear; echo #{@command.full_command}; echo;  #{@command.full_command}\"\n activate\n end tell'"
  end
  
end

# =========================
# = Parse Args and invoke =
# =========================

require 'optparse' 

use_shell = false
command = nil
mvn = nil
location = nil

opts = OptionParser.new
opts.on("-l", "--location LOCATION", "Project location") do |l|
  location = l
end
opts.on("-m", "--mvn MVN", "MVN Binary") do |m|
  mvn = m
end
opts.on("-P", "--profiles", "Set the profiles") do
  raise "Location (-l) not set" if location.nil?
  MavenMate.set_profiles(location)
  exit
end
opts.on("-t", "--task [TASK]", "Execute task") do |t|
  if t.nil?
    command = MavenCommand.new(mvn, location, '')
  else
    command = MavenCommand.new(mvn, location, t)
  end
end
opts.on("-p", "--previous", "Reexecute previous command") do |p|
  command = PreviousMavenCommand.new(mvn, location)
end
opts.on("-f TEST", "Run a focussed test") do |t|
  command = MavenFocusedTestCommand.new(mvn, location, t)
end

opts.parse!(ARGV)

raise "Missing -p or -t arguments" if command.nil?
raise "Missing -l" if location.nil?
raise "Missing -m" if mvn.nil?

command.html