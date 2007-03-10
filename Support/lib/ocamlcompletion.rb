#!/usr/bin/env ruby

require 'fileutils'
require 'pathname'
require 'optparse'
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"



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
    raise "Unable to find #{command}"
  end
  
  
  def OCamlCompletion::read_stdin
    $stdin.read()
  end
  
  
  def OCamlCompletion::read_file(filename)
    File.open(filename,'r').read()
  end
  
  
  def OCamlCompletion::read_open_file
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
  
  
  def OCamlCompletion::searchtype_to_arg searchtype
    case searchtype
      when :all then '-a'
      when :records then '-r'
      when :types then '-t'
      when :constructors then '-c'
      when :modules then '-m'
      when :values then '-v'
      when :exceptions then '-e'
      when :classes then '-o'
      else '-a'
    end
  end
  
  
  def OCamlCompletion::cmigrep(regexstr, searchtype=:all, modules=nil, openmodules=nil, packages=nil)
    if packages.nil?
      packages = all_packages.join(',')
    end
    openmodules = if openmodules then "-open #{openmodules.join(',')}" else "" end
    if modules.nil?
      modules = open_modules
    end
    modules = modules.map { |m| e_sh(m) }
    if ENV['TM_FILEPATH']
      FileUtils.cd(File.dirname(ENV['TM_FILEPATH']))
    end

    command = "#{find_command 'cmigrep'} #{openmodules} -package #{e_sh(packages)} #{searchtype_to_arg(searchtype)} #{e_sh(regexstr)} #{modules.join(' ')}"
    `#{command}`
  end
  
end

