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
			%x{"#{svn}" diff --diff-cmd diff "-r#{revision}" "#{target_path}"}
		end
	end
end
