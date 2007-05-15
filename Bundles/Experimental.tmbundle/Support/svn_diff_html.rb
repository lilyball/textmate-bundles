#!/usr/bin/env ruby

puts <<-HTML
<style>
pre a { text-decoration: none; overflow: hidden; display: block; width: 100%; white-space: nowrap;}
pre a:hover {background: transparent;}

           pre a {color: #000;}
.bright    pre a {color: #333;}
.shiny     pre a,
.dark      pre a {color: #eee;}
.halloween pre a {color: #eee;}

           pre a.added,
.bright    pre a.added {color: #00401E;   background: #40FF9A;}
.shiny     pre a.added,                   
.dark      pre a.added,                   
.halloween pre a.added {color: #40FF9A;   background: #00401E;}
           pre a.removed,                 
.bright    pre a.removed {color: #400021; background: #FF40A3;}
.shiny     pre a.removed,                 
.dark      pre a.removed,                 
.halloween pre a.removed {color: #FF40A3; background: #400021;}

           pre a:hover.added,
.bright    pre a:hover.added {background: #00401E;   color: #40FF9A;}
.shiny     pre a:hover.added,                        
.dark      pre a:hover.added,                        
.halloween pre a:hover.added {background: #40FF9A;   color: #00401E;}
           pre a:hover.removed,                      
.bright    pre a:hover.removed {background: #400021; color: #FF40A3;}
.shiny     pre a:hover.removed,                      
.dark      pre a:hover.removed,                      
.halloween pre a:hover.removed {background: #FF40A3; color: #400021;}

pre {white-space: normal !important;}
pre a span { position: absolute; margin-left: -3em; width: 2.75em; padding-top: 0.4em; color: #999; font-size: 70%; display: block; float: left; text-align: right; }
</style>
HTML

svn = ENV['TM_SVN'] || 'svn'
require 'cgi'

StatusMap = {'+' => 'added',
             '-' => 'removed'}

def status_map(status)
  StatusMap[status.chr]
rescue
  nil
end

class DiffLine
  attr :line_number , true
  attr :code        , true
  attr :status      , true
  attr :filepath    , true
  def initialize(line_number , code , filepath , status)
    self.line_number = line_number
    self.code        = code
    self.filepath    = filepath
    self.status      = status
  end
  def link
    %{<a class="#{status}" href="txmt://open?url=file:///#{filepath}&amp;line=#{line_number}"><span>#{line_number}</span> #{hcode}</a>}
  end
  def hcode
    CGI::escapeHTML(self.code).gsub(' ','&nbsp;')
  end
end

files = ENV['TM_SELECTED_FILES'] || "'"<<( ENV['TM_PROJECT_DIRECTORY'] || ENV['TM_DIRECTORY'] )<<"'"
puts <<-HTML
<!--
  Selected files 
  #{files}
-->
HTML

command = "#{svn} diff --diff-cmd /usr/bin/diff -x -U0 #{files}"
puts "<!-- `#{command}` -->"
lines = `#{command}`.split("\n")

line_number = 0
filepath = ENV['TM_FILEPATH']
difflines = []

lines.each do |l|
  l.match(/@@.*?\+(\d+).*? @@/)
  line_number = $1.to_i-1 if $1
  
  l.match(/\+{3} (.*?)\s+\(.*?\)$/)
  filepath = $1 if $1
  
  status = status_map(l[0])
  difflines.push(DiffLine.new(line_number, l, filepath, status)) if l.match(/^(\+|-)/) unless l.match(/^(\+|-){3}/)
  
  line_number = line_number +1 unless l.match(/^-/)
end

filepath = ''
difflines.each_with_index do |d,i|
  puts '</pre>' if i > 0 and d.filepath != filepath
  puts "<h3>#{d.filepath.gsub(/\b\//,'&#8203;/')}</h3><pre>" if d.filepath != filepath
  filepath = d.filepath
  puts d.link
end
puts '</pre>'
