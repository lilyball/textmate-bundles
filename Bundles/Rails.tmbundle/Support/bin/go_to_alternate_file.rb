#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes an intelligent decision on which file to go to based on the current line or current context.

require 'rails_bundle_tools'


current_file = RailsPath.new
choice = ARGV.shift

if current_file.send("associated_with_#{choice}?")
  if rails_path = current_file.rails_path_for(choice.to_sym)
    TextMate.open rails_path
  end
else
  TextMate.message "#{current_file.basename} does not have a #{choice}"
end

