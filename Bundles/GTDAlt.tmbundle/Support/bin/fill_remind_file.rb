#!/usr/bin/env ruby
require File.join(ENV['TM_BUNDLE_SUPPORT'],'bin','GTD.rb')
include GTD
filename = File.join(ENV['TM_GTD_DIRECTORY'], "gtdalt.reminders")
GTD.process_directory
reminderLines = []
actions = GTD.actions.reject{|i| i.completed?}
for action in actions do
  if action.due.nil? then
    dateObj = nil
  else
    dateObj = Date.parse(action.due)
  end
  if action.note =~ /(REM\s+[^%]*)%/ then
    reminderLines << $1 + "MSG #{action.note}.%"
  else
    if action.note =~ /rep:(\S+)/ then
      instructions = $1.split(",")
      for instruction in instructions do
        instruction = instruction.downcase
        case instruction
        when /^week$/
          string = if dateObj.nil? then "Monday" else dateObj.strftime('%A') end
        when /^day$/
          string = if dateObj.nil? then "" else dateObj.strftime('%B %d %Y *1') end
        when /^month$/
          string = if dateObj.nil? then "1" else dateObj.strftime('%d %Y') end
        when /^\d+$/
          string = if dateObj.nil? then instruction else dateObj.strftime('%B %d %Y *#instruction') end
        when /^mon|tue|wed|thu|fri|sat|sun|monday|tuesday|wednesday|thursday|friday|saturday|sunday$/
          string = instruction
        end
        if ENV['TM_GTD_REMINDER'] then
          reminderLines << "REM #{string} +#{ENV['TM_GTD_REMINDER']} MSG #{action.name.gsub(/%/,"")} %b.%"
        else
          reminderLines << "REM #{string} MSG #{action.name.gsub(/%/,"")}.%"
        end
      end
    elsif !dateObj.nil? then
      case action.due_type
      when /at/,/from/
        reminderLines << "REM #{dateObj.strftime('%B %d %Y')} MSG #{action.name.gsub(/%/,"")}.%"
      when /due/
        reminderLines << "REM #{dateObj.strftime('%B %d %Y')}"+ 
        (ENV['YM_GTD_REMINDER'].nil? ? " +1" : " +#{ENV['YM_GTD_REMINDER']}") + " MSG #{action.name.gsub(/%/,"")} %b.%"
      end
    end
  end
end
reminderData = reminderLines.join("\n")
File.open(filename, "w") do |f|
  f.puts reminderData
end