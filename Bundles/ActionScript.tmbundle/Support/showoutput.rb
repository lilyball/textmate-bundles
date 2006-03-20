#!/usr/bin/ruby -w
#
#

require "cgi"

def escape(string)
  CGI.escapeHTML(string)
end

def printheader(compiler)
  print <<-ENDHTML
    <html>
    <head>
    <title>MTASC ActionScript Compilation</title>
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
    Compiling ActionScript file with #{compiler}...
    </div>
  ENDHTML
end

def printend
  print <<-ENDHTML
    </body>
    </html>
  ENDHTML
end

def makeerrorlink(line)
  a = line.split(':', 3)  
  file = a[0]
  line = a[1]
  exp = a[2]
  "<tr><td width='50'></td><td><div class='errorinfo'>" +
    File.basename(file) + " line #{line}</div></td>" +
    '<td width="30"></td><td><div class="errorexp"><a href="txmt://open?url=file://' + 
    File.expand_path(file) + '&line=' + line + '">' + 
    escape(exp) + "</a></div></td></tr>"
end

def printerrors(errorfile)
  puts "<div class='errors'>"
  puts "<table>"
  errorfile.each do |line|    
    if line =~ /[a-z0-9]/ then
      $errors += 1
    end
    
    if line =~ /[:]/ then
      puts makeerrorlink(line)
    else
      puts "<div class='errorline'>"
      puts line
      puts "</div>"
    end
  end

  if $errors == 0
    puts "Compilation OK."
  end
  puts "</table></div>"
end

#######################################################

# Start HTML output.
printheader("mtasc")

# We print the output directly from STDIN to get immediate response if we run a long show.
# Print the errors - if there are any.
$errors = 0
printerrors(STDIN)
# ... And end the HTML
printend

# EOF