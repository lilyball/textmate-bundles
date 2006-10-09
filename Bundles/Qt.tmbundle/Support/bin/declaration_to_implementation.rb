#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'

input = $stdin.readlines

$indent = ""
$indent = $1 if input[0] =~ /^(\s+)[^\s]?/

if input.length <= 1 and (input[0].nil? or input[0] =~ /^\s*$/)
  input += `pbpaste`.split("\n")
end

$cpp_mode = TextMate.scope =~ /source\.(c|objc)\+\+/
$doxygen  = ARGV.find { |a| a == "doxygen" }

$doxygen_index = 10
def insert_method(type, name, arguments, is_const)
  r = Array.new
  if $doxygen
    r << "#$indent/*" + TextMate.doxygen_style
    r << "#$indent * \${#{$doxygen_index}:TODO}"
    r << "#$indent */"
    $doxygen_index += 1
  end
  
  if !type.nil?
    type.gsub!(/\s+/, " ")
    type.gsub!(/\s+$/, "")
    
    # this would result in implementations like this:
    # QTextDocument *document() const
    type += " " if type =~ /[^*&]$/

    className = "ClassName"
    className = underscore_to_classname(TextMate.filename) if TextMate.env(:filename)
    className = "\${1:#{className}}::"
    className = "" if !$cpp_mode
    
    r << "#$indent#{type}#{className}#{name}(#{arguments})" + (!is_const.nil? ? " const" : "")
  elsif name[0] != ?~
    # Constructor
    r << "#$indent\${1:#{name}}::\${1}(#{arguments})"
    r << "#$indent\t: \${2:ParentClass()}"
  else
    # Destructor
    r << "#$indent\${1:#{name[1..-1]}}::~\${1}()"
  end
  r << "#$indent{"
  r << "#$indent\t\$0"
  r << "#$indent}"
  r << ""
end

# Due to the way TextMate passes strings, if it passed
# only one string without newline, but thought that it
# selected the entire line (Input: Selected Text or Line),
# then it will append additonal newline to the end
extra_newline = ""

output = Array.new
input.each do |line|
  extra_newline = "\n" if line.chomp != line
  case line
  when /^\s*(?:virtual)?\s*([\w\d_:,<>*\s]+\s+([*&])?)?\s*([~\w\d_]+)\s*\((.*)\)\s*(const)?/
    type = $1
    # type += " " + $2 if !$2.nil?
    method = $3
    arguments = $4
    output += insert_method(type, method, arguments, $5)
  end
end

print output.join("\n").chomp + extra_newline
