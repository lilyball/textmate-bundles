require 'English'
require 'ostruct'


svn         	= ENV['TM_SVN']            || `which svn`.chomp
bundle      	= ENV['TM_BUNDLE_SUPPORT'] || File.dirname(__FILE__)
support     	= ENV['TM_SUPPORT_PATH']   || File.dirname(File.dirname(File.dirname(File.dirname(__FILE__)))) + '/Support'
commit_tool 	= ENV['CommitWindow']      || support + '/bin/CommitWindow.app/Contents/MacOS/CommitWindow'
status_helper	= bundle + "/commit_status_helper.rb"
diff_cmd		= ENV['TM_SVN_DIFF_CMD']   || 'diff'

require (support + '/lib/shelltokenize.rb')
require (support + "/lib/erb_streaming.rb")

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

paths_to_commit = Array.new			# array of paths to commit
$options			= OpenStruct.new	# options

$options.output_format	= :HTML
$options.dry_run			= false

require 'optparse'

opts = OptionParser.new do |opts|
	opts.banner = "Usage: #{File.basename(__FILE__)} [options] [files]"
	opts.separator ""
	opts.separator "Specific options:"

	opts.on("--output=TYPE", [:HTML, :plaintext, :terminal], "Select format of output (HTML, plaintext, terminal).") 	 do |format|
		$options.output_format = format
	end

	opts.on_tail("--help", "Display help.") do
		puts opts
		exit
	end

	opts.on_tail("--dry-run", "Go through the motions, but don't actually commit anything.") do
		$options.dry_run = true
	end
end

opts.parse!

# any file arguments?
if ARGV.empty? then
	paths_to_commit = TextMate::selected_paths_array
#		paths_to_commit = [Dir.pwd] FIXME when using command line
else
	paths_to_commit.concat( ARGV ) 
end
	

class SVNCommitTransaction
	attr_accessor :paths_to_commit
	attr_accessor :svn_tool
	attr_accessor :diff_tool
	attr_accessor :commit_window_tool
	attr_accessor :status_helper_tool

private	
	def matches_to_paths(matches)
		paths = matches.collect {|m| m[2] }
		paths.collect{|path| path.sub(/^#{CurrentDir}/, "") }
	end

	def matches_to_status(matches)
		# collect the status, and replace prefix spaces with underscores so command-line argument passing works later
		matches.collect {|m| m[0]}.map {|m| m.rstrip.gsub(/\s/, '_')}
	end

public
	def initialize(paths_to_commit)
		@paths_to_commit	= paths_to_commit
	end

	def preflight
		# Ignore files without changes
		status_command = %Q{"#{@svn_tool}" status #{@paths_to_commit.quote_for_shell_arguments}}
		# puts status_command + "\n" #DEBUG

		status_output = %x{#{status_command}}
		# puts status_output + "\n" #DEBUG

		paths = status_output.scan(/^(.....)(\s+)(.*)\n/)

		@commit_matches = paths

		return false if @commit_matches.nil? or (@commit_matches.size == 0)
		true
	end
	
	def ask_user_for_arguments
		commit_paths_array = matches_to_paths(@commit_matches)
		commit_status = matches_to_status(@commit_matches).join(":")

		commit_path_text = commit_paths_array.collect{|path| path.quote_filename_for_shell }.join(" ")
		
		ENV['TM_SUPPORT_PATH'] = support if $options.console_output
		@commit_args = %x{"#{@commit_window_tool}" 2>/dev/console --diff-cmd "#{@svn_tool},diff,--diff-cmd,#{@diff_tool}" \
		 					--status #{commit_status} \
							--action-cmd "?:Add,#{@svn_tool},add" \
							--action-cmd "A:Mark Executable,#{@status_helper_tool},propset,svn:executable,true" \
							--action-cmd "A,M,D,C:Revert,#{@status_helper_tool},revert" \
							--action-cmd "C:Resolved,#{@status_helper_tool},resolved" \
							#{commit_path_text}}
		$CHILD_STATUS
	end
	
	def commit(&output_block)
		require "open3"
		Open3.popen3("#{@svn_tool} commit --non-interactive --force-log #{@commit_args}") do |stdin, stdout, stderr|
			stdout.each_line {|line| output_block.call(:output, line.chomp)}
			stderr.each_line {|line| output_block.call(:error, line.chomp)}
		end
	end
end

transaction = SVNCommitTransaction.new(paths_to_commit)
transaction.svn_tool			= svn
transaction.commit_window_tool	= commit_tool
transaction.diff_tool			= diff_cmd
transaction.status_helper_tool	= status_helper

# Perform the commit
case $options.output_format
when :plaintext
	exit_early = false
	if not transaction.preflight then
		exit_early = true
		puts "No files modified; nothing to commit."
		transaction.paths_to_commit.each do | path |
			puts " • " + path
		end
	else
		status = transaction.ask_user_for_arguments
		if status != 0
			puts "Canceled (#{status >> 8})."
			exit_early = true
		end
	end

	STDOUT.flush
	if (not exit_early) and (not $options.dry_run)
		# WebKit needs <br> instead of \n inside <pre>, otherwise the text won't flush
		transaction.commit {|stream, line| STDOUT.print(line + "<br>"); STDOUT.flush}
	end
	
when :HTML
	ERB.run_to_stream(IO.read(bundle + '/Templates/Commit.rhtml'), STDOUT)
end

