
# Includes
support = ENV['TM_SUPPORT_PATH']
require (support + "/bin/Builder.rb")
require (support + "/bin/shelltokenize.rb")

# Arguments
bundle				= ENV['TM_BUNDLE_SUPPORT']
work_path			= ENV['WorkPath']
work_paths			= TextMate.selected_paths_array
ignore_file_pattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/



strip_path_prefix	= work_path # Dir.pwd
svn			= ENV['TM_SVN']
svn = "svn" if svn.nil?

work_path = work_paths[0] if work_path.nil? and (not work_paths.nil?) and (work_paths.size == 1)
work_path ||= '(selected files)'

#
# Status or update?
#
$is_status = false

ARGV.each {|arg| $is_status = true if arg == "--status"}

command_name = if $is_status then
	"status"
else
	"update"
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
	
	def td_status!(status)
		status_column_count.times do |i|
			
			c = status[i].chr
			status_class = StatusMap[c] || 'dunno'
			td(c, "class" => status_class, "title" => StatusColumnNames[i] + " " + status_class.capitalize)
		end
	end
end

mup.html {
	mup.head {
			mup.title("Subversion #{command_name.capitalize}")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_status_style.css';", "type" => "text/css")
	}

	mup.body {
		mup.h1 do 
			mup.img( :src => "file://"+bundle+"/Stylesheets/subversion_logo.tiff",
						:height => 21,
						:width => 32 )
			mup.text " #{command_name.capitalize} for "
			mup << "&ldquo;"
			mup.text "#{File.basename(work_path)}"
			mup << "&rdquo;"
		end
#		mup.hr
#		mup.div("class" => "command"){ mup.strong("#{svn} #{command_name}"); mup.text!(" " + work_path) } #mup.text!("checking "); 
		STDOUT.flush
		
		mup.div( "class" => "section" ) do
			mup.table("class" => "status") {
			
				match_columns		= '.' * mup.status_column_count
				unknown_file_status	= '?' + (' ' * (mup.status_column_count - 1))
			
				STDIN.each_line do |line|
				
					# ignore lines consisting only of whitespace
					next if line.squeeze.strip.empty?
					
					# build the row
					mup.tr {
						if /^svn:/.match( line ).nil? then
							match = /^(#{match_columns})(?:\s+)(.*)\n/.match( line )
							if match.nil? then
								mup.td(:colspan => (mup.status_column_count + 1).to_s ) do
									mup.div(:class => 'info') { mup.text(line) }
								end
							else
								status	= match[1]
								file	= match[2]

								if status == unknown_file_status and ignore_file_pattern =~ file
								    # This is a file that we don't want to know about
								    nil
								else
	    							mup.td_status!(status)
	    							mup.td { mup.a( file.sub( /^#{strip_path_prefix}\//, ""), "href" => 'txmt://open?url=file://' + file, "class" => "pathanme" ) }
	                            end
							end 
						else
							mup.td { mup.div( line, "class" => "error" ) }
						end
					}
				end
			}
		end
	}
}
