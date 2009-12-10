#!/usr/bin/ruby
#
# RMate v0.92, 2009-12-04.
# Copied, by Charilaos Skiadas, from RubyMate by Sune Foldager.
# v0.1  (2005-08-12): Initial version.
# v0.9  Heavily modified by Kevin Ballard
# v0.92 Heavily modified by by Hans-Jörg Bibiko
 
require 'cgi'
require 'fcntl'
SUPPORT_LIB = ENV['TM_SUPPORT_PATH'] + '/lib/'

cran = ARGV[0]
isSelection = (ARGV[1] == "1") ? true : false

# JavaScript to hide the start message on runtime
hideStartMessageJS = %{<script type="text/javascript">document.getElementById('start_message').className='hidden'</script>}

# line counter for hyperlinking R's prompt signs to jump back to the doc
selectionlinestart = isSelection ? ENV['TM_INPUT_START_LINE'].to_i-1 : 0
linecounter = selectionlinestart
linecountermarker = " #§*"

# HTML escaping function.
def esc(str)
  CGI.escapeHTML(str)
end

def my_popen3(*cmd) # returns [stdin, stdout, strerr, pid]
  pw = IO::pipe   # pipe[0] for read, pipe[1] for write
  pr = IO::pipe
  pe = IO::pipe
  
  # F_SETOWN = 6, ideally this would be under Fcntl::F_SETOWN
  pw[0].fcntl(6, ENV['TM_PID'].to_i) if ENV.has_key? 'TM_PID'
  
  pid = fork{
    pw[1].close
    STDIN.reopen(pw[0])
    pw[0].close

    pr[0].close
    STDOUT.reopen(pr[1])
    pr[1].close

    pe[0].close
    STDERR.reopen(pe[1])
    pe[1].close

    # maybe there is a way to support this in future ;)
    # tm_interactive_input = SUPPORT_LIB + '/tm_interactive_input.dylib'
    # if (File.exists? tm_interactive_input) 
    #   dil = ENV['DYLD_INSERT_LIBRARIES']
    #   ENV['DYLD_INSERT_LIBRARIES'] = (dil) ? "#{tm_interactive_input}:#{dil}" : tm_interactive_input unless (dil =~ /#{tm_interactive_input}/)
    #   ENV['DYLD_FORCE_FLAT_NAMESPACE'] = "1"
    #   ENV['TM_INTERACTIVE_INPUT'] = 'AUTO'
    # end
    
    exec(*cmd)
  }

  pw[0].close
  pr[1].close
  pe[1].close

  pw[1].sync = true

  [pw[1], pr[0], pe[0], pid]
end


def recursive_delete(path)
  %x{rm -rf #{path}}
end

# allow the user to define its own output font and size
outputFont = (ENV['TM_RMATE_OUTPUT_FONT'] == nil) ? "Monaco" : ENV['TM_RMATE_OUTPUT_FONT']
outputFontSize = (ENV['TM_RMATE_OUTPUT_FONTSIZE'] == nil) ? "10pt" : "#{ENV['TM_RMATE_OUTPUT_FONTSIZE']}pt"

# what comes in
what = (isSelection) ? "document" : "selection"

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
# include pastel.css and substitute some placeholder
File.open(File.join(myDir, 'pastel.css')) {|f| f.each_line {|l| print l.gsub('FONTPLACEHOLDER',outputFont).gsub('FONTSIZEPLACEHOLDER',outputFontSize)} }
print <<-HTML
</style>
<script type="text/javascript">
document.onkeyup = function keyPress(event) {
  if ( typeof event == "undefined" ) event = window.event;
  wkey = event.keyCode;
  if ( wkey == 27 ) window.close();
}
</script>

</head>
<body>
  <div id="script_output" class="framed">
    <div id="start_message"><pre><strong>RMate. Executing #{what} in R. This may take a while...</strong></pre></div>
    <pre><div id="actual_output" style="-khtml-line-break: after-white-space;">
HTML

tmpDir = File.join(ENV['TMP'] || "/tmp", "TM_R")
recursive_delete(tmpDir) if File.exists?(tmpDir) # remove the temp dir if it's already there
Dir::mkdir(tmpDir)

# Mechanism for dynamic reading
# stdin, stdout, stderr = popen3("R", "--vanilla", "--no-readline", "--slave", "--encoding=UTF-8")
stdin, stdout, stderr, pid = my_popen3("R --vanilla --slave --encoding=UTF-8 2>&1")
# init the R slave
stdin.puts(%{options(device="pdf")})
stdin.puts(%{options(repos="#{cran}")})
stdin.puts(%{formals(pdf)[c("file","onefile","width","height")] <- list("#{tmpDir}/Rplot%03d.pdf", FALSE, 8, 8)})
stdin.puts(%{if(getRversion()>="2.7") pdf.options(onefile=FALSE)})
stdin.puts(%{options(pager="/bin/cat")})
stdin.puts("options(echo=T)")

# if a doc is too large give R the chance to execute code, otherwise the pipe stalls
Thread.new {
  STDIN.each do |line|
    stdin.puts(line.chomp + "#{linecountermarker}")
  end
  stdin.close
}

STDOUT.sync = true

descriptors = [stdout, stderr]
descriptors.each { |fd| fd.fcntl(Fcntl::F_SETFL, Fcntl::O_NONBLOCK) }
until descriptors.empty?
  select(descriptors).shift.each do |io|
    begin
      str = io.readline
    rescue
    end
    if str.nil? or str.empty?
      descriptors.delete io
      io.close
    elsif io == stderr
      # just in case
      print hideStartMessageJS
      print %{<span style="color: red">#{esc str}</span>}
    elsif io == stdout
      print hideStartMessageJS
      str.each_line do |line|
        # line counter for top level source
        if line.include?("#{linecountermarker}")
          linecounter += 1
          line.sub!("#{linecountermarker}", '')
        end
        # check for a comment sign at the beginning of a line
        if line.match(/>\s*#/)
          print "<i><font color=blue>#{esc line.chomp}</font></i>\n"
        # check for a comment within a line - regexp should be improved yet!
        elsif m=line.match(/(.*?)(#[^"']*)$/)
          print esc(m[1]).gsub(/^(&gt;|\+)/,'<a class="prompt" href="txmt://open?line='+linecounter.to_s+'">\1</a>')
          print "<i><font color=blue>#{esc(m[2]).chomp}</font></i>\n"
        # check for error messages
        elsif m=line.match(/(?i)^\s*(error|erreur|fehler|errore|erro)( |:)/)
          where = (isSelection) ? " of selection" : ""
          print "<span style='color: red'>#{esc str.gsub(%r{(?m).*?#{m[1]}},m[1]).chomp}<br /><i>RMate</i> stopped at <a href='txmt://open?line=#{linecounter}'>line #{linecounter-selectionlinestart}#{where}</a></span><br />".gsub(%r{source\(&quot;(.*?)&quot;\)},'source(&quot;<a href="txmt://open?url=file://\1">\1</a>&quot;)')
          print "<hr noshade width='300' size='2' align='left' color=lightgrey>"
          break
        # check for warnings
        elsif line.match(/^\s*(Warning|Warning messages?|Message d.avis|Warnmeldung|Messaggio di avvertimento|Mensagem de aviso):/)
          print "<span style='color: gray'>#{esc line}</span>"
        # print line simply with hyperlinked prompt if given
        elsif line.match(/_\x8./)
          print "#{line.gsub(/_\x8(.)/,'<b>\1</b>')}"
        else
          print esc(line).gsub(/^[\x0-\x9]?(&gt;|\+)/,'<a class="prompt" href="txmt://open?line='+linecounter.to_s+'">\1</a>')
        end
      end
    end
  end
end

STDOUT.flush

# check for generated plots; if yes, embed them into the HTML output as PDF images
if !Dir::glob("#{tmpDir}/*.pdf").empty?
  width = (Dir::glob("#{tmpDir}/*.pdf").size > 1) ? "50%" : "100%"
  puts "<br /><strong><i style='font-size:8pt'>Click at image to open it.</i></strong><hr noshade size='2' align='left' color=lightgrey>"
  counter = 0
  Dir::glob("#{tmpDir}/*.pdf") { |f| 
    counter +=  1
    print "<img width=#{width} onclick=\"TextMate.system(\'open \\'#{f}\\'\',null);\" src='file://#{f}' />"
    print "<br>" if (counter % 2 == 0)
  }
  puts "<hr noshade size='2' align='left' color=lightgrey><center><input type=button onclick=\"TextMate.system(\'open -a Preview \\'#{tmpDir}\\'\',null);\" value='Open all Images in Preview' />&nbsp;&nbsp;&nbsp;<input type=button onclick=\"TextMate.system(\'open -a Finder \\'#{tmpDir}\\'\',null);\" value='Reveal all Images in Finder' /></center>"
end

puts '</div></pre></div>'

# Footer.
print <<-HTML
</body>
</html>
HTML
