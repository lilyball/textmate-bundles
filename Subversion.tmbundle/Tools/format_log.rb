# 'parses' the output of svn log and makes html out of
# it, which it shows you.  should also be compatible to ruby-1.6.8.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


# fetch some tm things..
$tab_size      = ENV['TM_TAB_SIZE'].to_i
$bundle        = ENV['TM_BUNDLE_PATH']
$limit         = ENV['TM_SVN_LOG_LIMIT'].nil?   ? 9 : ENV['TM_SVN_LOG_LIMIT'].to_i
$date_format   = ENV['TM_SVN_DATE_FORMAT'].nil? ? nil : ENV['TM_SVN_DATE_FORMAT']


# require the helper, it does some formating, etc:
require $bundle+'/Tools/svn_helper.rb'
include SVNHelper


msg_count      = 0      # used to count messages and to show tables in alternate colors
comment_count  = 0      # used to count the lines of comments
rev            = ''     # the last fetched revision
max_lines      = 0      # the maximum number of lines
already_shown  = []     # to supress double messages (they could happen if you selected multiple files)
skipped_files  = false  # to remember this


# about the states of the 'parser':
#  skipped_files  if we wait for some Skipped: messages at the beginning
#  seperator      initial state, assuming a ---..
#  info           parsing the info line with rev, name, etc
#  changed_paths  awaiting a changed paths thing or blank line
#  path_list      parsing changed files
#  comment        getting the comment
#  skip_next      if doesnt show the next message because we already did
state = :skipped_files


begin
   make_head( 'Subversion Log',
              [ $bundle+'/Stylesheets/svn_style.css',
                $bundle+'/Stylesheets/svn_log_style.css'],
              '<script src="file://'+$bundle+'/Tools/flip_files.js'+'" />' )
   
   
   $stdin.each_line do |line|
      raise SVNErrorException, line  if line =~ /^svn:/
      
      case state
         when :skipped_files
            if line =~ /^-{72}$/
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
            
            if line =~ /^-{72}$/
               state = :info
            else
               raise NoMatchException, line
            end
            
         when :info
            if line =~ /^r(\d+) \| ([A-Za-z_0-9]+) \| (.+) \| (\d+) lines?$/
               state      = :changed_paths
               rev        = $1
               max_lines  = $4.to_i
               
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
            
         # TODO: make this caching and show a sorted list..
         when :path_list
            if line =~ /^\s+([A-Z]) (.+)$/
               op = case $1
                       when 'A'; 'added'
                       when 'M'; 'modified'
                       when 'D'; 'deleted'
                       else;     'unknown'
                    end
               
               puts '  <li class="'+op+'">'+$2+"</li>\n"
               
            elsif line =~ /^\s*$/
               state = :comment
            else
               raise NoMatchException, line
            end
            
         when :comment
            if comment_count == 0
               puts '</ul></td></tr>'
               puts '<tr> <th>Message:</th> <td class="msg_field">'
               
            end
            
            puts htmlize(line)+'<br />'  if comment_count < max_lines
            
            comment_count += 1
            
            if comment_count == max_lines
               state          = :seperator
               comment_count  = 0
               
               puts "</td></tr></table>\n\n"
            end
            
         when :skip_next
            state = :info  if line =~ /^-{72}$/
            
         else
            raise 'unknown state: '+state.to_s
            
      end #case state
      
   end #each_line
   
rescue LogLimitReachedException
rescue SVNErrorException
   make_error_head( 'SVNError', htmlize( $! )+'<br />' )
   $stdin.each_line { |line| puts htmlize( line )+'<br />' }
   make_error_foot()
   
rescue NoMatchException
   make_error_head( 'NoMatch' )
   
   puts 'state: <em>'+state.to_s+'</em><br />'
   puts 'line:&nbsp; <em>'+htmlize( $! )+'</em><br />'
   
   make_error_foot()
   
# catch unknown exceptions..
rescue => e
   make_error_head( e.class.to_s )
   
   puts 'reason: <em>'+htmlize( $! )+'</em><br />'
   trace = ''; $@.each { |e| trace+=htmlize('  '+e)+'<br />' }
   puts 'trace: <br />'+trace
   
   make_error_foot()
   
ensure
   make_foot()
end
