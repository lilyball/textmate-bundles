#!/usr/bin/env ruby
# Replace all of the occurances of the selected color with the chosen color in the current document.
# Thomas Aylott -- subtleGradient.com

require ENV['TM_SUPPORT_PATH'] + "/lib/dialog"

filename       = ENV['TM_FILEPATH']
valid_color    = /^#?[0-9a-f]{3,6}$/i

original_color = STDIN.read.chomp #ENV['TM_SELECTED_TEXT']
unless original_color and original_color.match(valid_color)
  print 'You need to select a HEX color to use this command'
  abort
end

replaced_color = Dialog.request_color(original_color)
unless replaced_color and replaced_color.match(valid_color)
  print 'No changes made'
  abort
end

lines = File.readlines(filename)
File.open(filename, 'w') { |file| 
  lines.each do |line|
    line.gsub!(original_color, replaced_color)
  	file.write(line)
  end
  file.close
}

`osascript -e 'tell the application "finder" to activate' -e 'tell the application "textmate" to activate'`
print "Replaced every occurance \n of #{original_color} with #{replaced_color} \n in #{ENV['TM_FILENAME']}"
