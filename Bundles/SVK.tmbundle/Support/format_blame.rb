# just a small to-html formater for what svk blame gives you.
# made to be compatible with the ruby version included
# in 10.3.7 (1.6.8) but runs also with 1.8
# 
# copyright 2005 david glasser <glasser@mit.edu>
# based on svn version:
#   copyright 2005 torsten becker <torsten.becker@gmail.com>
#   no warranty, that it doesn't crash your system.
#   you are of course free to modify this.


# fetch some tm things..
$full_file     = ENV['TM_FILEPATH']
$current       = ENV['TM_LINE_NUMBER'].to_i
$tab_size      = ENV['TM_TAB_SIZE'].to_i
$bundle        = ENV['TM_BUNDLE_SUPPORT']
$date_format   = ENV['TM_SVK_DATE_FORMAT'].nil? ? nil : ENV['TM_SVK_DATE_FORMAT']

# find out if the window should get closed on a click
$close = ENV['TM_SVK_CLOSE'].nil? ? '' : ENV['TM_SVK_CLOSE']
unless $close.empty?
   $close.strip!
   if $close == 'true' or $close == '1'
      $close = ' onClick="window.close();"'
   else
      $close = ''
    end
end


# require the helper, it does some formating, etc:
require $bundle+'/svk_helper.rb'
include SVKHelper


# to show line numbers in output:
linecount = 1


begin
   make_head( "SVK Blame for '"+$full_file.sub( /^.*\//, '')+"'",
              [ $bundle+"/css/svk_style.css",
                $bundle+"/css/svk_blame_style.css"] )
   
   puts '<table class="blame"> <tr>' +
            '<th>line</th>' +
            '<th class="revhead">rev</th>' +
            '<th>name</th>' +
            '<th class="codehead">code</th></tr>'
   
   
   $stdin.each_line do |line|
      raise SVKErrorException, line  if line =~ /^svk:/
      
      next if line =~ /^Annotations for / or line =~ /^\*{16}$/
      
      # not a perfect pattern, but it works and is short:
      #              rev     name  date          text
      if line =~ /^\s*(\d+)\s*\(\s*(\w+) (\d+-\d+-\d+)\):\t\t(.*)$/
         curr_add = ($current == linecount) ? ' current_line' : ''
         
         puts  '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
               '<td class="revcol'+curr_add+'" title="'+ formated_date( $3 ) +'">' + $1 + "</td>\n" +
               '<td class="namecol'+curr_add+'" title="'+ formated_date( $3 ) +'">' + $2 + "</td>\n" +
               '<td class="codecol'+curr_add+'"><a href="' +
                  make_tm_link( $full_file, linecount) +'"'+$close+'>'+ htmlize( $4 ) +
               "</a></td></tr>\n\n"
         
         linecount += 1
      elsif line =~ /^\s*\(working copy\): \t\t(.*)$/
         curr_add = ($current == linecount) ? ' current_line' : ''

         puts  '<tr><td class="linecol">'+ linecount.to_s + "</td>\n" +
               '<td class="revcol'+curr_add+"\">wc</td>\n" +
               '<td class="namecol'+curr_add+"\"></td>\n" +
               '<td class="codecol'+curr_add+'"><a href="' +
                  make_tm_link( $full_file, linecount) +'"'+$close+'>'+ htmlize( $1 ) +
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
