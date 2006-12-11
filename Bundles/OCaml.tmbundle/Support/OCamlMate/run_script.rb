#!/usr/bin/env ruby

require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"

require 'open3'
require 'cgi'
require 'fcntl'

def esc(str)
  CGI.escapeHTML(str).gsub(/\n/, '<br/>')
end

class UserScript
  def initialize
    @ocamlc = ARGV[0]
    @srcfile = ARGV[1]
    @dstfile = ARGV[2]

    if ENV.has_key? 'TM_FILEPATH' then
      @path = ENV['TM_FILEPATH']
      @display_name = File.basename(@path)
    else
      @path = '-'
      @display_name = 'untitled'
    end
    
    @findlibpackages = (ENV['TM_OCAML_FINDLIB_PACKAGES'] || '').strip()
    @findlib = "ocamlfind"
  end


  # looks for the location of the threads library
  def find_threads()
    possibilities = [
        '/opt/local/godi/lib/ocaml/std-lib/threads',
        '/usr/local/godi/lib/ocaml/std-lib/threads',
        '/godi/lib/ocaml/std-lib/threads',
        '/opt/local/lib/ocaml/threads',
        '/usr/local/lib/ocaml/threads',
        '/usr/lib/ocaml/threads'
      ]
      
    possibilities.each() do |p|
      if File.exists?(p)
        return p
      end
    end
    
    return ""
  end


  def compile
    threadsincludedir = find_threads()
    
    
    # compile it
    if threadsincludedir != ""
      command = "#{e_sh @findlib} #{e_sh @ocamlc} -o #{e_sh @dstfile} -I #{e_sh(threadsincludedir)} -package #{e_sh @findlibpackages} -linkpkg str.cma unix.cma threads.cma #{e_sh @srcfile} 2>&1"
    else
      command = "#{e_sh @findlib} #{e_sh @ocamlc} -o #{e_sh @dstfile} -package #{e_sh @findlibpackages} -linkpkg str.cma unix.cma #{e_sh @srcfile} 2>&1"
    end
    puts command
    output = `#{command}`
    
    onlywarnings = true
    if output != ""
      output.each_line() do |line|
        if line =~ /^File "(?:.*?)", (line ([0-9]+), characters [0-9]+-[0-9]+):/
          location, line = $1, $2
          print "<span>File \"#{@path}\", <a style=\"color: blue;\" href=\"txmt://open?url=file://#{e_url(@path)}&line=#{line}\">#{location}</a>:</span><br/>"
        else
          print esc(line)
          if line !~ /^Warning/
            onlywarnings = false
          end
        end
      end
      
      if !onlywarnings
        exit 1
      end
    end
  end


  def run
    # run it if the compile suceeded
    stdin, stdout, stderr = Open3.popen3(@dstfile)
    Thread.new { stdin.write @content; stdin.close } unless ENV.has_key? 'TM_FILEPATH'

    [stdout, stderr]
  end

  attr_reader :display_name, :path
  
end

error = ""
STDOUT.sync = true

script = UserScript.new
map = {
  'SCRIPT_NAME'       => script.display_name,
  'BUNDLE_SUPPORT'    => "tm-file://#{ENV['TM_BUNDLE_SUPPORT'].gsub(/ /, '%20')}",
}
puts DATA.read.gsub(/\$\{([^}]+)\}/) { |m| map[$1] }

script.compile
stdout, stderr = script.run
descriptors = [ stdout, stderr ]

descriptors.each { |fd| fd.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK) }
until descriptors.empty?
  select(descriptors).shift.each do |io|
    str = io.read
    if str.to_s.empty? then
      descriptors.delete io
      io.close
    elsif io == stdout then
      print esc(str)
    elsif io == stderr then
      print "<span style='color: red'>#{esc str}</span>"
    elsif io == stack_dump then
      error << str
    end
  end
end

puts '</div></pre></div>'
puts error
puts '<div id="exception_report" class="framed">Program exited.</div>'
puts '</body></html>'

__END__
<html>
  <head>
    <title>OCamlMate</title>
    <link rel="stylesheet" href="${BUNDLE_SUPPORT}/pastel.css" type="text/css">
  </head>
<body>
  <div id="script_output" class="framed">
  <pre><strong>OCamlMate</strong>
<strong>${SCRIPT_NAME}</strong>
<div id="actual_output" style="word-wrap: break-word;">
