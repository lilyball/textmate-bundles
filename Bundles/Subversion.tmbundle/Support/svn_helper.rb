# just some small methods and some exceptions to help
# with converting some of the svn command outputs to html.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


module SVNHelper   
   # (log) raised, if the maximum number of log messages is shown.
   class LogLimitReachedException < StandardError; end
   
   # (log) thrown when a parser ended in a state that wasn't expected
   class UnexpectedFinalStateException < StandardError; end
   
   # (all) raised if the 'parser' gets a line
   # which doesnt match a certain scheme or wasnt expected
   # in a special state.
   class NoMatchException < StandardError; end
   
   # (all) if we should go in error mode
   class SVNErrorException < StandardError; end
   
   
   # makes a txmt-link for the html output, the line arg is optional.
   def make_tm_link( filename, line=nil )
      encoded_file_url = ''
      ('file://'+filename).each_byte do |b|
         if b.chr =~ /\w/
            encoded_file_url << b.chr
         else
            encoded_file_url << sprintf( '%%%02x', b )
         end
      end
      
      'txmt://open?url=' + encoded_file_url + ((line.nil?) ? '' : '&amp;line='+line.to_s)
   end
   
   
   # subsitutes some special chars for showing html..
   def htmlize( string, blow_up_spaces = true, tab_size = $tab_size )
      return string.to_s.gsub( /<|>|&| |\t/ ) do |match|
         case match
            when '<';  '&lt;'
            when '>';  '&gt;'
            when '&';  '&amp;'
            when ' ';  (blow_up_spaces) ? '&zwj;&#32;&zwj;' : ' '
            when "\t"; ((blow_up_spaces) ? '&zwj;&#32;&zwj;' : ' ')*tab_size
            else; raise 'this should never happen!'
         end
      end   
   end
   
   
   # formates you date (input should be a standart svn date)
   # if format is nil it just gives you back the current date
   def formated_date( input, format=$date_format )
      if not format.nil? and input =~ /^\s*(\d+)-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2}) .+$/
         #            year     month    day      hour     minutes  seconds
         Time.mktime( $1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i ).strftime( format )
      else
         input
      end
   end
   
   
   # produces a generic header..
   def make_head( title='', styles=Array.new, head_adds=''  )
      puts '<html><head><title>'+title+'</title>'
      puts '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
      puts '<style type="text/css">'
      
      styles.each do |style|
         puts "   @import 'file://"+style+"';"
      end
      
      puts '</style>'+head_adds+'</head><body><h1>'+title+'</h1><hr />'
   end
   
   # .. and this a simple, matching footer ..
   def make_foot( foot_adds='' )
      puts foot_adds+'</body></html>'
   end
   
   
   # the same as the above 2 methods, just for errors.
   def make_error_head( title='', head_adds='' )
      puts '<div class="error"><h2>'+title+'</h2>'+head_adds
   end
   
   # .. see above.
   def make_error_foot( foot_adds='' )
      puts foot_adds+'</div>'
   end
   
   
   # used to handle the normal exceptions like
   # NoMatchException, SVNErrorException and unknown exceptions.
   def handle_default_exceptions( e, stdin=$stdin )
   	case e
   	when NoMatchException
         make_error_head( 'No Match' )
         
         puts 'mhh, something with with the regex or svn must be wrong.  this should never happen.<br />'
         puts "last line: <em>#{htmlize($!)}</em><br />please bug-report."
         
         make_error_foot()
         
      when SVNErrorException
         make_error_head( 'SVN Error', htmlize( $! )+'<br />' )
         stdin.each_line { |line| puts htmlize( line )+'<br />' }
         make_error_foot()
         
      when UnexpectedFinalStateException
         make_error_head('Unexpected Final State')
         puts 'the parser ended in the final state <em>'+ $! +'</em>, this shouldnt happen. <br /> please bug-report.'
         make_error_foot
         
      # handle unknown exceptions..
      else
         make_error_head( e.class.to_s )
         
         puts 'reason: <em>'+htmlize( $! )+'</em><br />'
         trace = ''; $@.each { |e| trace+=htmlize('  '+e)+'<br />' }
         puts 'trace: <br />'+trace
         
         make_error_foot()
         
      end #case
      
   end #def handle_default_exceptions
   
   
   # used when throwing a NoMatchException to also tell the state,
   # because you can only pass 1 string to raise you have to cat them together.
   def merge_line_and_state( line, state )
      "\"#{line}\" in state :#{state}"
   end
   
end #module SVNHelper
