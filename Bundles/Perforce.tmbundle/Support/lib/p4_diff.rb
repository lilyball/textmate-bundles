#!/usr/bin/env ruby -w

require ENV['TM_SUPPORT_PATH'] + "/lib/progress"

module Perforce

	def Perforce.diff_active_file( revision, command )
		p4			= ENV['TM_P4'] || 'p4'
		target_path	= ENV['TM_FILEPATH']

		output_path	= File.basename(target_path) + ".diff"

		TextMate::call_with_progress(:title => command,
									:message => "Retrieving differences",
									:output_filepath => output_path) do
	     puts %x{"#{p4}" diff -f -du "#{target_path}#{revision}"}
		end
	end

	def Perforce.diff_two_revisions( rev1, rev2, command )
		p4			= ENV['TM_P4'] || 'p4'
		output_path	= "#{rev1}:#{rev2}.diff"

		TextMate::call_with_progress(:title => command,
									:message => "Retrieving differences",
									:output_filepath => output_path) do
			puts %x{"#{p4}" diff -f -du "#{rev1}" "#{rev2}"}
		end
	end
	
	def Perforce.diff_files_in_revisions( rev1, rev2, command )
		p4			= ENV['TM_P4'] || 'p4'
		output_path	= "Files in #{rev1} and #{rev2}.diff"

		TextMate::call_with_progress(:title => command,
									:message => "Retrieving differences",
									:output_filepath => output_path) do
		
			puts %x{"#{p4}" files "#{rev1}" > "#{rev1}.txt" && "#{p4}" files "#{rev2}" > "#{rev2}.txt" && diff -u "#{rev1}.txt" "#{rev2}.txt"}
		end
		
	end

end
