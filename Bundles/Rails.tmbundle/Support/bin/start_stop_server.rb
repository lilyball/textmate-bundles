#!/usr/bin/env ruby

require 'rails_bundle_tools'

$logger.debug "start"
Dir.chdir(RailsPath.new.rails_root) do
  output = `ruby script/server`
  
  if output =~ /application started/m
    TextMate.message("Server started.")
  else
    TextMate.message("Couldn't start server.")
  end
  $logger.debug output
end
$logger.debug "stop"

