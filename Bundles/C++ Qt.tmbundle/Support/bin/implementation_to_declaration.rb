#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/ctags'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/common'

input = $stdin.readlines

$indent = ""
$indent = $1 if input[0] =~ /^(\s+)[^\s]?/

if input.length <= 1 and (input[0].nil? or input[0] =~ /^\s*$/)
  input += `pbpaste`.split("\n")
end

$cpp_mode = TextMate.scope =~ /source\.(c|objc)\+\+/

input = input.map do |line|
  line
end.join("\n")

def print_function(tag)
  r = []

  if !tag.result_type.nil?
    r << "#$indent#{tag.result_type}#{tag.name}#{signature_to_implementation_signature(tag.signature)};"
  end
  return r
end

def implementation_to_declaration(tags)
  r = []
  functions = []
  tags.functions.each_value do |f|
    f.each { |t| functions << t }
  end
  functions.sort! { |a, b| a.line <=> b.line }
  functions.each do |e|
    r += print_function(e)
  end
  return r
end

if __FILE__ == $0
  process_ctags_function(input) do |inp|
    implementation_to_declaration(inp)
  end
end
