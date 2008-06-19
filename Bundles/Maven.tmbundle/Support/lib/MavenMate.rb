#!/usr/bin/env ruby -w

require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/process'
require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'

require "pstore"
require "yaml"
require "shellwords"

$SCRIPTMATE_VERSION = "$Revision: 8136 $"
$VERBOSE = nil

class MavenCommand
  
  @@prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.mavenmate"))
  
  def self.get_pref(key) 
    @@prefs.transaction { @@prefs[key] }
  end
  
  def self.set_pref(key, value) 
    @@prefs.transaction { @@prefs[key] = value }
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

    command << "-P"
    command << p
  end

  attr_reader :location, :colorisations, :tasks
  
  def initialize(mvn, location, *tasks)
    @mvn = mvn
    @location = location
    @tasks = tasks
    @previous_args_pref_key = "#{@location}::#{@tasks}::previousargs"
    @previous_command_pref_key = "#{@location}::previouscommand"
    @colorisations = {
      "green" => [/BUILD SUCCESSFUL/, /Tests run: ([^0]\d*), Failures: 0, Errors: 0/],
      "red" => [/\[ERROR\]/, /Tests run: ([^0]\d*)(.)+(Failures: ([^0]\d*)|Errors: ([^0]\d*)+)/],
      "orange" => [/\[WARNING\]/, /There are no tests to run\./, /Tests run: 0,/],
      "blue" => [/\[INFO\] \[(.)+:(.)+\]/]
    }
  end
  
  def command
    previous_args = self.class.get_pref(@previous_args_pref_key)
    
    args = TextMate::UI.request_string( 
      :title => (@tasks.empty? ? "MavenMate" : "MavenMate - #{@tasks.join(' ')}"),
      :prompt => 'Enter any command options',
      :default => previous_args
    )
    exit if args.nil?
    
    self.class.set_pref(@previous_args_pref_key, args) if args != previous_args

    command = []
    command = command + @tasks unless @tasks.empty?
    command = command + Shellwords.shellwords(args)
  
    self.class.set_pref(@previous_command_pref_key, command.to_yaml)
    self.class.add_profiles_to_command(@location, command)
  end
   
  def run
    Dir.chdir(@location) do 
      TextMate::HTMLOutput.show(:window_title => "MavenMate", :page_title => "MavenMate", :sub_title => "#{location}") do |io|
        cmd = command
        io << "<pre>"
        io << "<strong>mvn " + htmlize(cmd.join(' ')) + "</strong><br/>\n"
        TextMate::Process.run(@mvn, *cmd) do |line, type|
          case type
          when :out
            line.chomp!

            if line =~ /^Running (\S+)/ 
              line = "Running <a href='txmt://open?url=file://#{@location}/target/surefire-reports/#{$1}.txt'>#{$1}</a>"
            else
              line = htmlize(line)
            end

            match = false
            @colorisations.each do | color, patterns |
              if match == false and patterns.detect { |pattern| line =~ pattern }
                match = "<span style=\"color: #{color}\">#{line}</span><br>"
              end
            end
            match = "<span>#{line}</span><br>" unless match 
            io << match
          when :err
            io << "<span style='color: red'>#{htmlize(line).gsub(/\<br\>/, "<br>\n")}</span>"
          end
        end
        io << "</pre>"
      end
    end
  end
  
end

class PreviousMavenCommand < MavenCommand
  def initialize(mvn, location)
    super(mvn, location)
  end
  
  def command
    command = YAML::load(self.class.get_pref(@previous_command_pref_key))
    self.class.add_profiles_to_command(@location, command)
  end
end

class MavenFocusedTestCommand < MavenCommand
  def initialize(mvn, location, test)
    super(mvn, location, ['test', '-Dtest=' + test.sub(/\.\w+$/, '')])
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
  MavenCommand.set_profiles(location)
  exit
end
opts.on("-t", "--task [TASK]", "Execute task") do |t|
  if t.nil?
    command = MavenCommand.new(mvn, location)
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

command.run