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

# For single-file compilations or projects without a mtasc.yaml file
if !@project_path || !File.exist?("#{@project_path}/mtasc.yaml")
  @project_path = File.dirname @file_path
end


# Utils
@q = "\""

def warning(text, title)
  html_header("Error!","Build With MTASC")
  puts "<h1>#{title}</h1>"
  puts "<p>#{text}</p>"
  html_footer
  TextMate.exit_show_html
end

def get_config
  # Optional: mtasc_path, params, classpaths, trace
  if !File.exists?("#{@project_path}/mtasc.yaml")
    # Default config...
    config = {
        "app" => File.basename(@file_name),
        "swf" => File.basename(@file_name,".as")+".swf",
        "width" => 800,
        "height" => 600,
        "bgcolor" => "FFFFFF",
        "player" => 8,
        "fps" => 31,
        "preview" => "textmate",
        "trace" => "console",
        "mtasc_path" => "#{ENV['TM_BUNDLE_PATH']}/Support/bin/mtasc"
      }
    return config
  else
    config = YAML.load(File.open("#{@project_path}/mtasc.yaml"))
    # If width or height is a percentage. MTASC chokes because it needs a number. Fix it.
    if config['width'] =~ /%/ || config['height'] =~ /%/
      @size_is_percentage = true
      config['width'].gsub!(/%/,'')
      config['height'].gsub!(/%/,'')
    end
    if config['mtasc_path'].nil?
      config['mtasc_path'] = "#{ENV['TM_BUNDLE_PATH']}/Support/bin/mtasc"
    end
    return config
  end
end

def mtasc_compile
  Dir.chdir(@project_path)
  config = get_config()

  # MTASC binary
  cmd = @q + config['mtasc_path'] + @q

  # App name
  cmd += " " + @q + config['app'] + @q

  # Player version
  cmd += " -version " + config['player'].to_s

  # User-provided Classpath
  if !config['classpaths'].nil?
    cmd += " -cp \"" + config['classpaths'].join('" -cp "') + "\" "
  end

  # Additional parameters from mtasc.yaml
  if config['params']
    cmd += " #{config['params']} "
  end

  if config['trace']
    if config['trace'] == "xtrace"
      `open "$TM_BUNDLE_SUPPORT/bin/XTrace.app"`
      cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/\" "
      cmd += " -pack com/mab/util "
      cmd += " -trace com.mab.util.debug.trace "
    elsif config['trace'] == "console"
      `open -a Console.app "#{ENV['HOME']}/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"`
    elsif config['trace'] == "no"
      cmd += " -trace no "
    else
      cmd += " -trace #{config['trace']} "
    end
  end

  if !File.exists? config['swf']
    cmd += " -header #{config['width']}:#{config['height']}:#{config['fps']}"
  end

  cmd += " -swf #{config['swf']}"

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
    if config['preview'] == "textmate"
      # Preview in TextMate
      output_file = "#{@project_path}/#{config['swf']}"
      if @size_is_percentage
        config['width'] += "%"
        config['height'] += "%"
      end
      puts "<html>"
      puts "<head><title>#{config['swf']}</title></head>"
      puts <<SWF_HTML
      <body style="margin: 0; padding: 0;">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=#{config['version']},0,0,0" width="#{config['width']}" height="#{config['height']}" id="myApplication" align="middle">
        <param name="allowScriptAccess" value="always">
        <param name="allowFullScreen" value="true">
        <param name="movie" value="#{output_file}">
        <param name="quality" value="high">
        <param name="bgcolor" value="##{config['bgcolor']}">
        <embed src="#{output_file}" quality="high" bgcolor="##{config['bgcolor']}" width="#{config['width']}" height="#{config['height']}" name="myApplication" align="middle" allowScriptAccess="always" allowFullScreen="true" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
      </object>
      </body>
      </html>
SWF_HTML
      TextMate.exit_show_html
    else
      # Open user-defined preview
      `open #{config['preview']}`
    end
  else
    TextMate.exit_show_html
  end
end

# compile with MTASC
TextMate.call_with_progress({:title => "MTASC", :message => "Compiling Classes"}) do
  mtasc_compile
end