require 'English' # you are angry, english!

svn				= ENV['TM_SVN']
#commit_paths	= ENV['CommitPaths']
commit_tool		= ENV['CommitWindow']
bundle			= ENV['TM_BUNDLE_PATH']
support			= ENV['TM_SUPPORT_PATH']
ignore_file_pattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/

CURRENT_DIR		= Dir.pwd + "/"

require (support + '/bin/shelltokenize.rb')
require (support + "/bin/Builder.rb")

mup = Builder::XmlMarkup.new(:target => STDOUT)

mup.html {
	mup.head {
			mup.title("Subversion commit")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_style.css';", "type" => "text/css")
	}

	mup.body { 
		mup.h1("Subversion Commit")
		STDOUT.flush
		mup.hr

		# Ignore files without changes
#puts TextMate::selected_paths_for_shell
		status_command = %Q{"#{svn}" status #{TextMate::selected_paths_for_shell}}
#puts status_command
		status_output = %x{#{status_command}}
#puts status_output
		paths = status_output.scan(/^(.)....(\s+)(.*)\n/)


		def matches_to_paths(matches)
			paths = matches.collect {|m| m[2] }
			paths.collect{|path| path.sub(/^#{CURRENT_DIR}/, "") }
		end

		def matches_to_status(matches)
			matches.collect {|m| m[0]}
		end

		# Ignore files with '?', but report them to the user
		unknown_paths = paths.select { |m| m[0] == '?' }
        unknown_to_report_paths = paths.select{ |m| m[0] == '?' and not ignore_file_pattern =~ m[2]}
		if unknown_to_report_paths and unknown_to_report_paths.size > 0 then
		    
			mup.div( "class" => "info" ) {
				mup.text! "These files are not added to the repository, and so will not be committed:"		
				mup.ul{ matches_to_paths(unknown_to_report_paths).each{ |path| mup.li(path) } }
			}
		end

		# Fail if we have conflicts -- svn commit will fail, so let's
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
		commit_status = matches_to_status(commit_matches).join(":")

		commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")

		commit_args = %x{"#{commit_tool}" --status #{commit_status} #{commit_path_text}}

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

			IO.popen("#{svn} commit --force-log #{commit_args}", "r+") do |pipe|
				pipe.each {|line| mup.text! line }
			end
		}
	}
}

