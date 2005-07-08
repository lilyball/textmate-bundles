#
# p4_forms.rb - chris@cjack.com
# Copyright 2005 Chris Thomas. All rights reserved.
# TM bundle license.
#

module Perforce

	class Form

		attr_accessor	:fields

		def Form.from_path(pathname)
			Form.new(File.read(pathname))
		end

		def initialize(data)
			@fields = Hash.new
	
			form_entries = data.scan( /^(\w*?):\s*(.*?)\n\n/m )
			form_entries.each { |entry| @fields[entry[0]] = entry[1] }
		end

		def paths_from_entry(entryname)
			@fields[entryname].split("\n\t")
		end

		# (re)construct the form
		def to_s
			
			outstring = @fields.keys.inject("") do |outstring, field|
				value = @fields[field]
				
				# multiline fields begin on the next line
				# each line of a multiline field should begin with a tab
				if value.include?("\n") then
					value.gsub!(/^\t?/, "\t")
					value.chomp!("\n")
					outstring + field + (":\n#{value}\n\n")
				else
					outstring + field + (":\t#{value}\n\n")
				end
			end
			
			"\m" + outstring
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

