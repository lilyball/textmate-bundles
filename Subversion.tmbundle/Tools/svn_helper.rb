# just some small methods and some exceptions to help
# with converting some of the svn command outputs to html.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


module SVNHelper   
   # (log) raised, if the maximum number of log messages is shown.
   class LogLimitReachedException < StandardError; end
   
   # (both) raised if the 'parser' gets a line
   # which doesnt match a certain scheme or wasnt expected
   # in a special state.
   class NoMatchException < StandardError; end
   
   # (both) if we should go in error mode
   class SVNErrorException < StandardError; end
   
   
   # makes a link for the tm html output..
   def make_tm_link( filename, line )
      'txmt://open?url=file://' + filename + '&amp;line=' + line.to_s
   end
   
   # subsitutes some special chars for showing html..
   def htmlize( string, tab_size = $tab_size )
      return string.to_s.gsub( /\<|\>|&| |\t/ ) do |match|
         case match
            when '<';  '&lt;'
            when '>';  '&gt;'
            when '&';  '&amp;'
            when ' ';  '&nbsp;'
            when "\t"; '&nbsp;'*tab_size
         end
      end   
   end
   
   # produces a generic header..
   def make_head( title='', styles=Array.new, head_adds=''  )
      puts '<html><head><title>'+title+'</title>'
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
   
end #module SVNHelper
