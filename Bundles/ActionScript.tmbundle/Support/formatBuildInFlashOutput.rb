header = <<HEADER
<header>
<style>
  
  body
  {
    padding: 3em;
  }
  
  .success, .errors
  {
    font-weight: bold;
    font-size: 110%;
    margin-bottom: 2em;
  }
  
  .success
  {
    color: green;
  }
  
  .errors
  {
    color: red;
  }  

  .path 
  {
    font: courier;
  }

  pre.code
  {
    border: 1px solid #aaa;
    background: #eee;
    margin: 1em;
    padding: 1em;
    white-space: normal;
  }

</style>
</header>
HEADER

lines = ARGV[0].gsub(/\r/, "\n").split("\n")
lines = lines.map {|l| l.strip}.delete_if {|l| l == "" || l.index("Total ActionScript Errors:") == 0 || l.index("Cleaning up temporary files") == 0}

# At this point, we should have an even number of lines.
# ex: 
# n   :  /Users/dom/Sites/alahup/flash/_classes/com/lachoseinteractive/electrabel/Main.as: Line 24: Type mismatch in assignment statement: found String where Number is required.
# n+# :      	var minHeight:Number ="100";
# 
# Sometimes a line is prepended with **Error**
#

errors = []
for i in 0..lines.length/2-1
    
    begin  

        error = lines[i*2].scan(/(\/.*?): Line (.*?):(.*)/)[0]
        error << lines[i*2+1]
        errors.push(error)

    rescue

        puts "WARNING, TextMate ActionScript Bundle Error, Unable to parse output: <br/>"
        puts "<pre>" + lines[i*2].to_s + "</pre>"
        
    end
    
end

puts "<html>#{header}<body>"
#puts "<pre style=\"font-size: 50%\">" + ARGV[0] +"</pre>"

if errors.size == 0
  puts "<div class=\"success\">Build successful</div>"
  puts "</body></html>"
  exit 0
else
  puts "<div class=\"errors\">"
  if errors.size == 1
    puts "One error was found"
  else
    puts "#{errors.size} errors were found"
  end
  puts "</div>"
end
  

errors.each do |e|
  puts "<div class=\"error-msg\">#{e[2]}</div>"
  puts "<div class=\"path\"><a href=\"txmt://open/?url=file://#{e[0]}&line=#{e[1]}\">#{e[0]}</a>, line #{e[1]}</div>"
  puts "<pre class=\"code\">#{e[3]}</pre>"

  puts "<br/>"
end

exit 1
puts "</body></html>"