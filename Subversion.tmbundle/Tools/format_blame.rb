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


# create some other local vars..
file      = full_file.sub( /^.*\//, '')  # just get the filename without path
linecount = 1
out       = ''
error_txt = ''


# start..
begin
   out += '<table class="blame"> <tr>' +
            '<th>line</th>' +
            '<th class="revhead">rev</th>' +
            '<th>name</th>' +
            '<th class="codehead">code</th>' +
            "</tr>\n"
   
   $stdin.each_line do |line|
      raise SVNErrorException  if line =~ /^svn: (.*)$/
      raise NoMatchException   unless line =~ /\s*(\d+)\s*(\w+) (.*)/
      
      curr_add = (current == linecount) ? ' current_line' : ''
      
      out += '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
                 '<td class="revcol'+curr_add+'">' + $1 + "</td>\n" +
                 '<td class="namecol'+curr_add+'">' + $2 + "</td>\n" +
                 '<td class="codecol'+curr_add+'"><a href="' +
                     make_tm_link( full_file, linecount) +'">'+ htmlize( $3, tab_size ) +
                 "</a></td></tr>\n\n"
      
      linecount += 1
   end
   
   out += '</table>'
   
rescue SVNErrorException
   out = '<div class="svn_says"><br />&emsp;'+ htmlize( $1, tab_size ) + '</div>'
rescue NoMatchException
   out = '<div class="error"><br />&emsp;mhh, something with with the regex or svn must be wrong,
   please bug-report to <a href="mailto:torsten.becker@gmail.com" class="mail_to">torsten.becker@gmail.com</a>.</div>'
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
