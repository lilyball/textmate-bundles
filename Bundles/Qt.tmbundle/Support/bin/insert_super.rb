#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/ctags'

def closest_tag(tags, line_number)
  tag = nil
  tags.each_value do |functions|
    functions.each do |t|
      next if (line_number - t.line) < 0
      next if !ENV['TM_FILEPATH'].nil? && t.path != ENV['TM_FILEPATH']
      tag = t if tag.nil? || (line_number - t.line) < (line_number - tag.line)
    end
  end
  return tag
end

def parse_signature(signature)
  if signature =~ /\((.+)\)/
    index = 2 # first argument will get index 3
    signature = $1
    signature.split(",").map do |a|
      index += 1
      "\${#{index}:#{$1}}" if a =~ /([\w\d_]+)$/
    end.join(", ")
  else
    ""
  end
end

def insert_super(tags)
  tag = closest_tag(tags.functions, TextMate.line_number)
  klass = tags.class_parent(tag ? tag.klass : nil) || "Class"
  method = tag ? tag.name : nil || "method"
  signature = tag ? tag.signature : nil || "()"
  signature = parse_signature(signature)
  return "\${1:#{klass}}::\${2:#{method}}(#{signature})"
end

if __FILE__ == $0
  begin
    print insert_super(CTags.run)
  rescue Exception => e
    p e.backtrace
  end
end
