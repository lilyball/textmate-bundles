# 'parses' the output of svn log and makes html out of
# it, which it shows you.  should also be compatible to ruby-1.6.8.
# 
# copyright 2005 torsten becker <torsten.becker@gmail.com>
# no warranty, that it doesn't crash your system.
# you are of course free to modify this.


# fetch some tm things..
$tab_size   = ENV['TM_TAB_SIZE'].to_i
$bundle     = ENV['TM_BUNDLE_PATH']
$limit      = ENV['TM_SVN_LOG_LIMIT'].nil? ? 7 : ENV['TM_SVN_LOG_LIMIT'].to_i  # set default if none set
$full_file  = ENV['TM_FILEPATH']


# require the helper, it does some formating, etc:
require $bundle+'/Tools/svn_helper.rb'
include SVNHelper


msg_count      = 0   # used to count messages and to show tables in alternate colors
comment_count  = 0   # used to count the lines of comments
rev            = ''  # the last fetched revision
max_lines      = 0   # the maximum number of lines

# about the states of the 'parser':
#   seperator      initial state, assuming a ---..
#   info           parsing the info line with rev, name, etc
#   changed_paths  awaiting a changed paths thing or blank line
#   path_list      parsing changed files
#   comment        getting the comment
state = :seperator


begin
   make_head( "Subversion log for '"+$full_file.sub( /^.*\//, '')+"'",
              [ $bundle+'/Stylesheets/svn_style.css',
                $bundle+'/Stylesheets/svn_log_style.css'],
              '<script src="file://'+$bundle+'/Tools/flip_files.js'+'" />' )
   
   
   $stdin.each_line do |line|
      raise SVNErrorException, line  if line =~ /^svn:/ or line =~ /^Skipped/
      
      case state
         when :seperator
            raise LogLimitReachedException  if $limit != 0 and msg_count == $limit
            
            if line =~ /^-{72}$/
               puts( ((msg_count % 2) == 0) ? '<table class="log_msg">' :
                                              '<table class="log_msg alternate">' )
               state      = :info
               msg_count += 1
               
            else
               raise NoMatchInStateException, line
            end
            
         when :info
            if line =~ /^r(\d+) \| ([A-Za-z_0-9]+) \| (.+) \| (\d+) lines?$/
               state     = :changed_paths
               rev       = $1
               max_lines = $4.to_i
               
               puts '<tr>  <th>Revision:</th>  <td>'+ $1 +'</td> </tr>'
               puts '<tr>  <th>Author:</th>    <td>'+ $2 +'</td> </tr>'
               puts '<tr>  <th>Date:</th>      <td>'+ htmlize($3) +'</td></tr>'
               puts '<tr>  <th>Changed Files:</th><td>'
               
               puts '<a id="r'+$1+'_show" href="javascript:show_files(\'r'+$1+'\');">show</a>'
               puts '<a id="r'+$1+'_hide" href="javascript:hide_files(\'r'+$1+'\');" class="hidden">hide</a>'
               
               puts '<ul id="r'+$1+'" class="hidden">'
               
            else
               raise NoMatchInStateException, line
            end
            
         when :changed_paths
            if line =~ /^Changed paths:$/
               state = :path_list
            elsif line =~ /^\s*$/
               state = :comment
            else
               raise NoMatchInStateException, line
            end
            
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
               raise NoMatchInStateException, line
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
            
         else
            raise UnknownStateException, line
            
      end #case state
      
   end #each_line
   
rescue LogLimitReachedException
rescue SVNErrorException
   puts '<div class="generic_error"><h2>SVNError</h2>'+ htmlize( $! )+'<br />'
   $stdin.each_line { |line| puts htmlize( line )+'<br />' }
   puts '</div>'
   
rescue UnknownStateException, NoMatchInStateException => e
   puts '<div class="generic_error"><h2>'+e.class.to_s.gsub( /^.+::(.+)Exception$/, '\1')+'</h2>'
   puts 'state: <em>'+state.to_s+'</em><br />'
   puts 'line:&nbsp; <em>'+htmlize( $! )+'</em><br />'
   puts '</div>'
   
# catch unknown exceptions..
rescue => e
   puts '<div class="generic_error"><h2>'+e.class.to_s+'</h2>'
   puts 'reason: <em>'+htmlize( $! )+'</em><br />'
   
   # could also be this oneliner in 1.8 but backward-compatibility
   # is more important than fancy code. :)
   # puts 'trace: <br />'+$@.inject('') { |a,b| a + htmlize('  '+b) + '<br />' }
   
   trace = ''; $@.each { |e| trace += htmlize( '  '+e ) + '<br />' }
   puts 'trace: <br />'+trace+'</div>'
   
ensure
   make_foot()
end
