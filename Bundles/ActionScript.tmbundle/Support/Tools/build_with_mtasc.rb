#!/usr/bin/env ruby
#
# Build - compile ActionScript using MTASC
#
# Based on a command by Chris Sessions, Released on 2006-06-02.
# Copyright (c) 2006. MIT License.
# Modified by Ale Muñoz <ale@bomberstudios.com> on 2006-11-24.
# Improved by juanzo on 2006-11-25
# 
# TODO: Documentation
# TODO: Use -main only when it's in the config

require "open3"
require "yaml"

require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require ENV['TM_SUPPORT_PATH'] + "/lib/progress"

def mtasc_compile
	Dir.chdir(ENV['TM_PROJECT_DIRECTORY'])
	yml = YAML.load(File.open('mtasc.yaml'))

	if !yml['mtasc_path']
		cmd = "\"#{ENV['TM_BUNDLE_SUPPORT']}/bin/mtasc\" "
	else
		cmd = "\"#{yml['mtasc_path']}\" "
	end
	cmd += " \"#{yml['app']}\" "
	cmd += " -version #{yml['player']} "
	cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/std/\" "
	cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/std8/\" "
	if yml['classpaths']
		cmd += " -cp \"#{yml['classpaths'].join('" -cp "')}\" "
	end
	if !File.exists? yml['swf']
		cmd += " -header #{yml['width']}:#{yml['height']}:#{yml['fps']} "
	else
		cmd += " -keep "
	end
	cmd += " -main "
	cmd += " -swf #{yml['swf']} "

	puts "<h1>#{yml['app']} → #{yml['swf']} </h1>"
	puts "Command: <code style=\"color: #666;\">#{cmd}</code>"

	stdin, stdout, stderr = Open3.popen3(cmd)
	warnings = []
	errors = []

	while err = stderr.gets
		if err[0, 10] == 'Warning : '
			warnings.push(err.chomp)
		else
			m = /(.+):([0-9]+): characters ([0-9]+)/.match(err)
			if m != nil
				a = "txmt://open?url=file://#{m[1]}&line=#{m[2]}&column=#{m[3].to_i + 1}"
				err = "<a href=\"#{a}\">#{err}</a>"
			end
			errors.push(err.chomp)
		end
	end
	if !errors.empty?
		puts '<h1>Errors:</h1>'
		puts "<p>#{errors.uniq.join('</p><p>')}</p>"
	end
	if !warnings.empty?
		puts '<h1>Warnings:</h1>'
		puts "<p>#{warnings.uniq.join('</p><p>')}</p>"
	end
	if errors.empty? && warnings.empty?
		puts '<script type="text/javascript">self.close()</script>'
		`open #{yml['preview']}` if yml["preview"]
	else
		TextMate.exit_show_html
	end
end

if File.exist?("#{ENV['TM_PROJECT_DIRECTORY']}/mtasc.yaml")
	# compile with MTASC
	TextMate.call_with_progress({:title => "MTASC", :message => "Compiling Classes"}) do
		mtasc_compile
	end
else
	# compile with Flash IDE
	`echo "flash.getDocumentDOM().testMovie()" > /tmp/test.jsfl; open /tmp/test.jsfl;`
	puts '<script type="text/javascript">self.close()</script>'
end