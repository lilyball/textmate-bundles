require 'English' # you are angry, english!

svn				= ENV['TM_SVN']
#commit_paths	= ENV['CommitPaths']
commit_tool		= ENV['CommitWindow']
bundle			= ENV['TM_BUNDLE_SUPPORT']
support			= ENV['TM_SUPPORT_PATH']

IgnoreFilePattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/

CURRENT_DIR		= Dir.pwd + "/"

require (support + '/bin/shelltokenize.rb')
require (support + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

mup.html {
	mup.head do
			mup.title("Subversion Commit")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_status_style.css';", "type" => "text/css")
	end

	mup.body { 
		mup.h1 do 
			mup.img( :src => "file://"+bundle+"/Stylesheets/subversion_logo.tiff",
						:height => 21,
						:width => 32 )
			mup.text " Commit"
		end
		
		STDOUT.flush

		mup.div( :class => 'section' ) do

			# Ignore files without changes
#puts TextMate::selected_paths_for_shell
			status_command = %Q{"#{svn}" status #{TextMate::selected_paths_for_shell}}
#puts status_command
			status_output = %x{#{status_command}}
#puts status_output
			paths = status_output.scan(/^(.....)(\s+)(.*)\n/)

			def matches_to_paths(matches)
				paths = matches.collect {|m| m[2] }
				paths.collect{|path| path.sub(/^#{CURRENT_DIR}/, "") }
			end

			def matches_to_status(matches)
				# collect the status, and replace prefix spaces with underscores so command-line argument passing works later
				matches.collect {|m| m[0]}.map {|m| m.rstrip.gsub(/\s/, '_')}
			end

			def select_files_with_status_prefix(paths, char, exclude_ignores = false)
				paths.select do |m|
					index = m[0].index(char)
					select_it = (index != nil) and (index == 0) 
					if select_it and exclude_ignores
						select_it = (not IgnoreFilePattern =~ m[2])
					end
					select_it
				end
			end

			# Ignore files with '?', but report them to the user String.index
			unknown_paths = select_files_with_status_prefix(paths, '?', true)
	        unknown_to_report_paths = select_files_with_status_prefix(paths, '?', false)
			if unknown_to_report_paths and unknown_to_report_paths.size > 0 then
				mup.div( "class" => "info" ) {
					mup.text! "These files are not under version control, and so will not be committed:"		
					mup.ul{ matches_to_paths(unknown_to_report_paths).each{ |path| mup.li(path) } }
				}
			end

			# Ignore files with '!', but report them to the user
			missing_paths = select_files_with_status_prefix(paths, '!', true)
	        missing_to_report_paths = select_files_with_status_prefix(paths, '!', false)
			if missing_to_report_paths and missing_to_report_paths.size > 0 then
	    
				mup.div( "class" => "info" ) {
					mup.text! "These files are missing from the working copy:"		
					mup.ul{ matches_to_paths(missing_to_report_paths).each{ |path| mup.li(path) } }
				}
			end

			# Fail if we have conflicts -- svn commit will fail, so let's
			# error out before the user gets too involved in the commit
			conflict_paths = select_files_with_status_prefix(paths, 'C', false)

			if conflict_paths and conflict_paths.size > 0 then
				mup.div( "class" => "error" ) {
					mup.text! "Cannot continue; there are merge conflicts in files:"		
					mup.ul{ matches_to_paths(conflict_paths).each{ |path| mup.li(path) } }
					mup.text! "Canceled."
				}	
				exit -1
			end

			# Remove the unknown paths from the commit
			commit_matches = paths - unknown_paths

			# Remove the missing paths from the commit
			commit_matches = commit_matches - missing_paths

			if commit_matches.nil? or commit_matches.size == 0
				mup.div( "class" => "info" ) {
					mup.text! "File(s) not modified; nothing to commit."
					mup.ul{ matches_to_paths(unknown_paths).each{ |path| mup.li(path) } }
				}
				exit 0
			end

			STDOUT.flush

			commit_paths_array = matches_to_paths(commit_matches)
			commit_status = matches_to_status(commit_matches).join(":")

			commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")

			commit_args = %x{"#{commit_tool}" --diff-cmd "#{svn}" --status #{commit_status} #{commit_path_text}}

			status = $CHILD_STATUS
			if status != 0
				mup.div( "class" => "error" ) {
					mup.text! "Canceled (#{status >> 8})."
				}	
				exit -1
			end

			mup.div("class" => "command"){ mup.strong(%Q{#{svn} commit}); mup.text!(commit_args) }
	
			mup.pre {
				STDOUT.flush

				IO.popen("#{svn} commit --non-interactive --force-log #{commit_args}", "r+") do |pipe|
					pipe.each {|line| mup.text! line }
				end
			}
		end
	}
}

