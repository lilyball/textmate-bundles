require 'English'

svn         	= ENV['TM_SVN']            || `which svn`.chomp
bundle      	= ENV['TM_BUNDLE_SUPPORT'] || File.dirname(__FILE__)
support     	= ENV['TM_SUPPORT_PATH']   || File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) + '/Support'
commit_tool 	= ENV['CommitWindow']      || support + '/bin/CommitWindow.app/Contents/MacOS/CommitWindow'
status_helper	= bundle + "/commit_status_helper.rb"
diff_cmd		= ENV['TM_SVN_DIFF_CMD']   || 'diff'


# puts ARGV.inspect
# puts 'TM_SELECTED_FILES  '+ ENV['TM_SELECTED_FILES'] rescue nil #DEBUG
# puts 'TM_FILEPATH        '+ ENV['TM_FILEPATH']       rescue nil #DEBUG
# puts 'svn                '+ svn                                 #DEBUG
# puts 'bundle             '+ bundle                              #DEBUG
# puts 'support            '+ support                             #DEBUG
# puts 'commit_tool        '+ commit_tool                         #DEBUG
# puts 'diff_cmd           '+ diff_cmd                            #DEBUG

IgnoreFilePattern = /(\/.*)*(\/\..*|\.(tmproj|o|pyc)|Icon)/
CurrentDir        = Dir.pwd + "/"

require (support + '/lib/shelltokenize.rb')
require (support + "/lib/Builder.rb")

mup             = nil       # markup builder
paths_to_commit = Array.new # array of paths to commit
$dry_run        = false     # don't commit anything?

#
# Run from Terminal or run from TextMate?
# 
if ARGV.include? '--console-output'
	# Terminal
	ARGV.delete '--console-output'
	
	$console_output	= true
	
	require (bundle + '/terminal_markup')
	require 'optparse'
	
	opts = OptionParser.new do |opts|
	        opts.banner = "Usage: #{File.basename(__FILE__)} --console-output [options] [files]"
	        opts.separator ""
	        opts.separator "Specific options:"

			opts.on_tail("--help", "Display help.") do
				puts opts
				exit
			end
	
			opts.on_tail("--dry-run", "Go through the motions, but don't actually commit anything.") do
				$dry_run = true
			end
	end
	
	opts.parse!

	# any file arguments?
	if ARGV.size > 0
		paths_to_commit = ARGV
	else
		paths_to_commit = [Dir.pwd]
	end
	
	mup = TerminalMarkup.new
else 
	# TextMate
	$console_output = false
	paths_to_commit = TextMate::selected_paths_array
	paths_to_commit.concat( ARGV ) unless ARGV.empty?
	
	mup = Builder::XmlMarkup.new(:target => STDOUT)
end

mup.html {
	mup.head do
			mup.title("Subversion Commit")
			mup.style( "@import 'file://"+bundle+"/Stylesheets/svn_status_style.css';", "type" => "text/css")
	end

	mup.body { 
		unless $console_output
			mup.h1 do 
				mup.img( :src => "file://"+bundle+"/Stylesheets/subversion_logo.tiff",
							:height => 21,
							:width => 32 )
				mup.text " Commit"
			end
		end
		
		STDOUT.flush

		# Ignore files without changes
#puts TextMate::selected_paths_for_shell
		status_command = %Q{"#{svn}" status #{paths_to_commit.quote_for_shell_arguments}}
		# puts status_command + "\n" #DEBUG
#puts status_command
		status_output = %x{#{status_command}}
		# puts status_output + "\n" #DEBUG
#puts status_output
		paths = status_output.scan(/^(.....)(\s+)(.*)\n/)

		def matches_to_paths(matches)
			paths = matches.collect {|m| m[2] }
			paths.collect{|path| path.sub(/^#{CurrentDir}/, "") }
		end

		def matches_to_status(matches)
			# collect the status, and replace prefix spaces with underscores so command-line argument passing works later
			matches.collect {|m| m[0]}.map {|m| m.rstrip.gsub(/\s/, '_')}
		end

		def select_files_with_status_prefix(paths, char)
			paths.select do |m|
				index = m[0].index(char)
				((index != nil) and (index == 0))
			end
		end

		# Ignore files with '?', but report them to the user String.index
		# unknown_paths = select_files_with_status_prefix(paths, '?')
		#         unknown_to_report_paths = unknown_paths.reject{ |m| IgnoreFilePattern =~ m[2] }
		# if unknown_to_report_paths and unknown_to_report_paths.size > 0 then
		# 	mup.div( :class => "warning" ) {
		# 		mup.p "These files are not under version control, and so will not be committed:"
		# 		mup.ul{ matches_to_paths(unknown_to_report_paths).each{ |path| mup.li(path) } }
		# 	}
		# end

		# Ignore files with '!', but report them to the user
		# missing_paths = select_files_with_status_prefix(paths, '!')
		#         missing_to_report_paths = missing_paths.reject{ |m| IgnoreFilePattern =~ m[2] }
		# if missing_to_report_paths and missing_to_report_paths.size > 0 then
		#     
		# 	mup.div( :class => "warning" ) {
		# 		mup.p "These files are missing from the working copy:"
		# 		mup.ul{ matches_to_paths(missing_to_report_paths).each{ |path| mup.li(path) } }
		# 	}
		# end

		# Fail if we have conflicts -- svn commit will fail, so let's
		# error out before the user gets too involved in the commit
		# conflict_paths = select_files_with_status_prefix(paths, 'C')
		# 
		# if conflict_paths and conflict_paths.size > 0 then
		# 	mup.div( :class => "error" ) {
		# 		mup.p "Cannot continue; there are merge conflicts in files:"		
		# 		mup.ul{ matches_to_paths(conflict_paths).each{ |path| mup.li(path) } }
		# 		mup.text! "Canceled."
		# 	}	
		# 	exit -1
		# end

		# Remove the unknown paths from the commit
		# commit_matches = paths - unknown_paths
		# 
		# # Remove the missing paths from the commit
		# commit_matches = commit_matches - missing_paths

		commit_matches = paths

		if commit_matches.nil? or commit_matches.size == 0
			mup.div( :class => "info" ) {
				mup.text! "File(s) not modified; nothing to commit."
				mup.ul{ matches_to_paths(unknown_paths).each{ |path| mup.li(path) } }
			}
			exit 0
		end

		STDOUT.flush

		commit_paths_array = matches_to_paths(commit_matches)
		commit_status = matches_to_status(commit_matches).join(":")

		commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")

		# need to reexport the support directory for CommitWindow's benefit, or double-click diff doesn't work.
		ENV['TM_SUPPORT_PATH'] = support if $console_output
		commit_args = %x{"#{commit_tool}" --diff-cmd "#{svn},diff,--diff-cmd,#{diff_cmd}" \
		 					--status #{commit_status} \
							--action-cmd "?:Add,#{svn},add" \
							--action-cmd "A:Mark Executable,#{status_helper},propset,svn:executable,true" \
							--action-cmd "A,M,D,C:Revert,#{status_helper},revert" \
							--action-cmd "C:Resolved,#{status_helper},resolved" \
							#{commit_path_text}
		}

		status = $CHILD_STATUS
		if status != 0
			mup.div( :class => "error" ) {
				mup.text! "Canceled (#{status >> 8})."
			}	
			exit -1
		end

		if $console_output
			mup.div(:class => "command"){ mup.strong(%Q{#{svn} commit}); mup.text!(commit_args) }
		end

		exit 0 if $dry_run
		mup.div( :class => 'section' ) do
			mup.pre {
				mup.text("...\n")
				STDOUT.flush
				
				# puts "#{svn} commit --non-interactive --force-log #{commit_args}" #DEBUG
				# puts `pwd`                                                        #DEBUG
				
				require "open3"
				Open3.popen3("#{svn} commit --non-interactive --force-log #{commit_args}") do |stdin, stdout, stderr|
					# WebKit needs <br> instead of \n inside <pre>, otherwise the text won't flush
					stdout.each_line {|line| mup.text! line.chomp; mup << "<br>"; STDOUT.flush}
					stderr.each_line {|line| mup.text! line.chomp; mup << "<br>"; STDOUT.flush}
				end
			}
		end

	}
}

