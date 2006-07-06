#!/usr/bin/env ruby
$:<<ENV['TM_SUPPORT_PATH']
$:<<ENV['TM_BUNDLE_SUPPORT']
require 'lib/dialog.rb'
require 'lib/exit_codes.rb'
require 'bin/GTD.rb'
require 'FileUtils.rb'
include GTD
include Dialog

class NormalException < Exception
end

dir = ENV['TM_GTD_DIRECTORY']
inboxfile = ENV['TM_GTD_INBOX']
unless dir && inboxfile && File.exist?(dir) && File.exist?(inboxfile) then
  TextMate.exit_show_html("<h1>Some files need to be created first!</h1>" + `#{e_sh File.join(ENV['TM_SUPPORT_PATH'],'bin',"MarkDown.pl")} #{e_sh File.join(ENV['TM_BUNDLE_SUPPORT'],"/INBOX.txt")} `)
end
tempInboxFilename = File.join(dir, "temp.gtd")
objects = GTD.process_directory(dir)
inbox_object = objects.find{|o| o.file == tempInboxFilename}
objects << (inbox_object = GTDFile.new(tempInboxFilename)) unless inbox_object
projects = GTD.projects
contexts = GTD.get_contexts
f = File.open(inboxfile, "r")
lines = f.readlines.map{|i| i.chomp}
f.close

$log = []
$unsorted = []
for text in lines do
  begin
    m = text.match(/^\s*@(\S+)\s+([^>]+)(?:>\s*(.*))?$/)
    raise(NormalException, text.match(/^\s*$/) ? "" : "Malformed Input Line: #{text}") unless m
    context, action, project = m[1..3]
    newContext = contexts.find_all{|c| c.downcase.index(context.downcase) != nil}
    case newContext.length
    when 0
      contexts = GTD.add_contexts(context)
      $log << "Created new context: #{context}."
      newContext = context
    when 1
      newContext = newContext[0]
    else
      raise NormalException, "Too many contexts matching: #{context}."
    end
    targetProj = inbox_object
    unless project == nil or project == "" then
      proj = projects.find_all{|pro| pro.name.downcase.index(project.downcase) != nil}
      case proj.length
        when 0
          choice = Dialog.request_item(:title => "No matching project", :prompt => "Did not find any project matching: #{project}. Please select a project from the list", :items => projects.map{|pro| pro.name} )
          if choice then
            targetProj = projects.find{|pro| pro.name == choice}
          else
            raise NormalException, "Did not find any project matching: #{project}."
          end
        when 1
          targetProj = proj[0]
        else
          choice = Dialog.request_item(:title => "Too many matching projects", :prompt => "Found too many projects matching: #{project}. Please select a project from the list", :items => proj.map{|pro| pro.name} )
          if choice then
            targetProj = projects.find{|pro| pro.name == choice}
          else
            raise NormalException, "Too many projects matching: #{project}."
          end
      end
    end
    act = Action.new(:name => action,:context => newContext)
    targetProj.add_item(act)
    $log << "Added action #{act.name} with context: #{newContext} to project: #{targetProj.name}."
  rescue NormalException => e
    $unsorted << text
    $log << e.to_s
    next
  rescue Exception => e
    raise e
  end
end
# Create files we want
data = objects.map{|o| [o.file.to_s,o.dump_object]} << [inboxfile,$unsorted.join("\n")]
GTD.safe_write_with_backup(data)
# Return feedback
puts $log.join("\n")
puts "LINES THAT COULD NOT BE PROCESSED:"
puts $unsorted.join("\n")