#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'optparse'




module OCamlCompletion
    
  def OCamlCompletion::find_command command
    locations = [
        '/bin',
        '/usr/bin',
        '/usr/local/bin',
        '/opt/local/bin',
        '/opt/local/godi/bin',
        '/usr/local/godi/bin',
        '/godi/bin'
      ].map { |p| Pathname.new p }
    locations.each do |l|
      if (l + command).exist? then return l + command end
    end
  end
  
  
  def OCamlCompletion::read_stdin
    $stdin.read()
  end
  
  
  def OCamlCompletion::read_file(filename)
    File.open(filename,'r').read()
  end
  
  
  def OCamlCompletion::read_open_file
    FileUtils.cd(File.dirname(ENV['TM_FILEPATH']))
    read_file ENV['TM_FILEPATH']
  end


  def OCamlCompletion::open_modules(filecontents = '')
    openmodules = filecontents.scan(/\bopen\s+(([A-Z][a-zA-Z0-9_-]+)(\.[A-Z][a-zA-Z0-9_-]+)*)/).map { |arr| arr[0] }
    if ENV['TM_FILEPATH']
      openmodules << File.basename(ENV['TM_FILEPATH'])[/(.*)\.ml/,1].capitalize
    end
    
    openmodules
  end


  def OCamlCompletion::all_packages
    `#{find_command 'ocamlfind'} list`.scan(/^\S+/)
  end
  
  
  def OCamlCompletion::current_word
    if ENV['TM_CURRENT_WORD']
      Regexp.escape(ENV['TM_CURRENT_WORD'].to_s)
    else
      ''
    end
  end
  
  
  def OCamlCompletion::cmigrep(regexstr, packages=[], modules=[])
    completions = modules.map { |modname|
      `#{find_command 'cmigrep'} -package '#{packages}' -r '#{regexstr}' #{modname}`.split(/\n/) 
    }.flatten.select { |s| s =~ /\(\*/ }.map { |s| s[/^(?:mutable )?([^:]+)/,1] }.sort.uniq
    completions.join("\n")
  end
  
end

