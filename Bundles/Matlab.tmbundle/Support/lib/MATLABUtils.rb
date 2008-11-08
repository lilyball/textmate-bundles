# The MATLAB module contains methods for parsing MATLAB scripts and functions
require ENV["TM_SUPPORT_PATH"] + "/lib/exit_codes.rb"

module MATLAB
	ENV['TM_SCOPE'] =~ /source\.(\w+)/
	OCTAVE = ($1 == 'octave')
	
	class <<self
		
		# Method for extracting all variable names
		def get_variables

			variables = Array.new()
			text = STDIN.readlines.join
			# Remove all comments
			text.gsub!(/%\{.*%\}/,'')
			text.gsub!(/%.*(?=\n)/,'')
			text.gsub!(/#.*(?=\n)/,'') if OCTAVE
			
			# Strip out all escaped quotes
			text.gsub!("''",'')
			
			# Strip out all strings
			text.gsub!(/((\[|\(|\{|=|\s|;|:|,)|^)'[^']+'/,'\1_')
			
			# Exchange all '...' for ''
			text.gsub!(/\.{3,}\s*\n\s*/,'')
			
			# Replace all ; with newlines, and split
			text.gsub!(';',"\n")

			# puts text.split("\n").inspect
			# print ENV["TM_COMMENT_START"]
			text.split("\n").each do |line|
				# Only process line if the line isn't a comment or blank
				unless line.empty?
					# If we have a function declaration, grab all variables
					if line =~ /^\s*function[\s=]/
						line =~ /^\s*function\s*(((\[.*\])|([a-zA-Z]\w*))\s*=\s*)?[a-zA-Z]\w*\s*(\(\s*([\w,\s]+)\s*\))?/
						
						unless ($6).nil?
							variables.concat(($6).strip.split(/\s*,\s*/))
						end
					end
					if line =~ /[^=]=[^=]/
						
						# Strip out everything after assignment
						line.gsub!(/([^=]=[^=]).*?/,'\1')

						# Strip the leading and trailing whitespace
						line.strip!
						
						# Strip out all core keywords
						line.gsub!(/^\s*(function|if|switch|while|for|try)\s+/,'')

						# Strip out all cells
						while line =~ /[\{\}]/
							line.gsub!(/\{[^\{\}]*?\}/,'')
						end
						# Strip out parentheses
						while line =~ /[\(\)]/
							line.gsub!(/\([^\(\)]*?\)/,'')
						end
						
						# Strip out all equal signs and strip
						line.gsub!(/\s*=.*$/,'')
						
						# Strip out all brackets
						line.tr!('[]','')
						
						# Split and include in variables
						variables.concat(line.split(/\s*,\s*|\s/))
					end
				end
			end
			return variables.sort.uniq
		end
		
	end
end