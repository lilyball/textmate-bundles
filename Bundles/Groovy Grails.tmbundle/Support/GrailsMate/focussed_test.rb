require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"

potential_phases = ["unit", "integration", "functional", "other"]

testclasses = []
phases = []

ARGV.each do |t|
  test = File.basename(t)
  test =~ /^(.+)\.(.+)$/
  clazz = $1
  extension = $2
  if extension != "groovy" and extension != "java"
    TextMate.exit_show_tool_tip "#{test} is not a test case"
  end
  potential_phases.each do |potential_phase|
    phases << "--#{potential_phase}" if t =~ /test\/#{potential_phase}\//
  end
  testclasses << clazz.sub(/Tests$/, "")
end

GrailsCommand.new("test-app #{testclasses.uniq.join(' ')} #{phases.uniq.join(' ')}").run