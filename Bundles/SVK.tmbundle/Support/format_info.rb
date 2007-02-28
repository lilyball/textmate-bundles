# formats svk info, could maybe done shorter but I
# started writing seperate scripts and will continiue this.
# 
# copyright 2005 david glasser <glasser@mit.edu>
# based on svn version:
#   copyright 2005 torsten becker <torsten.becker@gmail.com>
#   no warranty, that it doesn't crash your system.
#   you are of course free to modify this.


# fetch some tm things..
$bundle        = ENV['TM_BUNDLE_SUPPORT']
$show          = ENV['TM_SVK_INFO_SHOW'].nil? ? [] :
                   ENV['TM_SVK_INFO_SHOW'].split(/\s*,\s*/).each { |s| s.downcase! }
$hide          = ENV['TM_SVK_INFO_HIDE'].nil? ? [] :
                   ENV['TM_SVK_INFO_HIDE'].split(/\s*,\s*/).each { |s| s.downcase! }
$date_format   = ENV['TM_SVK_DATE_FORMAT'].nil? ? nil : ENV['TM_SVK_DATE_FORMAT']
$hide_all      = ($hide.include? '*') ? true : false

# find out if the window should get closed on a click
$close      = ENV['TM_SVK_CLOSE'].nil? ? '' : ENV['TM_SVK_CLOSE']
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


# to keep track of alternating rows:
count_dl = 0

# to keep track if we must close somthing:
got_newline = true

begin
   make_head( 'SVK Info',
              [ $bundle+"/css/svk_style.css",
                $bundle+"/css/svk_info_style.css"] )
   
   
   $stdin.each_line do |line|
      raise SVKErrorException, line  if line =~ /^svk:/
      
      if line =~ /^\s*$/
         puts "</dl>\n\n"
         got_newline  = true
         count_dl    += 1
         
      elsif line =~ /^(.+?):\s*(.*)$/
         if got_newline
            puts( ((count_dl % 2) == 0) ? '<dl class="info">' : '<dl class="info alternate">' )
            got_newline = false
            
         end
         
         if $2 == '(Not a versioned resource)'
            make_error_head( 'Not a versioned resource:' )
            make_error_foot( '<a href="'+make_tm_link( $1 )+'">'+htmlize($1, false)+'</a>' )
            count_dl -= 1
            
         else
            to_search = $1.downcase
            next  if $hide.include? to_search or
                     $hide_all and not $show.include? to_search
            
            
            if $1 == 'Checkout Path'
               dt = 'Checkout Path'
               dd = '<a href="'+make_tm_link( $2 )+'"'+$close+'>'+htmlize($2, false)+'</a>'
            else
               dt = htmlize( $1, false )
               dd = htmlize( $2, false )
            end
            
            puts '<dt>'+dt+'</dt>'
            puts '<dd>'+dd+'</dd>'
            
         end #if
         
      else
         raise NoMatchException, line
      end
      
   end #each_line
   
rescue => e
   handle_default_exceptions( e )
ensure
   make_foot( '</dl>' )
end
