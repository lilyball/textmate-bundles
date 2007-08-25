#! /usr/bin/env ruby
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/rails_bundle_tools'

# TODO: camel-case the file name. So 'foo_bar.h' would name the class as 'FooBar'

q_object = ARGV.find { |a| a == "q_object" }

if q_object
  input = $stdin.readlines
  input.insert(1, "\tQ_OBJECT")

  found_include = false
  include_file = nil
  # add #include "file_name.moc"
  file_name = ENV['TM_FILEPATH'].split("/").last if ENV['TM_FILEPATH']
  if !file_name.nil? and file_name.split(".").last == "cpp"
    moc_file = file_name.gsub(/\.cpp$/, ".moc")
    include_file = "\#include \"#{moc_file}\""
  else
    include_file = ""
  end

  curly_brackets = 0
  output = Array.new
  input.each_with_index do |line, index|
    line.gsub("{") { curly_brackets += 1 }
    line.gsub("}") { curly_brackets -= 1 }
    if curly_brackets == 0
      curly_brackets = 666
      output[index-1] = "\${0:#{output[index-1]}}"
    end
    
    found_include = true if line =~ /#{Regexp.quote(include_file)}/
    line.gsub!("[press tab twice to generate Q_OBJECT]", "")
    output << line.chomp
  end
  
  output << "" << include_file << "" if !found_include
  
  print output.join("\n")
  exit 0
end

doxygen = ARGV.find { |a| a == "doxygen" }

r = Array.new
if doxygen
  r << "/*" + TextMate.doxygen_style
  r << " * \\class \${1}"
  r << " * \\brief "
  r << " */"
end

r << "class \${1:ClassName} : public \${2:QObject}"
r << "{"
r << "public:"
r << "	\${1}(\${3:QObject *parent = 0});"
r << "	~\${1}();"
r << ""
r << "private:"
r << "};\${9: [press tab twice to generate Q_OBJECT]}"

print r.join("\n")