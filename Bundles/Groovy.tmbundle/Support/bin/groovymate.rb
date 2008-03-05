#!/usr/bin/env ruby

require ENV["TM_SUPPORT_PATH"] + "/lib/scriptmate"
require ENV['TM_SUPPORT_PATH'] + '/lib/io'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/tm_dialog_read'

require 'tempfile'

TextMate::IO.sync = true

class GroovyScript < UserScript
  
  def initialize(content) 
    unless ENV.has_key? 'TM_FILEPATH'
      f = Tempfile.new("groovy")
      ENV['TM_FILEPATH'] = f.path
    end
    super(content)
  end
  
  def executable
    return "groovy"
    # ENV['TM_GROOVY']
  end
  
  def run
    TextMate::DialogRead.init :title => 'GroovyMate', :prompt => "The script is requesting some input:"
    super
  end
  def lang
    "groovy"
  end
  
end

ScriptMate.new(GroovyScript.new(STDIN.read)).emit_html