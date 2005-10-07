# just a small to-html formater for what svn blame gives you.
# made to be compatible with the ruby version included
# in 10.3.7 (1.6.8) but runs also with 1.8
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


# fetch some tm things..
$full_file     = ENV['TM_FILEPATH']
$current       = ENV['TM_LINE_NUMBER'].to_i
$tab_size      = ENV['TM_TAB_SIZE'].to_i
$bundle        = ENV['TM_BUNDLE_SUPPORT']
$date_format   = ENV['TM_SVN_DATE_FORMAT'].nil? ? nil : ENV['TM_SVN_DATE_FORMAT']

# find out if the window should get closed on a click
$close = ENV['TM_SVN_CLOSE'].nil? ? '' : ENV['TM_SVN_CLOSE']
unless $close.empty?
   $close.strip!
   if $close == 'true' or $close == '1'
      $close = ' onClick="window.close();"'
   else
      $close = ''
    end
end


# require the helper, it does some formating, etc:
require $bundle+'/svn_helper.rb'
include SVNHelper


# to show line numbers in output:
linecount = 1


begin
   make_head( "Subversion Blame for '"+$full_file.sub( /^.*\//, '')+"'",
              [ $bundle+"/Stylesheets/svn_style.css",
                $bundle+"/Stylesheets/svn_blame_style.css"] )

   STDOUT.flush

   puts '<table class="blame"> <tr>' +
            '<th>line</th>' +
            '<th class="revhead">rev</th>' +
            '<th>user</th>' +
            '<th class="codehead">code</th></tr>'
   
   
   $stdin.each_line do |line|
      raise SVNErrorException, line  if line =~ /^svn:/
      
      # not a perfect pattern, but it works and is short:
      #              rev     user  date                                                       text
      if line =~ /\s*(\d+)\s+([-\w.]+) (\d+-\d+-\d+ \d+:\d+:\d+ [-+]\d+ \(\w{3}, \d+ \w{3} \d+\)) (.*)/
         curr_add = ($current == linecount) ? ' current_line' : ''
         
         puts  '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
               '<td class="revcol'+curr_add+'" title="'+ formated_date( $3 ) +'">' + $1 + "</td>\n" +
               '<td class="namecol'+curr_add+'" title="'+ formated_date( $3 ) +'">' + $2 + "</td>\n" +
               '<td class="codecol'+curr_add+'"><a href="' +
                  make_tm_link( $full_file, linecount) +'"'+$close+'>'+ htmlize( $4 ) +
               "</a></td></tr>\n\n"
         
         linecount += 1
         
      else
         raise NoMatchException, line
      end
      
   end #each_line
   
rescue => e
   handle_default_exceptions( e )
ensure
   make_foot( '</table>' )
end
