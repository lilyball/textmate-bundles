# just a small to-html formater for what svn blame gives you.
# made to be compatible with the ruby version included
# in 10.3.7 (1.6.8) but runs also with 1.8
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.

css = '
/* general stuff.. */
body {
   font-family: sans-serif;
   font-size: 11pt;
}

h1 {
   font-size: 18pt;
}


/* for error formating.. */
div.error {
   color: #f7260c;
   font-weight: bold;
}

div.error:before { content: "ERROR: "; }

div.svn_says {
   color: #f04907;
   font-weight: bold;
}

div.svn_says:before { content: "Subversion says: "; }


/* about links.. */
a, a:visited, a:link {
   background-color: inherit;
   color: inherit;
}

a:hover, a:active {
   background-color: #000;
   color: #fff;
   text-decoration: none;
}

table.blame a, table.blame a:visited, table.blame a:link {
   text-decoration: none;
}

table.blame a:hover, table.blame a:active {
   background-color: #a3c8ff;
   color: inherit;
   text-decoration: none;
}


/* formating the table.. */
table.blame {
   font-size: 9.5pt;
   padding: 1px;
   border-collapse: collapse;
}

table.blame th {
   text-align: left;
   background-color: #eee;
   border-bottom: 1px solid #999;
   padding: 3px;
   padding-bottom: 1px;
   padding-top: 1px;
   color: #666;
}

th.revhead {
   border-left: 1px solid #bbb;
   border-right: 1px solid #bbb;
}

th.codehead {
   border-left: 1px solid #bbb;
}

table.blame td {
   vertical-align: top;
}

td.linecol {
   background-color: #ddd;
   border-right: 1px solid #999;
   color: #888;
   text-align: right;
}

td.revcol, td.namecol {
   text-align: right;
   background-color: #f8f8f8;
   color: #888;
   border-right: 1px solid #ddd;
   padding-right: 2px;
   padding-left: 2px;
}

td.namecol {
   border-right: 1px solid #aaa;
}

td.codecol {
   font-size: 9pt;
   font-family: "Bitstream Vera Sans Mono", monospace;
   padding-left: 4px;
}

td.current_line {
   background-color: #e7e7e7;
}'


module FormatBlame
   class NoMatchException < StandardError; end
   class SVNErrorException < StandardError; end
   
   def make_link( filename, line )
      'txmt://open?url=file://' + filename + '&amp;line=' + line.to_s
   end
   
   def htmlize( string, tab_size )
      return string.to_s.gsub( /\<|\>|&| |\t/ ) do |match|
         case match
            when '<'
            '&lt;'
            when '>'
            '&gt;'
            when '&'
            '&amp;'
            when ' '
            '&ensp;'
            when "\t"
            '&ensp;'*tab_size
         end
      end   
   end
   
end #module FormatBlame
include FormatBlame


full_file = ENV['TM_FILEPATH']
current   = ENV['TM_LINE_NUMBER'].to_i
tab_size  = ENV['TM_TAB_SIZE'].to_i

file      = full_file.sub( /^.*\//, '')  # just get the filename without path
linecount = 1
out       = ''


begin
   out += '<table class="blame"> <tr>' +
            '<th>line</th>' +
            '<th class="revhead">rev</th>' +
            '<th>name</th>' +
            '<th class="codehead">code</th>' +
            "</tr>\n"
   
   $stdin.each_line do |line|
      raise SVNErrorException  if line =~ /^svn: (.*)$/
      raise NoMatchException   unless line =~ /\s*(\d+)\s*(\w+)\s(.*)/
      
      curr_add = (current == linecount) ? ' current_line' : ''
      
      out += '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
                 '<td class="revcol'+curr_add+'">' + $1 + "</td>\n" +
                 '<td class="namecol'+curr_add+'">' + $2 + "</td>\n" +
                 '<td class="codecol'+curr_add+'"><a href="' +
                     make_link( full_file, linecount) +'">'+ htmlize( $3, tab_size ) +
                 "</a></td></tr>\n\n"
      
      linecount += 1
   end
   
   out += '</table>'
   
rescue SVNErrorException
   out = '<div class="svn_says"><br />&emsp;'+ htmlize( $1, tab_size ) + '.</div>'
rescue NoMatchException
   out = '<div class="error"><br />&emsp;mhh, something with with the regex or svn must be wrong,
   please bug-report to <a href="mailto:torsten.becker@gmail.com" class="mail_to">torsten.becker@gmail.com</a>.</div>'
end


puts "<html>
<head>
<title>Subversion blame for '"+file+"'</title>
<style>
"+css+"
</style>
</head>

<body>
<h1>Subversion blame for '"+file+"'</h1>
<hr />
"+out+"
</body>

</html>"
