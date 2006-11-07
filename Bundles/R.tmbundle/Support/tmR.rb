#!/usr/bin/ruby
#
# RMate v0.1, 2006-05-03.
# Copied, by Charilaos Skiadas, from RubyMate by Sune Foldager.
#
# v0.1  (2005-08-12): Initial version.
# v0.9  Heavily modified by Kevin Ballard
#
# We need this for HTML escaping.
require 'cgi'
require 'fcntl'

require File.join(File.dirname(__FILE__), 'lib/popen3')

# HTML escaping function.
def esc(str)
  CGI.escapeHTML(str)
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
File.open(File.join(myDir, 'pastel.css')) {|f| f.each_line {|l| print l} }
print <<-HTML
</style>
</head>
<body>
<div id="script_output" class="framed">
<pre><strong>RMate. Executing document in R. This may take a while...</strong>
<div id="actual_output" style="-khtml-line-break: after-white-space;">
HTML

def recursive_delete(path)
  if (File.directory?(path)) then
    Dir.foreach(path) { |file| recursive_delete(File.join(path,file)) unless [".",".."].include?(file) }
    Dir.unlink(path)
  else
    File.unlink(path)
  end
end

tmpDir = File.join(ENV['TMP'] || "/tmp", "TM_R")
recursive_delete(tmpDir) if File.exists?(tmpDir) # remove the temp dir if it's already there
Dir::mkdir(tmpDir)
# Mechanism for dynamic reading inspired by RubyMate
stdin, stdout, stderr = popen3("R", "--vanilla", "--no-readline", "--slave", "--encoding=UTF-8")

stdin.puts(%{options(device="pdf")})
stdin.puts(%{formals(pdf)[c("file","onefile","width","height")] <- list("#{tmpDir}/Rplot%03d.pdf", F, 8, 8)})
stdin.puts(%{options(pager="/bin/cat")})
stdin.puts("options(echo=T)")
stdin.write(STDIN.read.chomp)
stdin.close

STDOUT.sync = true

descriptors = [stdout, stderr]
descriptors.each { |fd| fd.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK) }
until descriptors.empty?
  select(descriptors).shift.each do |io|
    str = io.read
    if str.empty?
      descriptors.delete io
      io.close
    elsif io == stdout
      print( str.map do |line|
        if line =~ /^(?:>|\+) / then
          %{<span style="color: darkcyan">#{esc line.chomp}</span>\n}
        else
          esc line
        end
      end.join )
    elsif io == stderr
      print %{<span style="color: red">#{esc str}</span>}
    end
  end
end
system("open -a Preview '#{tmpDir}'") unless Dir::glob("#{tmpDir}/*.pdf").empty?

STDOUT.sync = false
puts '</div></pre></div>'
# Footer.
print <<-HTML
</body>
</html>
HTML
