#!/usr/bin/ruby -w
#
#

require "cgi"

def escape(string)
  CGI.escapeHTML(string)
end

def printheader(schemesystem, interpreter)
  print <<-ENDHTML
    <html>
    <head>
    <title>Scheme TextMate Runtime</title>
    <style type='text/css'>
  	  body { background-color: #e0e0ff;}
  	  .header,
  	  .output,
  	  .errors {
  			  margin: 10px 0px 10px 0px;
  			  padding: 10px;
  			  border: 1px dotted black;
  			  background-color: #ffffff;
  	  }
  	  .header { background-color: #a0a0ff;}
  	  .output { background-color: #ffffff;}
  	  .outputline { font-family: Monaco;
    	              font-size: 8pt; }
  	  .errors { background-color: #f0f0f0;}
  	  .errorline {  font-family: Monaco;
    	              font-size: 8pt;
    	              color: #0000f0 }
	    .errorinfo {  font-family: Monaco;
	                  font-size: 8pt; }
	    .errorexp {   font-family: Monaco;
                    font-size: 8pt;
                    color: #f00000 }
	    a {	color: #f00000;
          text-decoration: none; }
    </style>
    <body>
    <div class='header'>
    Executed Scheme file in #{schemesystem} (<i>#{interpreter}</i>)
    </div>
  ENDHTML
end

def printend
  print <<-ENDHTML
    </body>
    </html>
  ENDHTML
end

def printoutput(ioport)
  puts "<div class='output'>"
  ioport.each do |line| 
    puts "<div class='outputline'>"
    puts line
    puts "</div>"
  end
  puts "</div>"
end

def makeerrorlink(line, system)
  case system
  when "mzscheme"
    a = line.split(':', 4)
    file = a[0]
    line = a[1]
    column = a[2]
    exp = a[3]
    "<tr><td width='50'></td><td><div class='errorinfo'>" +
    File.basename(file) + " line #{line}, column #{column}</div></td>" +
    '<td width="30"></td><td><div class="errorexp"><a href="txmt://open?url=file://' + 
    File.expand_path(a[0]) + '&line=' + line + '&column=' + column + '">' + 
    escape(exp) + "</a></div></td></tr>"
  end
end

def printerrors(errorfile, system)
  puts "<div class='errors'>"
  puts "<table>"
  errors = 0
  f = File.new(errorfile)  
  f.each do |line|
      errors = 1
      case system
      when "mzscheme"
        if line =~ /:[0-9]+:[0-9]+:/ then
          puts makeerrorlink(line, system)
        else
          puts "<div class='errorline'>"
          puts line
          puts "</div>"
        end
      when "csi"
        if line =~ /^Error/ then
          puts "<div class='errorline'>"
          puts line
          puts "</div>"        
        else
          puts "<div class='errorinfo'>"
          puts line
          puts "</div>"
        end
      else
        puts "<div class='errorline'>"
        puts line
        puts "</div>"        
      end
  end
  if errors == 0
      puts "Program exited normally."
  end
  puts "</table></div>"
end

#######################################################

# Grab command line arguments...
interpreter = ARGV[0]
errorfile = ARGV[1]

schemesystem = File.basename(interpreter)

systems = { "csi"       => "Chicken Scheme",
            "mzscheme"  => "PLT MzScheme" }

# Start HTML output.
printheader(systems[schemesystem], interpreter)
# We print the output directly from STDIN to get immediate response if we run a long show.
printoutput(STDIN)
# Print the errors - if there are any.
printerrors(errorfile, schemesystem)
# ... And end the HTML
printend

# EOF