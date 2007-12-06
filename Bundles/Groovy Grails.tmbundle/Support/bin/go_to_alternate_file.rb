#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes an intelligent decision on which file to go to based on the current line or current context.

require 'GrailsPath'
require 'TextMate'

choice = ARGV.shift
current_file = GrailsPath.new

if grails_path = current_file.grails_path_for(choice.to_sym)
  if grails_path.exists?
    TextMate.open grails_path
  else
    if TextMate.message_ok_cancel "#{grails_path.basename} does not exist", "Would you like to create it?"
      grails_path.touch
      TextMate.open grails_path
    else
      TextMate.exit_discard
    end
  end
end