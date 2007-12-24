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
  # elsif tag.name[0] != ?~
  #   # Constructor
  #   parent = tags.class_parent(tag.name) || "Parent"
  #   r << "#$indent\${1:#{tag.name}::}\${1#{class_regexp}}#{signature_to_implementation_signature(tag.signature)}"
  #   r << "#$indent\t: \${2:#{parent}(#{signature_to_arguments(tag.signature)})}"
  # else
  #   # Destructor
  #   r << "#$indent\${1:#{tag.name[1..-1]}::}~\${1#{class_regexp}}()"
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
  # Due to the way TextMate passes strings, if it passed
  # only one string without newline, but thought that it
  # selected the entire line (Input: Selected Text or Line),
  # then it will append additonal newline to the end
  extra_newline = ""
  input.each { |line| extra_newline = "\n" if line.chomp != line }

  print implementation_to_declaration(CTags.parse_data(input)).join("\n").chomp + extra_newline
end
