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
$doxygen  = ARGV.find { |a| a == "doxygen" }

input = input.map do |line|
  line.gsub!(/^\s+/, "")
  line.gsub!(/\b(virtual|static)\b\s*/, "")
  line.gsub!(/(=\s*0)?;/, "{}")
  # line.gsub!(/$/, "{}")
end.join("\n")

$doxygen_index = 10
def print_function(tags, tag)
  r = []
  if $doxygen
    r << "#$indent/*" + TextMate.doxygen_style
    r << "#$indent * \${#{$doxygen_index}:TODO}"
    r << "#$indent */"
    $doxygen_index += 1
  end

  class_regexp = "/([\\w\\d_]+::)*([\\w\\d_]+)::/$2/"

  if !tag.result_type.nil?
    t = closest_tag(tags.tags, TextMate.line_number)
    klass = t ? t.klass : nil
    class_name = "Class"
    class_name = underscore_to_classname(TextMate.filename) if TextMate.env(:filename)
    class_name = !klass.nil? ? klass : class_name
    class_name = "\${1:#{class_name}::}"
    class_name = "" if !$cpp_mode

    r << "#$indent#{tag.result_type}#{class_name}#{tag.name}#{signature_to_implementation_signature(tag.signature)}"
  elsif tag.name[0] != ?~
    # Constructor
    parent = tags.class_parent(tag.name) || "Parent"
    r << "#$indent\${1:#{tag.name}::}\${1#{class_regexp}}#{signature_to_implementation_signature(tag.signature)}"
    r << "#$indent\t: \${2:#{parent}(#{signature_to_arguments(tag.signature)})}"
  else
    # Destructor
    r << "#$indent\${1:#{tag.name[1..-1]}::}~\${1#{class_regexp}}()"
  end
  r << "#$indent{"
  r << "#$indent\t\$0"
  r << "#$indent}"
  r << ""
  return r
end

def declaration_to_implementation(tags)
  global_tags = CTags.run
  r = []
  functions = []
  tags.functions.each_value do |f|
    f.each { |t| functions << t }
  end
  functions.sort! { |a, b| a.line <=> b.line }
  functions.each do |e|
    r += print_function(global_tags, e)
  end
  return r
end

if __FILE__ == $0
  process_ctags_function(input) do |inp|
    declaration_to_implementation(inp)
  end
end
