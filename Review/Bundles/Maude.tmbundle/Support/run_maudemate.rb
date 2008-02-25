support = "#{ENV["TM_BUNDLE_SUPPORT"]}/MaudeMate/"
require support + 'maudescript'
require support + 'maudemate'

if __FILE__ == $PROGRAM_NAME
  if ENV.has_key?('TM_DIRECTORY')
    maude_lib = ENV['MAUDE_LIB'].to_s
    ENV['MAUDE_LIB'] = maude_lib + ":#{ENV['TM_DIRECTORY']}"
  end
  script = if 0 == ARGV.length then
    MaudeScript.new(STDIN.read)
  else
    MaudeScript.new(STDIN.read, []) do |io|
      ARGV.each do |line|
        io.puts line
      end
    end
  end
  exit MaudeMate.new(script).emit_html
end