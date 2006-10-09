#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'

# TODO: 
# 1. Build list of all class declarations
# 2. If file's saved on disk, look for corresponding .h-file
#    and parse it for classes as well
def insert_super(lines)
  klass = "QWidget"
  method = "methodName"
  arguments = ""

  lines.each_with_index do |line, index|
    case line
    when /^\s*(?:class|struct)\s+(?:[\w\d_]+)\s*:\s*(?:public|private|protected)\s+([\w\d_]+)/
      klass = $1
    when /^\s*([\w\d_:*&]+)\s+(?:[*&])?\s*(?:[\w\d_]+::)?([\w\d_]+)\s*\((.+)\)/
      next if $1 == "return"
      method = $2
      arguments = $3
      if !arguments.empty?
        index = 2 # first argument will get index 3
        arguments = arguments.split(",").map do |a|
           index += 1
           "\${#{index}:#{$1}}" if a =~ /([\w\d_]+)$/
        end.join(", ")
      end
    end
  
    if index == TextMate.line_number
      return "\${1:#{klass}}::\${2:#{method}}(#{arguments})"
    end
  end
end

if __FILE__ == $0
  print insert_super($stdin.readlines)
end