require 'English' # you are angry, english!

svk				= ENV['TM_SVK']
#commit_paths	= ENV['CommitPaths']
commit_tool		= ENV['CommitWindow']
bundle			= ENV['TM_BUNDLE_SUPPORT']

CURRENT_DIR		= Dir.pwd + "/"

require ENV['TM_SUPPORT_PATH'] + '/lib/shelltokenize.rb'
require ENV['TM_BUNDLE_SUPPORT'] + '/lib/Builder.rb'

mup = Builder::XmlMarkup.new(:target => STDOUT)

mup.html {
	mup.head {
			mup.title("SVK status")
			mup.style( "@import 'file://"+bundle+"/css/svk_style.css';", "type" => "text/css")
	}

	mup.body { 
 		mup.h1("SVK Commit")
		STDOUT.flush
		mup.hr

		# Ignore files without changes
#puts TextMate::selected_paths_for_shell
		status_command = %Q{"#{svk}" status #{TextMate::selected_paths_for_shell}}
#puts status_command
		status_output = %x{#{status_command}}
#puts status_output
		paths = status_output.scan(/^(.).. (.*)\n/)


		def matches_to_paths(matches)
			paths = matches.collect {|m| m[1] }
			paths.collect{|path| path.sub(/^#{CURRENT_DIR}/, "") }
		end

		# Ignore files with '?', but report them to the user
		unknown_paths = paths.select { |m| m[0] == '?' }

		if unknown_paths and unknown_paths.size > 0 then
			mup.div( "class" => "info" ) {
				mup.text! "These files are not added to the repository, and so will not be committed:"		
				mup.ul{ matches_to_paths(unknown_paths).each{ |path| mup.li(path) } }
			}
		end

		# Fail if we have conflicts -- svk commit will fail, so let's
		# error out before the user gets too involved in the commit
		conflict_paths = paths.select { |m| m[0] == 'C' }

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

		if commit_matches.nil? or commit_matches.size == 0
			mup.div( "class" => "info" ) {
				mup.text! "File(s) not modified; nothing to commit."
				mup.ul{ matches_to_paths(unknown_paths).each{ |path| mup.li(path) } }
			}
			exit 0
		end

		STDOUT.flush

		commit_paths_array = matches_to_paths(commit_matches)

		commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")

		commit_args = %x{"#{commit_tool}" #{commit_path_text}}

		status = $CHILD_STATUS
		if status != 0
			mup.div( "class" => "error" ) {
				mup.text! "Canceled (#{status >> 8})."
			}	
			exit -1
		end

		mup.div("class" => "command"){ mup.strong(%Q{#{svk} commit}); mup.text!(commit_args) }
		
		mup.pre {
			STDOUT.flush

			IO.popen("#{svk} commit #{commit_args}", "r+") do |pipe|
				pipe.each {|line| mup.text! line }
			end
		}
	}
}

