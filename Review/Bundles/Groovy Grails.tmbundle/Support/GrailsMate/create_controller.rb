#!/usr/bin/env ruby

require "#{ENV["TM_SUPPORT_PATH"]}/lib/dialog"
require "GrailsMate"

gm = GrailsMate.new("create-controller") do |default|
  Dialog.request_string( 
    :title => "Create Controller",
    :prompt => "Enter the controller name",
    :default => ""
  )
end

gm.green_patterns << /Created (\w)+ for (\w)+/
gm.run