require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"


test = File.basename(ARGV[0])
if test =~ /^(.+)Tests.(?:groovy|java)$/
  GrailsCommand.new("test-app #{$1}").run
else 
  TextMate.exit_show_tool_tip "#{test} is not a test case"
end
