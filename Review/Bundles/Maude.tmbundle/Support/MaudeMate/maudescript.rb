require "#{ENV["TM_BUNDLE_SUPPORT"]}/lib/mk_scriptmate"

class MaudeScript < UserScript
  def lang; "Maude" end
  def executable; ENV['TM_MAUDE'] || 'maude' end
  def args; %w[-batch -no-banner -no-ansi-color -no-wrap] end
  def version_string
    "Core #{lang} " + super
  end
  def filter_cmd(exec, args, path, argv)
    [exec, args, argv]
  end
end