#!/usr/bin/env ruby -w

$LOAD_PATH << ENV['TM_SUPPORT_PATH'] + "/lib"
require 'progress'

module Subversion
	def Subversion.diff_active_file( revision, command )
		svn			= ENV['TM_SVN'] || 'svn'
		target_path	= ENV['TM_FILEPATH']
#		revision	= ARGV[0]
#		command		= ARGV[1]
		output_path	= File.basename(target_path) + ".diff"

		TextMate::call_with_progress(:title => command,
									:message => "Accessing Subversion Repository…",
									:output_filepath => output_path) do
			have_data = false
			
			# idea here is to stream the data rather than submit it in one big block
			%x{"#{svn}" diff --diff-cmd diff "-r#{revision}" "#{target_path}"}.each_line do |line|
				have_data = true unless line.empty?
				puts line
			end
			
			if not have_data then
				# switch to tooltip output to report lack of differences
				puts "No differences found."
				exit 206;
			end
		end
	end
end
