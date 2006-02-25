#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Asks what to generate and what name to use, then runs script/generate.

require 'rails_bundle_tools'
require 'fileutils'

def locomotive?
  File.directory? "/Applications/Locomotive"
end

# Look for (created) files and return an array of them
def files_from_generator_output(output, type = 'create')
  output.to_a.map { |line| line.scan(/#{type}\s+([^\s]+)$/).flatten.first }.compact
end

def ruby_in_locomotive_environment(command)
  locomotive_root = "/Applications/Locomotive"
  bundle_root = locomotive_root + "/Bundles"
  bundle = Dir.glob bundle_root + '/rails*max*'
  bundle = Dir.glob bundle_root + '/rails*min*' if bundle.empty?

  rubylibs =
    ["#{bundle}/Contents/Resources/ports/lib/ruby/site_ruby/1.8",
     "#{bundle}/Contents/Resources/ports/lib/ruby/site_ruby/1.8/powerpc-darwin7.9.0",
     "#{bundle}/Contents/Resources/ports/lib/ruby/1.8",
     "#{bundle}/Contents/Resources/ports/lib/ruby/1.8/powerpc-darwin7.9.0"]

  command_in_environment =
    "PATH=\"#{bundle}/Contents/Resources/ports/bin:#{ENV['PATH']}\";" +
    "DYLD_FALLBACK_LIBRARY_PATH=\"#{bundle}/Contents/Resources/ports/lib\";" +
    "/usr/bin/env ruby #{rubylibs.map{|r| "\"-I" + r + "\"" }.join(' ')} #{command}"
  
  # $logger.debug "Command: #{command_in_environment}"
  `#{command_in_environment}`
end

def ruby(command)
  `/usr/bin/env ruby #{command}`
end

class Generator
  @@list = []
  attr_accessor :name, :question, :default_answer
  
  def initialize(name, question, default_answer = "")
    @@list << self
    @name, @question, @default_answer = name, question, default_answer
  end
  
  def self.[](name, question, default_answer = "")
    g = new(name, question, default_answer)
  end

  # Collect the names from each generator
  def self.names
    @@list.map { |g| g.name.capitalize }
  end
end

generators = [
  Generator["scaffold",   "Name of the model to scaffold:", "User"],
  Generator["controller", "Name the new controller:",       "admin/user_accounts"],
  Generator["model",      "Name the new model:",            "User"],
  Generator["mailer",     "Name the new mailer:",           "Notify"],
  Generator["migration",  "Name the new migration:",        "CreateUserTable"],
  Generator["plugin",     "Name the new plugin:",           "ActsAsPlugin"]
]

if choice = TextMate.choose("Generate:", Generator.names, :title => "Rails Generator")
  $logger.warn "1"
  name =
    TextMate.input(
      generators[choice].question, generators[choice].default_answer,
      :title => "#{generators[choice].name.capitalize} Generator")
  $logger.warn "2"
  if name
    options = ""
    
    $logger.warn "3"
    case choice
    when 0
      options = TextMate.input("Name the new controller for the scaffold:", "", :title => "Scaffold Controller Name")
      options = "'#{options}'"
    when 1
      options = TextMate.input("List any actions you would like created for the controller:",
        "index new create edit update destroy", :title => "Controller Actions")
    end

    rails_root = RailsPath.new.rails_root
    FileUtils.cd rails_root
    command = "\"script/generate\" #{generators[choice].name} #{name} #{options}"
    
    output = (locomotive?) ? ruby_in_locomotive_environment(command) : ruby(command)
    $logger.warn "Output from command #{command}: #{output}"
    TextMate.refresh_project_drawer
    files = files_from_generator_output(output)
    files.each { |f| TextMate.open(File.join(rails_root, f)) }
    TextMate.message("Done generating #{generators[choice].downcase}", :title => "Done")
  end
end
