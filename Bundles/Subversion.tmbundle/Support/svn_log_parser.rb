# 
#  svn_log_parser.rb
#  Subversion.tmbundle
#  
#  Created by Chris Thomas on 2006-12-30.
#  Copyright 2006 Chris Thomas. All rights reserved.
# 

require 'rexml/document'
require "#{ENV["TM_SUPPORT_PATH"]}/lib/plist"
require 'time'

module Subversion
	
	# Streaming 'svn log --xml' output parser.
	class LogParser
		
		# path may be a Subversion working copy path or a repository URL
		def LogParser.parse_path(path, &block)
			path = File.expand_path(path)
			log_cmd = %Q{svn log --xml "#{path}"}

			IO.popen(log_cmd, "r") do |io|
				LogParser.parse(io) do |hash|
					block.call(hash)
				end
			end # IO.popen
		end
		
		# source may be a string or an IO subclass
		def LogParser.parse(source, &block)
			listener = LogParser.new(&block)
			REXML::Document.parse_stream(source, listener)
		end

		# This listener makes no attempt to validate according to schema.
		# The SVN log node names are unique and nonrecursive,
		# so this shouldn't be an issue. But it would be nice as a sanity check.
		def initialize(&block)
			@callback_block = block
		end
	
		def xmldecl(*ignored)
		end
	
		def tag_start(name, attributes)
			case name
			when 'logentry'
				revision = attributes['revision']
				@current_log = {'rev' => revision.to_i}
			end
		end

		def tag_end(name)
			case name
			when 'author','msg'
				@current_log[name] = @text
			when 'date'
				@current_log[name] = Time.xmlschema(@text)
			when 'logentry'
				@callback_block.call(@current_log)
			end
		end
	
		def text(text)
			@text = text
		end

	end # class LogParser
end # module Subversion

if __FILE__ == $0
	
#	test_path = "~/Library/Application Support/TextMate/Bundles/Ada.tmbundle"
	test_path = "~/TestRepo/TestFiles"
	Subversion::LogParser.parse_path(test_path) do |hash|
		puts hash.inspect
	end
	
	# plist
	plist = []
	Subversion::LogParser.parse_path(test_path) do |hash|
		plist << hash
	end
	puts plist.to_plist
	
end

