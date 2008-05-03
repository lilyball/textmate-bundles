require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"

class NutestScript < UserScript
  def lang; "Nu" end
  def executable; @hashbang || ENV['TM_NUTEST'] || 'nutest' end
  def args; ENV['TM_FILENAME'] end
  def version_string
    version = `nush -e '(puts (version))'`
    "nutest (#{version.strip!})"
  end
end

class NutestMate < ScriptMate
  def filter_stderr(str)
    # strings from stderr are passed through this method before printing
    "<span style='color:red'>#{str}</span>"
  end
end

script = NutestScript.new(STDIN.read)
NutestMate.new(script).emit_html
