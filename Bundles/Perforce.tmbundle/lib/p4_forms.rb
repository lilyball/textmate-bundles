#
# p4_forms.rb - chris@cjack.com
# Copyright 2005 Chris Thomas. All rights reserved.
# TM bundle license.
#

module Perforce

	class Form

		attr_accessor	:form

		def Form.from_path(pathname)
			Form.new(File.read(pathname))
		end

		def initialize(data)
			@form = Hash.new
	
			form_entries = data.scan( /^(\w*?):\s*(.*?)\n\n/m )
			form_entries.each { |entry| @form[entry[0]] = entry[1] }
		end

		def paths_from_entry(entryname)
			@form[entryname].split("\n\t")
		end

	end

=begin
	class Commands

		def Commands.p4( command )
			output = %x{p4 #{command}}
			if $CHILD_STATUS != 0 then
				puts output
				raise "Perforce command failed"
			end
			
			output
		end

		def Commands.commit

			StatusMap = {	'edit' 		=> 'M',
							'add'		=> 'A',
							'delete'	=> 'D'}
						# TODO others probably needed
		
			output = p4 %Q{p4 change -o}
	
			commit_form = Form.new(output)
			
			raw_paths = commit_form.paths_from_entry("Files")
			commit_paths = []
			commit_status = []
		
			raw_paths.each do |path|
				match = /^(.*)\s#\s(\w*)/.match(path)
				commit_paths.push(match[1])
				commit_status.push(match[2])
			end
		
			# map to CVS-like status for CommitWindow display
			commit_status = commit_status.collect{|status| StatusMap[status]}
			
		end

	end
	
=end
end

