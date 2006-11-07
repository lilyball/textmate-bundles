#!/usr/bin/env ruby

def invert_color(color)
  return '' unless color
  color.gsub!(/^#/, '')
  color.gsub!(/(.)(.)(.)/,'\1\1\2\2\3\3') if color.length == 3
  
  color.gsub!(/(..)(..)(..)/) { invert($1) + invert($2) + invert($3) }
  "##{color}"
end

def invert(color)
  color = sprintf("%X", (- color.hex + 255))
  color = "0#{color}" if color.length == 1
  color
end

doc = STDIN.read

# TEST

# doc = %{
# #FFF
# #964
# #37f
# 
# #CC8800
# 
# #FFFC80
# #FFFFFF
# #CCCCCC
# #123123
# #00807C
# #CDCDCD
# 
# #006580 1A   #0065801A
# #00807C 4D   #00807C4D
# #050505 FA   #050505FA
# #666666 33   #66666633
# }

print doc.gsub(/#([0-9a-fA-F]{3,6})([0-9a-fA-F]{2})?\b/) { |c| 
  before = $1 || ''
  after  = $2 || ''
  invert_color(before) + after
}
