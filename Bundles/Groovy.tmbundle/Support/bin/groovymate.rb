#!/usr/bin/env ruby

require ENV["TM_SUPPORT_PATH"] + "/lib/scriptmate"
require ENV['TM_SUPPORT_PATH'] + '/lib/io'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require "pstore"
require 'tempfile'

TextMate::IO.sync = true

class GroovyScript < UserScript

  def initialize(content) 
    @prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.groovymate"))  
    unless ENV.has_key? 'TM_FILEPATH'
      f = Tempfile.new("groovy")
      ENV['TM_FILEPATH'] = f.path
    end
    super(content)
  end
  
  def getp(key)
    @prefs.transaction { @prefs[key] }
  end
  def setp(key,value)
    @prefs.transaction { @prefs[key] = value }
  end
  
  def executable
    ENV['TM_GROOVY']
  end
  
  def filter_cmd(cmd)
    if ENV.include? 'TM_GROOVYMATE_GET_ARGS'
      prev_args = getp("prev_args")
      args = TextMate::UI.request_string(:title => "GroovyMate", :prompt => "Enter any command line options:", :default => prev_args)
      setp("prev_args", args)
      cmd << args
    end
    return cmd
  end
  
  def lang
    "groovy"
  end
  
  
end

class GroovyMate < ScriptMate
  def filter_stdout(l)
    return "<span>#{htmlize l}</span>".gsub("\n", "<br>\n")
  end
end

GroovyMate.new(GroovyScript.new(STDIN.read)).emit_html