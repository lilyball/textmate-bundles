require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"
require "pathname"
$KCODE = 'u'
require 'jcode'

STDOUT.sync = true

$SCRIPTMATE_VERSION = "$Revision: 9890 $"

class IOScript < UserScript
  def lang; "IO" end
  def executable; @hashbang || ENV['TM_IO'] || 'io' end
  def args; [] end
  def version_string
    res = %x{#{executable} 2>&1 <<< "System version; System exit;"}.chomp.match(/\d*/)[0]
    res + " (#{executable})"
  end
  def default_extension; ".io" end
end

class IOMate < ScriptMate; end

script = IOScript.new(STDIN.read)
IOMate.new(script).emit_html
