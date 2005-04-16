
#
# Xcode build input parser
#

formatter = Formatter.new

last_line = ""

formatter.start

STDIN.each_line do |line|
	
	# remember the current line for later
	last_line = line
	
	case line

# TODO: xcodebuild generates lines like:
# CompileC "file.o" Source/file.cpp normal ppc c++ com.apple.compilers.gcc.3_3 
# We could parse these to provide build status delimited by file.
# Then we might consider hiding the build details by default.

		
		when /^(CompileC|Ld|PhaseScriptExecution)\s+(.*?)\s+(.*?)\s(.*?)\s(.*?).*$/
			
			formatter.file_compiled( "#$1", "#$4" )
			formatter.build_noise( line )

			
		# Handle error prefix text
		when /^\s*((In file included from)|from)(\s*)(\/.*?):/
			
#					if File.exist?("#$3")
				formatter.message_prefix( line )
#					else
#						mup.normal!( line )
#					end

		# <path>:<line>:[column:] error description
		when /^(.+?):(\d+):(?:\d*?:)?\s*(.*)/
			path		= "#$1"
			line_number = "#$2"
			error_desc	= "#$3"
		
			# if the file doesn't exist, we probably snagged something that's not an error
			if File.exist?(path)

				# parse for "error", "warning", and "info" and use appropriate CSS classes					
				cssclass = /^\s*(error|warning|info|message)/i.match(error_desc)
				if cssclass.nil?
					cssclass = "" 
				else
					cssclass = cssclass[1]
				end

				formatter.error_message( cssclass, path, line_number, error_desc )
			else
				formatter.build_noise( line )
			end

		when /^\s*(\s*)(\/.*?):/
			
			if File.exist?("#$2")
				formatter.message_prefix( line )
			else
				formatter.build_noise( line )
			end
							
		# highlight each target name
		when /^===(.*)===$/
			formatter.target_name( "#$1" )
		
		else
			formatter.build_noise( line )
	end
	
end

# report success/failure
success = /\*\* BUILD SUCCEEDED \*\*/.match(last_line)
success = success.nil? ? false : true

formatter.message_prefix(last_line)

if success then
	formatter.success
else
	formatter.failure
end
formatter.complete

