#!/usr/bin/env ruby
# Replace all of the occurrences of the selected color with the chosen color in the current document.
# Thomas Aylott -- subtleGradient.com

require ENV['TM_SUPPORT_PATH'] + "/lib/ui"

FILENAME = ENV['TM_FILEPATH']
VALID_COLOR = /^#?[0-9a-f]{3,6}$/i
VALID_COLOR_SHORT = /^#?([0-9a-f])([0-9a-f])([0-9a-f])$/i

def normalize_color(color='#ccc')
  return color if color.match(VALID_COLOR) and color.length == 7
  if color.match(VALID_COLOR_SHORT)
    return ('#'+$1+$1+$2+$2+$3+$3).upcase
  end
  return false
end

def error!
  print 'No changes made'
  abort
end

@original_color = STDIN.read.chomp #ENV['TM_SELECTED_TEXT']
unless @original_color and @original_color.match(VALID_COLOR)
  print 'You need to select a HEX color to use this command'
  abort
end

@replaced_color = TextMate::UI.request_color(@original_color)
error! if @replaced_color.nil?

norm = normalize_color(@replaced_color)
error! unless norm
@replaced_color = norm

@replaced_color = TextMate::UI.request_string(
  :title => "#{ENV['TM_FILENAME']}: Replace Color", 
  :default => @replaced_color,
  :prompt => "Replace #@original_color with: this",
  :button1 => 'Replace All'
)

error! if !@replaced_color
error! if @replaced_color == @original_color
error! if @replaced_color.length < 7
error! if !@replaced_color.match(VALID_COLOR)

lines = File.readlines(FILENAME)
File.open(FILENAME, 'w') { |file| 
  lines.each do |line|
    line.gsub!(/#@original_color\b/, @replaced_color)
    file.write(line)
  end
  file.close
}

`osascript -e 'tell the application "finder" to activate' -e 'tell the application "textmate" to activate'`
print "Replaced every occurrence \n of #@original_color with #@replaced_color \n in #{ENV['TM_FILENAME']}"
