# just some small methods to help with converting
# the svn command output to html.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this. :)


module SVNHelper
   class NoMatchException < StandardError; end
   class SVNErrorException < StandardError; end
   
   def make_tm_link( filename, line )
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
   
end #module SVNHelper
