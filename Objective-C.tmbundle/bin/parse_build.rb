#
# xcodebuild output parser for TextMate
# chris@cjack.com
#
# Copyright 2005 Chris Thomas. All rights reserved.
#
# OpenBSD license. 
#
#

#
# String helpers for build command tokenization.
#
class String

	# strscan was not bundled with Ruby 1.6, so we need to roll our own.
	# This is actually not much more code than the equivalent strscan code,
	# I believe, but it's more intricate than a strscan version would be.
	def next_token
		out_token = ""
		found_quote = false
		
		self.slice(@token_offset...self.length).each_byte do |byte|
			
			char = byte.chr
			
			@token_offset += 1
			
			case char
				when '"'
					break if found_quote
					found_quote = true
				when /\s/
					break if not found_quote
				else
					out_token += char
			end
		end
		
		out_token
	end
	
	# return a list of tokens.
	# Token delimiters are double-quotes and whitespace, except for whitespace within double-quotes.
	def tokenize
		out_tokens = Array.new
		
		@token_offset = 0
		until @token_offset >= (self.length - 1)
			out_tokens << next_token
		end
		
		out_tokens.reject {|token| token.empty? }
	end
end

#
# Xcode build input parser
#

#	XcodeMethodType => [Name to display for method, index of pathname to display (zero-based)]
MethodTypeMap = {
	'ProcessPCH++'			=> ['Precompiling', 1],
	'ProcessPCH'			=> ['Precompiling', 1],
	'DataModelCompile'		=> ['Compiling', 1],
	'CompileC'				=> ['Compiling', 1],
	'OSACompile'			=> ['Compiling', 1],
	'Ld'					=> ['Linking', 0],
	'PhaseScriptExecution'	=> ['Running script', 0],
	'Libtool'				=> ['Creating library', 0],
	'Ranlib'				=> ['Updating library', 0],
	'PBXCp'					=> ['Copying', 0],
	'Mkdir'					=> ['Creating directory', 0],
	'CpResource'			=> ['Copying', 0],
	"SymLink"				=> ['Creating symbolic link', 0],
	"Touch"					=> ['Touching', 0],   # FIXME: Need better verb for "setting the modification date of X to right now?"
	
	# not likely to encounter this yet, as we don't implement clean
#	"Clean.Remove"			=> ['Removing', 1],
	
	'Building ZeroLink launcher'				=> ['Building ZeroLink launcher', 0]
}

MethodTypes				= MethodTypeMap.keys
MethodExpression		= /^(#{MethodTypes.collect{|t| Regexp.escape(t) }.join("|")})\s+(.*)$/

formatter = Formatter.new

last_line = ""
seen_first_line = false

formatter.start

#
# Main parse logic
#

STDIN.each_line do |line|

	# NOTE WELL
	# The right way to implement this parser is probably to look for "BUILDING TARGET"
	# and maintain a state machine. Another bit of structure that we don't use is the
	# empty line placed before each build command. That would allow us to display command
	# names that we don't know about -- the build method is the first token on the line
	# after an empty linee, although it wouldn't otherwise make much sense out of the
	# command.
	#
	# This logic would be much more complex if we did that, though. Not clear that
	# perfection is worthwhile in this case.

	
	# remember the current line for later
	last_line = line
		
	case line
		
		# Build method parser
		when MethodExpression
			
			method_type = $1
			method_params = MethodTypeMap[method_type]
			
			arguments = Regexp.last_match(2).tokenize
			file_arg = arguments[method_params[1]]
			file_arg.sub!(Dir.pwd, "")
			
			formatter.file_compiled( method_params[0], file_arg )
			formatter.build_noise( line )

			
		# Error prefix text
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
		# some random file path as the first element of a line
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

