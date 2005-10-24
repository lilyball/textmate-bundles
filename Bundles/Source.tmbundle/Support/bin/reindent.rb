#!/usr/bin/env ruby

#
# ReIndent v0.1
# By Sune Foldager <cryo at cyanite.org>
#

require 'optparse'

# Defaults.
increase = nil
decrease = nil
line_indent = nil
indent = nil
use_tabs = false

opts = OptionParser.new do |o|

  # Increase indent pattern.
  o.on("-i", "--increase [PATTERN]", Regexp,
  "Regex pattern to increase the indentation level.") { |p|
    increase = p
  }

  # Decrease indent pattern.
  o.on("-d", "--decrease [PATTERN]", Regexp,
  "Regex pattern to decrease the indentation level.") { |p|
    decrease = p
  }

  # Indent size.
  o.on("-I", "--indent-size [SIZE]", Integer,
  "Indentation ammount. Defaults to 2 for spaces, 1 for tabs.") { |i|
    indent = i
  }

  # Use tabs instead of spaces.
  o.on("-t", "--[no-]tabs",
  "Use tabs instead of spaces, for indent. Defaults to using spaces.") { |t|
    use_tabs = t
  }

  # Next-line indent pattern.
  o.on("-n", "--next-line [PATTERN]", Regexp,
  "Regex pattern to increase the indentation level for the next line only.") { |p|
    line_indent = p
  }

  # Help.
  o.on_tail("-h", "--help", "Show this message.") {
    puts o
    exit
  }

  # Parse!
  begin
    o.parse!(ARGV)
  rescue OptionParser::ParseError => e
    puts e.message
    puts o
    exit
  rescue RegexpError => e
    print "ERROR: "
    puts e.message
    exit
  end

end

# Perform re-indentation.
level = 0
extra = 0
indent = (use_tabs ? 1 : 2) unless indent
space = (use_tabs ? "\t" : " ") * indent
while l = gets

  # remove leading whitespace
  l = l.lstrip

  # Handle de-indentation.
  if decrease and l =~ decrease
    level -= 1 unless level == 0
  end

  # Indent and output.
  print space * (level+extra) if level+extra > 0
  print l

  # Handle indentation.
  if increase and l =~ increase
    level += 1
  end
  extra = 0
  if line_indent and l =~ line_indent
    extra = 1
  end

end

