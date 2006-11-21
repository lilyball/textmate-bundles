require "#{ENV["TM_SUPPORT_PATH"]}/lib/scriptmate"

# Someone needs to write an exception handler for perl, and figure out
# how to load it when PerlMate runs a script.

class PerlScript < UserScript
  def lang; "Perl" end
  def executable; @hashbang || ENV['TM_PERL'] || 'perl' end
  def version_string
    %x{#{executable} -e 'printf "Perl v%vd", $^V'} + " (" + \
          %x{#{executable} -e 'use Config; print "$Config{perlpath}";'} + ")"
  end
end

class PerlMate < ScriptMate; end

script = PerlScript.new(STDIN.read)
PerlMate.new(script).emit_html
