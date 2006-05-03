#!/usr/bin/ruby
#
# RMate v0.1, 2006-05-03.
# Copied, by Charilaos Skiadas, from RubyMate by Sune Foldager.
#
# v0.1  (2005-08-12): Initial version.
#
# We need this for HTML escaping.
require 'cgi'
# HTML escaping function.
def esc(str)
  CGI.escapeHTML(str)
end
# Helper to dump files to stdout.
def dump_file(name)
  File.open(name) {|f| f.each_line {|l| print l} }
end
# Headers...
print <<-EOS
<html>
<head>
<title>R TextMate Runtime</title>
<style type="text/css">
EOS
# Prepare some values for later.
myFile = __FILE__
myDir = File.dirname(myFile) + '/'
dump_file(myDir + 'pastel.css')
print <<-HTML
</style>
</head>
<body>
<div id="script_output" class="framed">
<pre><strong>RMate. Executing document in R. This may take a while...</strong>
<div id="actual_output" style="-khtml-line-break: after-white-space;">
HTML
class << STDOUT
  alias real_write write
  def write(thing)
    real_write(esc(thing.to_s).gsub("\n", '<br />'))
  end
end
STDOUT.flush
STDOUT.sync = true
rsession = IO.popen("R --vanilla --no-readline -q","r+")
rsession.write(STDIN.read.chomp + "\n")
rsession.write "q()\n"
print rsession.read
rsession.close
STDOUT.sync = false
class << STDOUT
  alias unreal_write write
  alias write real_write
end
puts '</div></pre></div>'
# Footer.
print <<-HTML
</body>
</html>
HTML
