#!/usr/bin/env ruby

require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "GrailsMate"

gm = GrailsMate.new("") do |default|
  TextMate::UI.request_string( 
    :title => "Run Grails Task",
    :prompt => "Enter a command to pass to grails",
    :default => default
  )
end

gm.run