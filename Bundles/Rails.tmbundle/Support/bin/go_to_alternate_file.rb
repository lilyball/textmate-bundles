#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Makes an intelligent decision on which file to go to based on the current line or current context.

require 'rails_bundle_tools'


current_file = RailsPath.new

if ARGV.empty?
  # Best match
  choice = 
    case current_file.file_type
    when :controller
      if current_file.action_name
        :view
      else
        if current_file.rails_path_for(:functional_test).exists?
          :functional_test
        elsif current_file.rails_path_for(:helper).exists?
          :helper
        end
      end
    else
      current_file.associations[current_file.file_type].first
    end
else
  choice = ARGV.shift
end

if rails_path = current_file.rails_path_for(choice.to_sym)
  TextMate.open rails_path
else
  puts "#{current_file.basename} does not have a #{choice}"
end
