#!/usr/bin/env ruby
#
# Kinkless to GTD converter.
#
# Instructions: First, save your Kinkless oo3 file as an OMPL document from within 
# OmniOutlinerPro. Then, open it in TextMate and select the command:
#       GTDAlt -> Convert From Kinkless.
# A new document will be created, save it with extension gtd.
#
require 'pp'
require 'rexml/document'
require 'Date'
require 'cgi'
include REXML
file = STDIN.read

class MyBuilder
  def initialize
    @objects = Array.new
  end
  def add(hash)
    @objects << hash
  end
  
  def build
    indent = 0
    indent_inc = 2
    s = []
    endA = []
    index = 0
    @objects.each do |o|
      case o[:type]
      when :project
        t = " " * indent
        s << t + "project #{o[:text]}"
        indent += indent_inc
      when :action
        t = " " * indent
        t << "@#{o[:context]} #{o[:text]}"
        if o[:note] != "" then
          index += 1
          t << " [#{index}]"
          endA << "[#{index}] #{o[:note]}"
        end
        if o[:due_date] != ""  then
          the_date = ""
          begin
            the_date = Date.parse(o[:due_date],true)
          rescue
            print "had problems with date:" + o[:due_date] + "\n"
          end
          t << " due:[#{the_date}]"
        end
        s << t
      when :end
        indent -= indent_inc
        t = " " * indent
        s << t + "end"
      end
    end
    return (s + endA).join("\n")
  end  
end

doc = Document.new(file)
$b = MyBuilder.new
def process_project(project)
  $b.add(:type => :project, :text =>  CGI.unescapeHTML(project.attribute(:text).to_s))
  subitems = project.children.each do |e|
    unless e.raw then
      if e.attribute(:Context) then
        $b.add(:type => :action, :text => CGI.unescapeHTML(e.attribute(:text).to_s), :context => e.attribute(:Context), :due_date => e.attribute(:DueDate).to_s, :note => CGI.unescapeHTML(e.attribute(:_note).to_s))
      else
        process_project(e)
      end
    end
  end
  $b.add(:type => :end)
  
end
projects = doc.elements.each("//outline[@text='Projects']/outline") do |project|
  process_project(project)
  # pp project.methods.sort
end
puts $b.build