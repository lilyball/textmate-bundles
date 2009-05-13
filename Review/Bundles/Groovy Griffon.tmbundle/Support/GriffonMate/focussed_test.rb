require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"

potential_phases = ["unit", "integration", "functional", "other"]

path = ARGV[0]
test = File.basename(path)
test =~ /^(.+)\.(.+)$/
clazz = $1
extension = $2
if extension == "groovy" or extension == "java"
  phases = []
  potential_phases.each do |potential_phase|
    phases << "--#{potential_phase}" if path =~ /test\/#{potential_phase}\//
  end
  clazz.sub! /Tests$/, ""
  GrailsCommand.new("test-app #{clazz} #{phases.join(' ')}").run
else 
  TextMate.exit_show_tool_tip "#{test} is not a test case"
end
