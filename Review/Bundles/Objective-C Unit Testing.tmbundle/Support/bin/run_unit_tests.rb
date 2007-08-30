#!/usr/bin/env ruby

require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/run_xcode_target.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/find_xcode_project.rb"

PROJECT_PATH = XcodeProjectSearch.find_project
unless PROJECT_PATH
	puts "Didn't find an Xcode project file", "You may want to set TM_XCODE_PROJECT"
	exit
end
PROJECT = Xcode::Project.new(PROJECT_PATH)
PRODUCTS_PATH = PROJECT.results_path
Dir.chdir(PRODUCTS_PATH)
TEST_BUNDLE_PATH = Dir["#{PRODUCTS_PATH}/*.octest"].first
unless TEST_BUNDLE_PATH
	puts "Didn't find a test bundle", "You may need to set up a unit test bundle";
	exit
end
TEST_BINARY_PATH = "#{TEST_BUNDLE_PATH}/Contents/MacOS/#{File.basename(TEST_BUNDLE_PATH, ".octest")}"
ENV["DYLD_INSERT_LIBRARIES"] = "/System/Library/PrivateFrameworks/DevToolsBundleInjection.framework/DevToolsBundleInjection"
ENV["XCInjectBundle"] = TEST_BUNDLE_PATH
OTEST = "/Developer/Tools/otest"


class Xcode
	class Project
		class Target
			def active_configuration
				configuration_named(@project.active_configuration_name)
			end
		end

		class BuildConfiguration
			old_setting = self.instance_method(:setting)
			define_method(:setting) do |name|
				old = old_setting.bind(self).call(name)
				if old
					old.gsub /\$(\w+)|\$\((\w+)\)/ do |match|
						if ($1 || $2) == name
							$0
						else
							# puts "recursively loading #{$1 || $2}"
							setting($1 || $2)
						end
					end
				elsif name == "BUILT_PRODUCTS_DIR"
					PRODUCTS_PATH
				else
					nil
				end
			end
		end
	end
end

TEST_TARGET = PROJECT.targets.detect { |target|
	configuration = target.active_configuration
	configuration.setting("WRAPPER_EXTENSION") == "octest" and configuration.product_name == File.basename(TEST_BUNDLE_PATH, ".octest")
}
TEST_CONFIGURATION = TEST_TARGET.active_configuration
TEST_HOST = TEST_CONFIGURATION.setting("TEST_HOST")


SETTINGS_DIR_PATH = "#{ENV["HOME"]}/Library/Preferences/com.macromates.textmate.xcode.unit-test-settings"
Dir.mkdir(SETTINGS_DIR_PATH) if not File.exists?(SETTINGS_DIR_PATH) and not File.directory?(SETTINGS_DIR_PATH)
PROJECT_SETTINGS_DIR_PATH = "#{SETTINGS_DIR_PATH}/#{File.basename(ENV["TM_PROJECT_DIRECTORY"])}"
Dir.mkdir(PROJECT_SETTINGS_DIR_PATH) if not File.exists?(PROJECT_SETTINGS_DIR_PATH) and not File.directory?(PROJECT_SETTINGS_DIR_PATH)
PROJECT_SETTINGS_PATH = "#{PROJECT_SETTINGS_DIR_PATH}/#{TEST_CONFIGURATION.product_name}.plist"

# load previous settings, if any
PREV_SETTINGS = if File.exist?(PROJECT_SETTINGS_PATH)
	OSX::PropertyList.load(File.open(PROJECT_SETTINGS_PATH, 'r'))
else
	nil
end

# set up the test objects
TESTS = {"tests" => %x{otool -ov #{TEST_BINARY_PATH}}.split(/\n(?>Module)/).select{ |section| section =~ /\bsuper_class [^\s]+ SenTestCase\b/ }.collect do |section|
	klass = {
		"name" => section[/\bname [^\s]+ (\w+?)\b/, 1],
		"enabled" => 0
	}
	klass["methods"] = section.select{ |line| line =~ /\bmethod_name [^\s]+ (test\w+?)\b/ }.collect do |line|
		method = {
			"name" => line[/\bmethod_name [^\s]+ (test\w+?)\b/, 1],
			"enabled" => 0
		}
		if PREV_SETTINGS and PREV_SETTINGS[klass["name"]] and PREV_SETTINGS[klass["name"]][method["name"]]
			method["enabled"] = PREV_SETTINGS[klass["name"]][method["name"]]["enabled"]
		end
		method
	end.sort { |a, b| a["name"] <=> b["name"] }
	if PREV_SETTINGS and PREV_SETTINGS[klass["name"]]
		klass["enabled"] = PREV_SETTINGS[klass["name"]]["enabled"]
	end		
	klass
end.reject{ |klass|
	klass["methods"].size == 0
}.sort{ |a, b| a["name"] <=> b["name"] }}

values = OSX::PropertyList.load %x{"$DIALOG" -cm "$TM_BUNDLE_SUPPORT/nibs/Run Unit Tests.nib"<<END|pl
#{TESTS.to_plist}
END}

exit if values["returnButton"] == "Cancel"

# write enabled settings to file
File.open(PROJECT_SETTINGS_PATH, 'w') do |file|
	file.write(values["tests"].inject({}) do |accum, klass|
		accum[klass["name"]] = {"enabled" => klass["enabled"]}
		klass["methods"].each do |method|
			accum[klass["name"]][method["name"]] = {"enabled" => method["enabled"]}
		end
		accum
	end.to_plist)
end

run_specific = values["result"]["returnArgument"] == "1"
run_all = !run_specific

def run_specific_test(klass, method = nil)
	# puts %Q{#{TEST_HOST || OTEST} -SenTest #{klass + (method ? "/#{method}" : "")} #{TEST_BUNDLE_PATH}}
	result = %x{#{TEST_HOST || OTEST} -SenTest #{klass + (method ? "/#{method}" : "")} #{TEST_BUNDLE_PATH} 2>&1}
	result
end

def run_test_methods(klass, methods)
	methods.collect do |method|
		if method["enabled"] == "1"
			run_specific_test(klass, method["name"])
		end
	end.reject { |t| !t }
end

def run_tests(tests)
	tests.collect do |test|
		if test["enabled"] == "1"
			run_specific_test(test["name"])
		else
			run_test_methods(test["name"], test["methods"]) if test["methods"]
		end
	end.flatten
end

if run_specific
	puts(run_tests(values["tests"]))
else
	puts(run_specific_test("All"))
end