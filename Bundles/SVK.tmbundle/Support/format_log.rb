# 'parses' the output of svk log and makes html out of
# it, which it shows you.  should also be compatible to ruby-1.6.8.
#
# TODO: the script to call svk that pipes into this only works with one file
# 
# copyright 2005 david glasser <glasser@mit.edu>
# based on svn version:
#   copyright 2005 torsten becker <torsten.becker@gmail.com>
#   no warranty, that it doesn't crash your system.
#   you are of course free to modify this.


# fetch some tm things or set useful defaults..
$tab_size      = ENV['TM_TAB_SIZE'].to_i
$bundle        = ENV['TM_BUNDLE_SUPPORT']
$limit         = ENV['TM_SVK_LOG_LIMIT'].nil?   ? 9 : ENV['TM_SVK_LOG_LIMIT'].to_i
$date_format   = ENV['TM_SVK_DATE_FORMAT'].nil? ? nil : ENV['TM_SVK_DATE_FORMAT']
$sort_order    = [ :added, :modified, :deleted, :none ]

# require the helper, it does some formating, etc:
require $bundle+'/svk_helper.rb'
include SVKHelper


msg_count      = 0      # used to count messages and to show tables in alternate colors
comment_count  = 0      # used to count the lines of comments
rev            = ''     # the last fetched revision
max_lines      = 0      # the maximum number of lines
already_shown  = []     # to supress double messages (they could happen if you selected multiple files)
skipped_files  = false  # to remember this
changed_files  = []     # just a array to sort the files

# about the states of the 'parser':
#  skipped_files  if we wait for some Skipped: messages at the beginning (I don't think this is in svk)
#  seperator      initial state, assuming a ---..
#  info           parsing the info line with rev, name, etc
#  changed_paths  awaiting a changed paths thing or blank line
#  path_list      parsing changed files
#  comment        getting the comment
#  skip_next      if doesnt show the next message because we already did
state = :skipped_files


begin
   make_head( 'SVK Log',
              [ $bundle+'/css/svk_style.css',
                $bundle+'/css/svk_log_style.css'],
              "<script type=\"text/javascript\">\n"+
                 File.open($bundle+'/script/flip_files.js', 'r').readlines.join+'</script>' )
   
   
   $stdin.each_line do |line|
      raise SVKErrorException, line  if line =~ /^svk:/
      
      case state
         when :skipped_files # This is held over from the svn Bundle, I don't think svk uses it
            if line =~ /^-{70}$/
               state = :info
               make_error_foot  if skipped_files
               
            elsif line =~ /^Skipped '(.+)'$/
               unless skipped_files
                  make_error_head('Skipped:')
                  skipped_files = true
               end
               puts '<a href="'+make_tm_link( $1 )+'">'+htmlize($1)+'</a><br />'
               
            else
               raise NoMatchException, line
            end
            
         when :seperator
            raise LogLimitReachedException  if $limit != 0 and msg_count == $limit
            
            if line =~ /^-{70}$/
               state = :info
            else
               raise NoMatchException, line
            end
            
         when :info
            if line =~ /^r([^:]+):  ([A-Za-z_0-9]+) \| (.+)$/
               state      = :changed_paths
               rev        = $1
               
               if already_shown.include? rev.to_i
                  state = :skip_next
                  next
               else
                  already_shown << rev.to_i
               end
               
               
               puts( ((msg_count % 2) == 0) ? '<table class="log">' :
                                              '<table class="log alternate">' )
               msg_count += 1
               
               puts '<tr>  <th>Revision:</th>  <td>'+ $1 +'</td> </tr>'
               puts '<tr>  <th>Author:</th>    <td>'+ $2 +'</td> </tr>'
               puts '<tr>  <th>Date:</th>      <td>'+ htmlize( formated_date( $3 ), false ) +'</td></tr>'
               puts '<tr>  <th>Changed Files:</th><td>'
               
               puts '<a id="r'+$1+'_show" href="javascript:show_files(\'r'+$1+'\');">show</a>'
               puts '<a id="r'+$1+'_hide" href="javascript:hide_files(\'r'+$1+'\');" class="hidden">hide</a>'
               
               puts '<ul id="r'+$1+'" class="hidden">'
               
            else
               raise NoMatchException, line
            end
            
         when :changed_paths
            if line =~ /^Changed paths:$/
               state = :path_list
            elsif line =~ /^\s*$/
               state = :comment
            else
               raise NoMatchException, line
            end
            
         when :path_list
            if line =~ /^\s*$/
               state = :comment
            elsif line =~ /^  ([AMD ])([AMD ]) (.+)$/
               op = case $1
                       when 'A'; :added
                       when 'M'; :modified
                       when 'D'; :deleted
                       when ' '; :none
                    end
                       
               propop = case $2
                      when 'A'; :added
                      when 'M'; :modified
                      when 'D'; :deleted
                      when ' '; :none
                   end
               
               changed_files << [ op, propop, $3 ]
               
            else
               raise NoMatchException, line
            end
            
         when :comment
            unless changed_files.empty?
               changed_files.sort! do |a, b|
                  $sort_order.index( a[0] ) <=> $sort_order.index( b[0] )
                  # TODO: should do a secondary sort based on prop op
               end
               
               changed_files.each do |path|
                  puts '  <li class="'+path[0].to_s+'_'+path[1].to_s+'">'+path[2]+"</li>"
               end
               
               changed_files = []
            end
            
            if line =~ /^-{70}$/
               if comment_count > 0
                  puts "</td></tr></table>\n\n"
               end
               state = :info
               comment_count = 0
               next
            end
            
            if comment_count == 0
               puts '</ul></td></tr>'
               puts '<tr> <th>Message:</th> <td class="msg_field">'   
            end
            
            puts htmlize(line)+'<br />'
            
            comment_count += 1
                        
         when :skip_next
            state = :info  if line =~ /^-{70}$/
            
         else
            raise 'unknown state: '+state.to_s
            
      end #case state
      
   end #each_line
   
rescue LogLimitReachedException
rescue => e
   handle_default_exceptions( e )
ensure
   make_foot()
end
