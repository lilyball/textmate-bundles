
# Includes
support = ENV['TM_SUPPORT_PATH']
require (support + "/lib/Builder.rb")
require (support + "/lib/shelltokenize.rb")
require (support + "/lib/escape.rb")
require "cgi"

# Arguments
bundle				= ENV['TM_BUNDLE_SUPPORT']
work_path			= ENV['WorkPath']
work_paths			= TextMate.selected_paths_array
ignore_file_pattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/

# First escape for use in the shell, then escape for use in a JS string
def e_sh_js(str)
  (e_sh str).gsub("\\", "\\\\\\\\")
end

def shorten_path(path)
	prefix = ENV['WorkPath']
	if prefix.nil?
		work_paths = TextMate.selected_paths_array
		prefix = work_paths.first unless work_paths.nil? || work_paths.size != 1
	end

	if prefix && prefix == path
		File.basename(path)
	elsif prefix
		File.expand_path(path).gsub(/#{Regexp.escape prefix}\//, '')
	else
		File.expand_path(path).gsub(/#{Regexp.escape File.expand_path('~')}/, '~')
	end
end

svn = ENV['TM_SVN'] || 'svn'
svn = `which svn`.chomp unless svn[0] == ?/

display_title = work_paths[0] if work_path.nil? and (not work_paths.nil?) and (work_paths.size == 1)
display_title ||= '(selected files)'

#
# Status or update?
#
$is_status		= false
$is_checkout	= false
command_name	= 'update'

ARGV.each do |arg|
	case arg
	when '--status'
		$is_status = true
		command_name = 'status'
	when '--checkout'
		$is_checkout = true
		command_name = 'checkout'
	end
end

mup = Builder::XmlMarkup.new(:target => STDOUT)

class << mup
	
	StatusColumnNames = ['File', 'Property', 'Lock', 'History', 'Switched', 'Repository Lock']
	
	StatusMap = {	'A' => 'added',
					'D' => 'deleted',
					'G' => 'merged',
					'U' => 'updated',
					'M' => 'modified',
					'L' => 'locked',
					'B' => 'broken',
					'R' => 'replaced',
					'C' => 'conflict',
					'!' => 'missing',
					'+' => 'added',
					'"' => 'typeconflict',
					'?' => 'unknown',
					'I' => 'ignored',
					'X' => 'external',
					' ' => 'none'}
	
	# this may be more dynamic in the future
	# it also possibly should not be stashed in mup
	def status_column_count
		# update has three columns vs. up to eight for status as of 1.3.x
		# But, for status, if we assume eight, we might have compatibility
		# issues with earlier versions which had fewer columns (unless they
		# had more padding than I recall). The last three columns seem to be
		# network status-only, so this isn't a big deal for now.
		$is_status ? 5 : 3
	end
	
	def status_colspan
		$is_status ? (status_column_count + 5) : (status_column_count + 1)
	end
	
	def status_map(status)
		StatusMap[status]
	end
	
	def td_status!(status,id)
		status_column_count.times do |i|
			
			c = status[i].chr
			status_class = StatusMap[c] || 'dunno'
			td(c, "class" => "status_col #{status_class}", "title" => StatusColumnNames[i] + " " + status_class.capitalize, :id => "status#{id}")
		end
	end
	
	def button_td!(show, name, onclick)
		lowercase_name = name.downcase
		col_class_name		= lowercase_name + '_col'
		button_class_name	= lowercase_name + '_button'
		td(:class => col_name) {
			if show
				a( name, "href" => '#', "class" => button_class_name, "onclick" => onclick )
			end
		}
	end
end

mup.html {
	mup.head {
			mup.title("Subversion #{command_name.capitalize}")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_status_style.css';", "type" => "text/css")
			js_functions = <<ENDJS #javascript
			<script>
				
					the_filename    = null;
					the_id          = null;
					the_displayname = null;
					the_new_status  = null;
					
					function display_tail(id, className, string){
						
						if(string != null && string != '')
						{
//							tail_id = 'tail_' + id
//							tail_div = document.getElementById(tail_id);
//							if(tail_div == null)
//							{
//								status_div = document.getElementById('commandOutput');
//								tail_div = document.createElement('div');
//								tail_div.setAttribute('id', tail_id);
//								tail_div.setAttribute('class', className);
//								status_div.appendChild(tail_div);
//							}
//
//							tail_div.innerHTML = string;
							string += " \\n";
							document.getElementById('commandOutput').innerHTML += string;
						}
					}
					
					function SVNCommand(cmd, id, statusString, className){
						results        = TextMate.system('LC_CTYPE=en_US.UTF-8 ' + cmd, null)
						
						outputString   = results.outputString;
						// errorString = results.errorString;
						errorCode      = results.status;
						// TM doesn't receive the error stream unless output and error are the same descriptor?
						// display_tail('error', 'error', errorString);
						display_tail('info', 'info', outputString);
						
						if(errorCode == 0)
						{
							document.getElementById('status'+id).innerHTML = statusString;
							document.getElementById('status'+id).className = 'status_col ' + className;
						}
					}
					
					svn_commit = function(){
						TextMate.isBusy = true;
						
						// cmd = 'require_cmd "#{e_sh svn}" "If you have installed svn, then you need to either update your <tt>PATH</tt> or set the <tt>TM_SVN</tt> shell variable (e.g. in Preferences / Advanced)"\\n\\nexport TM_SVN\\nexport CommitWindow="$TM_SUPPORT_PATH/bin/CommitWindow.app/Contents/MacOS/CommitWindow"\\n\\ncd "${TM_PROJECT_DIRECTORY:-$TM_DIRECTORY}"\\n"${TM_RUBY:-ruby}" -- "${TM_BUNDLE_SUPPORT}/svn_commit.rb"'
						cmd = ""
						cmd += 'export LC_CTYPE=en_US.UTF-8 ;';
						#{ %{cmd += "export            TM_SVN=#{ e_sh_js ENV['TM_SVN']            }; ";} if ENV['TM_SVN']            }
						#{ %{cmd += "export TM_BUNDLE_SUPPORT=#{ e_sh_js ENV['TM_BUNDLE_SUPPORT'] }; ";} if ENV['TM_BUNDLE_SUPPORT'] }
						#{ %{cmd += "export   TM_SUPPORT_PATH=#{ e_sh_js ENV['TM_SUPPORT_PATH']   }; ";} if ENV['TM_SUPPORT_PATH']   }
						#{ %{cmd += "export      CommitWindow=#{ e_sh_js ENV['CommitWindow']      }; ";} if ENV['CommitWindow']      }
						#{ %{cmd += "export   TM_SVN_DIFF_CMD=#{ e_sh_js ENV['TM_SVN_DIFF_CMD']   }; ";} if ENV['TM_SVN_DIFF_CMD']   }
						
						cmd += '"#{ENV['TM_RUBY'] || "ruby"}" -- "#{ENV['TM_BUNDLE_SUPPORT']}/svn_commit.rb" "#{work_paths.join("\" \"")}"'
						document.getElementById('commandOutput').innerHTML = TextMate.system(cmd, null).outputString + ' \\n'
						// SVNCommand(cmd, '_commit', '-', 'done')
						
						TextMate.isBusy = false;
					};
					// the filename passed in to the following functions is already properly shell escaped
					diff_to_mate = function(filename,id){
						TextMate.isBusy = true;
						tmp = '/tmp/diff_to_mate' + id + '.diff'
						cmd = 'LC_CTYPE=en_US.UTF-8 #{e_sh svn} 2>&1 diff --diff-cmd diff ' + filename + ' >' + tmp + ' && open -a TextMate ' + tmp
						document.getElementById('commandOutput').innerHTML += TextMate.system(cmd, null).outputString + ' \\n'
						TextMate.isBusy = false;
					};
					svn_add = function(filename,id){
						TextMate.isBusy = true;
						
						cmd = '#{e_sh svn} add ' + filename + ' 2>&1'
						SVNCommand(cmd, id, 'A', '#{mup.status_map('A')}')
						
						TextMate.isBusy = false;
					};
					svn_revert = function(filename,id){
						TextMate.isBusy = true;
						
						cmd = '#{e_sh svn} 2>&1 revert ' + filename;
						SVNCommand(cmd, id, '?', '#{mup.status_map('?')}')
						
						TextMate.isBusy = false;
					};
					svn_revert_confirm = function(filename,id,displayname){
						the_filename    = filename;
						the_id          = id;
						the_displayname = displayname;
						the_new_status  = '?';
						TextMate.isBusy = true;
						cmd = 'LC_CTYPE=en_US.UTF-8 #{e_sh_js ENV['TM_BUNDLE_SUPPORT']}/revert_file.rb -svn=#{e_sh_js svn} -path=' + filename + ' -displayname=' + displayname;
						myCommand = TextMate.system(cmd, function (task) { });
						myCommand.onreadoutput = svn_output;
					};
					svn_remove = function(filename,id,displayname){
						the_filename    = filename;
						the_id          = id;
						the_displayname = displayname;
						the_new_status  = 'D';
						TextMate.isBusy = true;
						cmd = 'LC_CTYPE=en_US.UTF-8 #{e_sh_js ENV['TM_BUNDLE_SUPPORT']}/remove_file.rb -svn=#{e_sh_js svn} -path=' + filename + ' -displayname=' + displayname;
						myCommand = TextMate.system(cmd, function (task) { });
						myCommand.onreadoutput = svn_output;
					};
					svn_output = function(str){
						display_tail('info', 'info', str);
						document.getElementById('status'+the_id).innerHTML = the_new_status;
						if(the_new_status == '-'){document.getElementById('status'+the_id).className = 'status_col #{mup.status_map('-')}'};
						if(the_new_status == 'D'){document.getElementById('status'+the_id).className = 'status_col #{mup.status_map('D')}'};
						TextMate.isBusy = false;
						the_filename    = null;
						the_id          = null;
						the_displayname = null;
						the_new_status  = null;
					};
					finder_open = function(filename,id){
						TextMate.isBusy = true;
						cmd = "open 2>&1 " + filename;
						output = TextMate.system(cmd, null).outputString;
						display_tail('info', 'info', output);
						TextMate.isBusy = false;
					};
				</script>
ENDJS
			mup << js_functions
	}

	mup.body {
		mup.h1 do 
			mup.img(	:src => "file://"+bundle+"/Stylesheets/subversion_logo.tiff",
						:height => 21,
						:width => 32 )
			mup << " #{command_name.capitalize} for "
			mup << "&ldquo;"
			mup << "#{File.basename(display_title)}"
			mup << "&rdquo;"
		end
#		mup.hr
#		mup.div("class" => "command"){ mup.strong("#{svn} #{command_name}"); mup.text!(" " + display_title) } #mup.text!("checking "); 
		STDOUT.flush
		
		mup.div( "class" => "section" ) do
			mup.table("class" => "status") {
			
				match_columns       = '.' * mup.status_column_count
				unknown_file_status = '?' + (' ' * (mup.status_column_count - 1))
				missing_file_status = '!' + (' ' * (mup.status_column_count - 1))
				added_file_status   = 'A' + (' ' * (mup.status_column_count - 1))
			
				stdin_line_count = 1
				STDIN.each_line do |line|
				
					# ignore lines consisting only of whitespace
					next if line.squeeze.strip.empty?
					# build the row
					mup.tr {
						if /^svn:/.match( line ).nil? then
							match = /^(#{match_columns})(?:\s+)(.*)\n/.match( line )
							if match.nil? then
								# Informational text, not status
								mup.td(:colspan => (mup.status_colspan).to_s ) do
									mup.div(:class => 'info') { mup.text(line) }
								end
							else
								status          = match[1]
								file            = match[2]
								esc_file        = '&quot;' + CGI.escapeHTML(e_sh_js(file).gsub(/(?=")/, '\\')) + '&quot;'
								esc_displayname = '&quot;' + CGI.escapeHTML(e_sh_js(shorten_path(file)).gsub(/(?=")/, '\\')) + '&quot;'

								# Skip files that we don't want to know about
								next if (status == unknown_file_status and ignore_file_pattern =~ file)
								
								# Status string
								mup.td_status!(status, stdin_line_count)
								
								# Add, Revert, etc buttons
								if $is_status
									# ADD Column 
									mup.button_td!((status == unknown_file_status),
													'Add',
													"svn_add(#{esc_file},#{stdin_line_count}); return false")

									# REVERT Column 
									mup.button_td!((status != unknown_file_status),
													'Revert',
													"svn_revert#{"_confirm" unless status == added_file_status}(#{esc_file},#{stdin_line_count},#{esc_displayname}); return false")

									# REMOVE Column 
									mup.button_td!((status == missing_file_status),
													'Remove',
													"svn_remove(#{esc_file},#{stdin_line_count},#{esc_displayname}); return false")

									# DIFF Column
									if file.match(/\.(png|gif|jpe?g|psd|tif?f|zip|rar)$/i)
										onclick        = "finder_open(#{esc_file},#{stdin_line_count}); return false"
										column_is_an_image = true
									else
										onclick        = ""
										# Diff Column (only available for text)
										column_is_an_image = false
									end

									mup.button_td!( ((not column_is_an_image) and (status != unknown_file_status)),
													'Diff',
													"diff_to_mate(#{esc_file},#{stdin_line_count}); return false")
								end

								# FILE Column
								mup.td(:class => 'file_col') {
										mup.a( shorten_path(file), "href" => 'txmt://open?url=file://' + (e_url file), "class" => "pathname", "onclick" => onclick )
								}
							end 
						else
							mup.td { mup.div( line, "class" => "error" ) }
						end
					}
					mup << "\n"
					stdin_line_count += 1
				end
			}
		end
		
		if $is_status then
			mup.div(:id => 'actions'){
				mup.a('Commit', :href => '#', :onclick => 'svn_commit(); return false')
				mup.div(:style => 'clear:both'){}
			}
		end
		
		mup.div(:id => 'commandOutput'){
			mup << " "
			#DEBUG# mup << display_title + "\n"
			#DEBUG# ENV.sort.each { |key,value| puts key + ' = ' + value + "\n" }
		}
	}
}
