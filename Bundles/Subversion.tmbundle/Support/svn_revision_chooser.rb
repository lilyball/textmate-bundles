# 
#  svn_revision_chooser.rb
#  Subversion.tmbundle
#  
#  Created by Chris Thomas on 2006-12-30.
#  Copyright 2006 Chris Thomas. All rights reserved.
# 

#require "#{ENV["TM_SUPPORT_PATH"]}/lib/dialog"
location = File.dirname(__FILE__)
puts location

require "#{ENV["TM_SUPPORT_PATH"]}/lib/plist"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/dialog"

require "#{location}/svn_log_parser.rb"

$nib = "#{location}/nibs/RevisionSelector.nib"
$tm_dialog = "#{ENV["TM_SUPPORT_PATH"]}/bin/tm_dialog"

module Subversion
	
	def Subversion.choose_revision_of_path(path)
		entries = []
		Subversion::LogParser.parse_path(path) do |hash|
			entries << hash
		end
		
		raise unless File.exist?($nib)
		
		TextMate::Dialog.dialog($nib, {'entries' => entries}) do |dialog|
			dialog.wait_for_input
		end
	end
end


if __FILE__ == $0
	
#	test_path = "~/Library/Application Support/TextMate/Bundles/Ada.tmbundle"
	test_path = "~/TestRepo/TestFiles"
	
	Subversion.choose_revision_of_path(test_path)
end