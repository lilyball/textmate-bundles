#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/ctags'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/common'

def closest_function_tag(tags, line_number)
  functions = []
  tags.functions.each_value do |f|
    f.each do |t|
      next if !t.path.nil?
      functions << t
    end
  end
  return closest_tag(functions, line_number)
end

def parse_signature(signature)
  args = signature_to_arguments(signature)

  index = 2 # first argument will get index 3
  args.split(",").map do |a|
    index += 1
    "\${#{index}:#{a.strip}}"
  end.join(", ")
end

def insert_super(tags)
  tag = closest_function_tag(tags, TextMate.line_number)
  klass = tags.class_parent(tag ? tag.klass : nil) || "Class"
  method = tag ? tag.name : nil || "method"
  signature = tag ? tag.signature : nil || "()"
  signature = parse_signature(signature)
  return "\${1:#{klass}::}\${2:#{method}}(#{signature})"
end

if __FILE__ == $0
  print insert_super(CTags.run)
end
