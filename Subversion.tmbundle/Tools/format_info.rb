# formats svn info, could maybe done shorter but I
# started writing seperate scripts and will continiue this.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


# fetch some tm things..
$bundle = ENV['TM_BUNDLE_PATH']


# require the helper, it does some formating, etc:
require $bundle+'/Tools/svn_helper.rb'
include SVNHelper


# to keep track of alternating rows..
count_dl = 0
count_dd = 0

# to keep track if we must close somthing:
got_newline = true

begin
   make_head( 'Subversion info',
              [ $bundle+"/Stylesheets/svn_style.css",
                $bundle+"/Stylesheets/svn_info_style.css"] )
   
   
   $stdin.each_line do |line|
      raise SVNErrorException, line  if line =~ /^svn:/
      
      if line =~ /^\s*$/
         puts "</dl>\n\n"
         got_newline  = true
         count_dl    += 1
         
      elsif line =~ /^(.+?):\s*(.*)$/
         if got_newline
#            puts( (count == 0) ? '' : '<hr />' )
            puts( ((count_dl % 2) == 0) ? '<dl class="info">' : '<dl class="info alternate">' )
            got_newline = false
            
         end
         
         if $2 == '(Not a versioned resource)'
            make_error_head( 'Not a versioned resource:' )
            make_error_foot( '<a href="'+make_tm_link( htmlize($1, false) )+'">'+htmlize($1, false)+'</a>' )
            
         else
            if $1 == 'Path'
               dt = 'Path'
               dd = '<a href="'+make_tm_link( htmlize($2, false) )+'">'+htmlize($2, false)+'</a>'
               
            elsif $1 == 'URL'
               dt = 'URL'
               dd = '<a href="'+htmlize($2, false)+'" target="_blank">'+htmlize($2, false)+'</a>'
               
            else
               dt = htmlize( $1, false )
               dd = htmlize( $2, false )
               
            end
            
            puts( (((count_dd % 2) == 1) ? '<dt>' : '<dt class="alternate">')+dt+'</dt>' )
            puts( (((count_dd % 2) == 1) ? '<dd>' : '<dd class="alternate">')+dd+'</dd>' )
            
         end
         
         count_dd += 1
         
      else
         raise NoMatchException, line
      end
      
   end #each_line
   
rescue SVNErrorException
   make_error_head( 'SVNError', htmlize( $! )+'<br />' )
   $stdin.each_line { |line| puts htmlize( line )+'<br />' }
   make_error_foot()
   
rescue NoMatchException
   make_error_head( 'NoMatch' )
   
   puts 'mhh, something with with the regex or svn must be wrong.  this should never happen.<br />'
   puts 'last line: <em>'+htmlize( $! )+'</em><br />please bug-report.'
   
   make_error_foot()
   
# catch unknown exceptions..
rescue => e
   make_error_head( e.class.to_s )
   
   puts 'reason: <em>'+htmlize( $! )+'</em><br />'
   trace = ''; $@.each { |e| trace+=htmlize('  '+e)+'<br />' }
   puts 'trace: <br />'+trace
   
   make_error_foot()
   
ensure
   make_foot( '</dl>' )
end
