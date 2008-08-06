#!/usr/bin/env ruby -wKU

require ENV['TM_SUPPORT_PATH'] + '/lib/textmate.rb'

@bundle_paths = [ "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
									"#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",								  
								  "/Library/Application Support/TextMate/Bundles" ]

begin
	@bundle_paths << TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles"
rescue
end

def find_bundle_dir(target)
	p = @bundle_paths.find { |dir| File.directory? "#{dir}#{target}" }
	return "#{p}/#{target}" if p
end

def find_bundle_item(target)
	p = @bundle_paths.find { |dir| File.exist? "#{dir}#{target}" }
	return "#{p}#{target}" if p
end

# Tests.
if __FILE__ == $0
	
	puts "Search locations:"
	puts @bundle_paths
	
	puts ""
  
	d = "/ActionScript 3.tmbundle/Support/lib"
  puts "Dir Path:"
  puts find_bundle_dir(d)

	puts ""

	i = "/A Non Existent.tmbundle/Support/lib"
  puts "Item Path:"
  puts find_bundle_dir(i)

	puts ""

	i = "/ActionScript 3.tmbundle/Support/lib/class_parser.rb"
  puts "Item Path:"
  puts find_bundle_item(i)

	puts ""

	i = "/A Non Existent.tmbundle/Support/lib/foo.rb"
  puts "Item Path:"
  puts find_bundle_item(i)
	
end
