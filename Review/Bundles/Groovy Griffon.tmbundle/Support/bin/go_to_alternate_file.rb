#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes an intelligent decision on which file to go to based on the current line or current context.

require 'GriffonPath'
require 'TextMate'

choice = ARGV.shift
current_file = GriffonPath.new

if Griffon_path = current_file.Griffon_path_for(choice.to_sym)
  if Griffon_path.exists?
    TextMate.open Griffon_path
  else
    if TextMate.message_ok_cancel "#{Griffon_path.basename} does not exist", "Would you like to create it?"
      Griffon_path.touch
      TextMate.open Griffon_path
    else
      TextMate.exit_discard
    end
  end
end