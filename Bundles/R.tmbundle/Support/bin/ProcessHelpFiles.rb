#!/usr/bin/ruby
require 'pp'
Dir.chdir("/Library/Frameworks/R.framework/Versions/Current/Resources/library")
resources = Dir.glob("*/latex/*.tex")
# puts resources
results = ""
resources.each do |file|
  tex = File.read(file)
  terms = tex.scan(/\\begin\{verbatim\}\n(.*)\\end\{verbatim\}/m)
#.split(/\n+(?=[\w.]+\()/)
  results << terms[0][0] unless terms.empty?
  #.map{|line| line.gsub(/\n|(  )/,"")}
end
results.gsub!(/^(?:(?:[#!\(\{]|(?:[\w.]+[\$\[\s]+)).*|[\w.:]+|\"[\w.]*\".*|.*value|)\n/,"")
results.gsub!(/^\s+/,"")
results.gsub!(/\n(?![\w.]+\()/," ")
puts results.split("\n").sort.uniq.join("\n")
