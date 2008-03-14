#!/usr/bin/ruby
#
# RMate v0.1, 2006-05-03.
# Copied, by Charilaos Skiadas, from RubyMate by Sune Foldager.
#
# v0.1  (2005-08-12): Initial version.
# v0.9  Heavily modified by Kevin Ballard
# v0.91 Plots are displayed inside of the HTML window; using a thread for sending R code to R by Hans-Jörg Bibiko
#
# We need this for HTML escaping.
require 'cgi'
require 'fcntl'

require File.join(File.dirname(__FILE__), 'lib/popen3')

# HTML escaping function.
def esc(str)
  CGI.escapeHTML(str)
end

what = (ENV['TM_SELECTED_TEXT'] == nil) ? "document" : "selection"
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
<pre><strong>RMate. Executing #{what} in R. This may take a while...</strong>
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

STDOUT.sync = true

# suggestion by Hans-J. Bibiko: if a doc is too large give R the chance to execute code, otherwise the pipe blocks (?)
Thread.new {
	STDIN.each do |line|
		stdin.puts(line.chomp)
#		stdin.print(line)
	end
	stdin.close
}

#stdin.write(STDIN.read.chomp)

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

#system("open -a Preview '#{tmpDir}'") unless Dir::glob("#{tmpDir}/*.pdf").empty?
STDOUT.sync = false
STDOUT.flush
if !Dir::glob("#{tmpDir}/*.pdf").empty?
	width = (Dir::glob("#{tmpDir}/*.pdf").size > 1) ? "50%" : "100%"
	puts '<br /><strong><i>click on image to open or drag the image to a location as PDF</i></strong><hr />'
	counter = 0
	Dir::glob("#{tmpDir}/*.pdf") { |f| 
		counter +=  1
		print "<img width=#{width} onclick=\"TextMate.system(\'open \\'#{f}\\'\',null);\" src='file://#{f}' />"
		print "<br>" if (counter % 2 == 0)
	}
	puts "<hr /><input type=button onclick=\"TextMate.system(\'open -a Preview \\'#{tmpDir}\\'\',null);\" value='Open all Images in Preview' />&nbsp;&nbsp;&nbsp;<input type=button onclick=\"TextMate.system(\'open -a Finder \\'#{tmpDir}\\'\',null);\" value='Reveal all Images in Finder' />"
end

puts '</div></pre></div>'
# Footer.
print <<-HTML
</body>
</html>
HTML
