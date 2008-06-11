require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"

# Support for Unicode.
require 'jcode'
$KCODE = 'u'


STDOUT.sync = true

class ShellScript < UserScript
  def lang; "Shell" end
  def executable; @hashbang || ENV['TM_SHELL'] || ENV['SHELL'] || 'bash' end
  def args; [] end
  def version_string
    res = %x{#{executable} --version}.chomp.split("\n")[0]
  end
  def default_extension; ".sh" end
end

class ShellMate < ScriptMate; end

script = ShellScript.new(STDIN.read)
ShellMate.new(script).emit_html
