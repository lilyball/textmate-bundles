# just a small to-html formater for what svn blame gives you.
# made to be compatible with the ruby version included
# in 10.3.7 (1.6.8) but runs also with 1.8
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this. :)


# fetch some tm things..
full_file = ENV['TM_FILEPATH']
current   = ENV['TM_LINE_NUMBER'].to_i
tab_size  = ENV['TM_TAB_SIZE'].to_i
bundle    = ENV['TM_BUNDLE_PATH']


# require the helper, it does some formating, etc:
require bundle+'/Tools/svn_helper.rb'
include SVNHelper


# create some other local and global vars..
file      = full_file.sub( /^.*\//, '')  # just get the filename without path
linecount = 1           # to show line numbers in output
out       = ''          # output buffer
error_txt = Array.new   # used to collect the error lines
$tab_size = tab_size    # just to make it accesible to the htmlize thing


# start..
begin
   out += '<table class="blame"> <tr>' +
            '<th>line</th>' +
            '<th class="revhead">rev</th>' +
            '<th>name</th>' +
            '<th class="codehead">code</th>' +
            "</tr>\n"
   
   $stdin.each_line do |line|
      if line =~ /^svn: (.*)$/
         error_txt << $1
         
      elsif error_txt.size == 0 and line =~ /\s*(\d+)\s*(\w+) (.*)/
         curr_add = (current == linecount) ? ' current_line' : ''
         
         out += '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
                    '<td class="revcol'+curr_add+'">' + $1 + "</td>\n" +
                    '<td class="namecol'+curr_add+'">' + $2 + "</td>\n" +
                    '<td class="codecol'+curr_add+'"><a href="' +
                        make_tm_link( full_file, linecount) +'">'+ htmlize( $3 ) +
                    "</a></td></tr>\n\n"
         
         linecount += 1
         
      else
         raise NoMatchException, line
      end
      
   end
   
   out += '</table>'
   
rescue NoMatchException
   out = '<div class="error"><br />&emsp; mhh, something with with the regex or svn must be wrong, the last line was 
          <br />&emsp; "<i>'+htmlize( $! )+'</i>".
          <br />&emsp; please bug-report to <a href="mailto:torsten.becker@gmail.com" class="mail_to">
                       torsten.becker@gmail.com</a>.</div>'
end


# if we got some svn: lines:
if error_txt.size > 0
   out = '<div class="svn_says"><br />&emsp;'
   error_txt.each { |el| out += htmlize( el ) + "\n<br />&emsp;" }
   out += '</div>'
end


# show it..
puts "<html>
<head>
<title>Subversion blame for '"+file+"'</title>
<style type=\"text/css\">
   @import 'file://"+bundle+"/Stylesheets/svn_style.css';
   @import 'file://"+bundle+"/Stylesheets/svn_blame_style.css';
</style>
</head>

<body>
<h1>Subversion blame for '"+file+"'</h1>
<hr />
"+out+"
</body>

</html>"
