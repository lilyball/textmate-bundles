#!/usr/bin/env ruby
#
# Build - compile ActionScript using MTASC
#
# Based on a command by Chris Sessions, Released on 2006-06-02.
# Copyright (c) 2006. MIT License.
# Modified by Ale Muñoz <http://bomberstudios.com> on 2006-11-24.
# Improvements suggested by Juan Carlos Añorga <http://www.juanzo.com/>, Helmut Granda <http://helmutgranda.com>

require "open3"
require "yaml"

require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require ENV['TM_SUPPORT_PATH'] + "/lib/progress"
require ENV["TM_SUPPORT_PATH"] + "/lib/web_preview"

# Some routes
@file_path = ENV['TM_FILEPATH']
@file_name = ENV['TM_FILENAME']
@project_path = ENV['TM_PROJECT_DIRECTORY']

# Utils
@q = "\""

def warning(text, title)
	html_header("Error!","Build With MTASC")
	puts "<h1>#{title}</h1>"
	puts "<p>#{text}</p>"
	html_footer
	TextMate.exit_show_html
end

def mtasc_compile
	if !@project_path || !File.exist?("#{@project_path}/mtasc.yaml")
		@project_path = File.dirname @file_path
	end
	Dir.chdir(@project_path)
	if File.exists?(@project_path + "/mtasc.yaml")
		yml = YAML.load(File.open('mtasc.yaml'))
		if yml['mtasc_path']
			@mtasc_path = yml['mtasc_path']
		else
			@mtasc_path = ENV['TM_BUNDLE_SUPPORT'] + "/bin/mtasc"
		end
		@app = yml['app']
		@swf = yml['swf']
		@player = yml['player']
		@width = yml['width']
		@height = yml['height']
		# If width or height is a percentage. MTASC chokes because it needs a number. Fix it.
		if @width =~ /%/ || @height =~ /%/
			@size_is_percentage = true
			@width.gsub!(/%/,'')
			@height.gsub!(/%/,'')
		end
		@fps = yml['fps']
		@classpaths = yml['classpaths']
		@trace = yml['trace'] if !yml['trace'].nil?
		@preview = yml['preview'] || "textmate"
		@bgcolor = yml['bgcolor'] || "FFFFFF"
		@params = yml['params'] if !yml['params'].nil?
	else
		@mtasc_path = ENV['TM_BUNDLE_SUPPORT'] + "/bin/mtasc"
		@app = @file_name
		@swf = File.basename(@file_name,".as") + ".swf"
		@player = 8
		@width = 800
		@height = 600
		@fps = 31
		@preview = "textmate"
		@bgcolor = "FFFFFF"
	end

	# MTASC binary
	cmd = @q + @mtasc_path + @q

	# App name
	cmd += " " + @q + @app + @q

	# Player version
	cmd += " -version " + @player.to_s

	# Standard Adobe Classes
	cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/std/\" "
	cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/std8/\" "

	# XTrace Classes
	cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/\" "

	# User-provided Classpath
	if @classpaths
		cmd += " -cp \"#{@classpaths.join('" -cp "')}\" "
	end

  # Additional parameters from mtasc.yaml
  if @params
    cmd += " #{@params} "
  end
  if @trace
    if @trace == "xtrace"
      # Use XTrace for debugging
      `open "$TM_BUNDLE_SUPPORT/bin/XTrace.app"`
      cmd += " -pack com/mab/util "
      cmd += " -trace com.mab.util.debug.trace "
    elsif @trace == "console"
      # do nothing
    else
      cmd += " -trace #{@trace} "
    end
  end

  if !File.exists? @swf
    cmd += " -header #{@width}:#{@height}:#{@fps}"
  end

	cmd += " -main "
	cmd += " -swf #{@swf}"

	stdin, stdout, stderr = Open3.popen3(cmd)
	warnings = []
	errors = []

	while err = stderr.gets
		if err[0, 10] == 'Warning : '
			warnings.push(err.chomp)
		else
			m = /(.+):([0-9]+): characters ([0-9]+)/.match(err)
			if m != nil
				a = "txmt://open?url=file://#{@project_path}/#{m[1]}&line=#{m[2]}&column=#{m[3].to_i + 1}"
				err = "<a href=\"#{a}\">#{err}</a>"
			end
			errors.push(err.chomp)
		end
	end
	if !errors.empty?
		warning "#{errors.uniq.join('</p><p>')} <br/> <pre>#{cmd}</pre>", "Errors:"
	end
	if !warnings.empty?
		warning "#{warnings.uniq.join('</p><p>')} <br/> <pre>#{cmd}</pre>", "Warnings:"
	end
	if errors.empty? && warnings.empty?
    if @trace == "console"
      `open -a Console.app "#{ENV['HOME']}/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"`
    end
    if @preview == "textmate"
      # Preview in TextMate
      output_file = "#{@project_path}/#{@swf}"
      if @size_is_percentage
        @width += "%"
        @height += "%"
			end
			puts "<html>"
			puts "<head><title>#{@swf}</title></head>"
			puts <<SWF_HTML
			<body style="margin: 0; padding: 0;">
			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=#{@version},0,0,0" width="#{@width}" height="#{@height}" id="myApplication" align="middle">
				<param name="allowScriptAccess" value="always">
				<param name="movie" value="#{output_file}">
				<param name="quality" value="high">
				<param name="bgcolor" value="##{@bgcolor}">
				<embed src="#{output_file}" quality="high" bgcolor="##{@bgcolor}" width="#{@width}" height="#{@height}" name="myApplication" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
			</object>
			</body>
			</html>
SWF_HTML
			TextMate.exit_show_html
		else
			# Open user-defined preview
			`open #{@preview}`
		end
	else
		TextMate.exit_show_html
	end
end

# compile with MTASC
TextMate.call_with_progress({:title => "MTASC", :message => "Compiling Classes"}) do
	mtasc_compile
end