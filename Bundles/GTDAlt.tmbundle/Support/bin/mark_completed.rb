#!/usr/bin/env ruby
#
require 'Date'
name, file, line = ARGV
f = File.open(file)
data = f.readlines
f.close
line = line.to_i
raise "Did not find a matching action with name #{name} in file: #{file} and line: #{line}." unless data[line-1].index(name)
l = data[line-1]
# This code will actually un-complete a completed action
if l =~ /^(#completed:)(\[\d{4}-\d{2}-\d{2}\])(.*\n?)/ then
	data[line-1] = $3
elsif l =~ /^\s*@/
  data[line-1] = "#completed:[#{Date.today}]#{l}"
else
  raise "Not an action line."
end
f = File.open(file, 'w')
f.write data
f.close
