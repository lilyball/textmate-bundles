require "#{ENV["TM_BUNDLE_SUPPORT"]}/MaudeMate/maudemate"

if __FILE__ == $PROGRAM_NAME
  MaudeMate.run(ARGV)
end