#!/usr/bin/ruby
#
# Program to check and fix nested blocks.
# By Sune Foldager, 2005.
#
# USAGE: checknest <open tag> <close tag> <close text> [options]
#
# -n<num>:  Evaluate nesting at the line number given. Otherwise at EOF.
# -l<num>:  Consider up to the given number of open blocks.
#           Defaults to 1. Set to -1 to consider all.
# -e<text>: If a spurious close-tag is encoutered, substitute line with this.
# -p:       Pass file thru, don't just output the close text.
#
# <close text> and -e<text> can use $n to substitute tag captures.
#


# Collect necessary arguments.
if ARGV.size < 3
  puts 'USAGE: checknest <open tag> <close tag> <close text> [options]'
  exit
end
begin
  open_match = Regexp.new ARGV[0]
  close_match = Regexp.new ARGV[1]
  close_text = ARGV[2]
rescue
  puts 'ERROR: Ill-formed regex in open or close tag.'
  exit 1
end

# Collect options.
num = nil
levels = 1
error_text = nil
pass = false
ARGV[3..-1].each {|e|
  case e
  when /^-n(\d+)$/: num = $1.to_i
  when /^-l(\d+)$/: levels = $1.to_i
  when /^-e(.+)$/: error_text = $1
  when /^-p$/: pass = true
  end
}

# Do the nesting thang.
stack = []
line = 1
while (!num or line<num) and s = $stdin.gets
  dumped = false
	if s =~ open_match
		stack.push $~.to_a
	elsif s =~ close_match
    e = $~.to_a
    if e[1..-1] == stack[-1][1..-1]
		  stack.pop
    elsif error_text
      print error_text.gsub(/\$(\d)/) {e[$1.to_i]}
      dumped = true
    end
  end
	line += 1
  print s if pass and not dumped
end

# Insert correct closers.
while levels > 0 and e = stack.pop
	puts close_text.gsub(/\$(\d)/) {e[$1.to_i]}
  levels -= 1
end

# Dump rest of file, if requested.
if pass and s = $stdin.gets(nil)
  print s
end

