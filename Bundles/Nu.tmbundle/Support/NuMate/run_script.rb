require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"

class NuScript < UserScript
  def lang; "Nu" end
  def executable; @hashbang || ENV['TM_NUSH'] || 'nush' end
  def default_extension; "nu" end
  def version_string
    version = `nush -e '(puts (version))'`
    "nush (#{version.strip!})"
  end
end

class NuMate < ScriptMate
  def filter_stderr(str)
    # strings from stderr are passed through this method before printing
    "<span style='color:red'>#{str}</span>"
  end
end

script = NuScript.new(STDIN.read)
NuMate.new(script).emit_html
