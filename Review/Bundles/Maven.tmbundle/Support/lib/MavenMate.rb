#!/usr/bin/env ruby -w

require "#{ENV["TM_SUPPORT_PATH"]}/lib/escape"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/ui"
require "#{ENV["TM_SUPPORT_PATH"]}/lib/web_preview"
require "pstore"
require "erb"
include ERB::Util

class MavenMate
	
	VERSION = "1.0.0".freeze

	attr_reader :green_patterns, :red_patterns
	
	def initialize(task, &option_getter)

		@location = (ENV["TM_PROJECT_DIRECTORY"] || ENV["TM_DIRECTORY"]).freeze
		Dir.chdir(@location)
		header()
		
		@green_patterns = [/BUILD SUCCESSFUL/, /Tests run: ([^0]\d*), Failures: 0, Errors: 0/]
		@red_patterns = [/\[ERROR\]/, /Tests run: ([^0]\d*)(.)+(Failures: ([^0]\d*)|Errors: ([^0]\d*)+)/]
		@orange_patterns = [/\[WARNING\]/, /There are no tests to run\./, /Tests run: 0,/]
		@blue_patterns = [/\[INFO\] \[(.)+:(.)+\]/]
		
		@task = task
		@option_getter = option_getter
		
		
		@maven = ENV["TM_MVN"]
		if @maven.nil? or not File.exist? @maven
			error("maven not found. Please set TM_MVN.")
		end
	end
	
	def run()
		command = get_full_command()
		print "#{command}<br />"
		puts ""
		task = MavenTask.new(command)
		
		task.run do |line, mode|
			if @green_patterns.detect { |pattern| line =~ pattern }
				print "<span style=\"color: green\">#{line.chomp}</span><br />"
			elsif @red_patterns.detect { |pattern| line =~ pattern }
				print "<span style=\"color: red\">#{line.chomp}</span><br />"
			elsif @orange_patterns.detect { |pattern| line =~ pattern }
				print "<span style=\"color: orange\">#{line.chomp}</span><br />"
			elsif @blue_patterns.detect { |pattern| line =~ pattern }
				print "<span style=\"color: blue\">#{line.chomp}</span><br />"
			else
				print htmlize(line)
			end
			$stdout.flush
		end
			
	end
	
	private
	
	def get_full_command()
		if (@option_getter.nil?)
			return "#{@maven} #{@task}"
		else
			prefs = PStore.new(File.expand_path( "~/Library/Preferences/com.macromates.textmate.mavenmate"))
			pref_key = "#{@location}::#{@task}"
			last_value = prefs.transaction(true) { prefs[pref_key] }
			option = @option_getter[last_value]
			prefs.transaction { prefs[pref_key] = option }
			command = @maven
			command += " #{@task}" unless @task.empty?
			command += " #{option}" unless option.empty?
			return command
		end
	end
	
	def header()
		html_header("MavenMate", "mvn")
		puts "<pre>"
		puts "MavenMate v#{VERSION} running on Ruby v#{RUBY_VERSION} (#{ENV["TM_RUBY"].strip})"
		$stdout.flush
	end
	
	def error(error)
		puts error
		footer()
		exit
	end

	def footer
		puts "</pre>"
		html_footer
	end

end

class MavenTask
	
	def initialize(task = nil, *options)
		@mode = :line_by_line
		build_maven_command(task, *options)
	end
	
	def run(&block)
		open(@command) do | maven_task |
			if block.nil?
				maven_task.read
			else
				loop do
					break if maven_task.eof?
					new_content = (@mode == :char_by_char) ? maven_task.getc.chr : maven_task.gets
					@mode = (block.arity == 2) ? block[new_content, @mode] : block[new_content]
				end
			end
		end
	end
	
	private
	
	def build_maven_command(task, *options)
		@command =	"|"
		@command << " " << task unless task.nil?
		unless options.empty?
			@command << " " << options.map { |arg| e_sh(arg) }.join(" ")
		end
		@command << " 2>&1"
	end
	
end
