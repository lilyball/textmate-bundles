#!/usr/bin/env ruby
# encoding: utf-8

require 'strscan'

input = STDIN.read.gsub(/([\$\`\\])/, '\\\\\1')
output = String.new
counter = 1
scanner = StringScanner.new(input)
while scanner.scan(/(.*?)‹(.*?)›/m)
  prefix, contents = scanner[1], scanner[2]
  output << prefix + "$#{counter+=1}${1:#{contents}}"
end
output << "$0" if counter > 1
output << input[(scanner.pos rescue 0)..-1]

print output