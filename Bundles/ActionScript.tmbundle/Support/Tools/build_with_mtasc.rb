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
require "erb"

require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
require ENV['TM_SUPPORT_PATH'] + "/lib/progress"
require ENV["TM_SUPPORT_PATH"] + "/lib/web_preview"

# Some routes
@file_path = File.dirname(ENV['TM_FILEPATH'])
@file_name = ENV['TM_FILENAME']
@project_path = ENV['TM_PROJECT_DIRECTORY']

def get_build_path
  if File.exist?("#{@file_path}/mtasc.yaml")
    return @file_path + "/"
  end
  if File.exist?("#{@project_path}/mtasc.yaml")
    return @project_path + "/"
  end
  return false
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
  @build_path = get_build_path()
  if !@build_path
    @build_path = @file_path + "/"
    @config = YAML.load(File.open(ENV['TM_BUNDLE_SUPPORT'] + "/mtasc.yaml"))
    @config['app'] = File.basename(@file_name)
    @config['swf'] = File.basename(@file_name,".as")+".swf"
    @config['mtasc_path'] = "#{ENV['TM_BUNDLE_SUPPORT']}/bin/mtasc"
  else
    @config = YAML.load(File.open(@build_path + "mtasc.yaml"))
    # If width or height is a percentage. MTASC chokes because it needs a number. Fix it.
    if @config['width'] =~ /%/ || @config['height'] =~ /%/
      @size_is_percentage = true
      @config['width'].gsub!(/%/,'')
      @config['height'].gsub!(/%/,'')
    end
    if @config['mtasc_path'].nil?
      @config['mtasc_path'] = "#{ENV['TM_BUNDLE_SUPPORT']}/bin/mtasc"
    end
  end
  return @config
end

def preview
  return ERB.new(IO.read("#{ENV['TM_BUNDLE_SUPPORT']}/swf_template.rhtml")).result
end

def mtasc_compile
  config = get_config()

  # MTASC binary
  cmd = @q + @config['mtasc_path'] + @q

  # App name
  cmd += " " + @q + @config['app'] + @q

  # Player version
  cmd += " -version " + @config['player'].to_s

  # User-provided Classpath
  if !@config['classpaths'].nil?
    cmd += " -cp \"" + @config['classpaths'].join('" -cp "') + "\" "
  end

  # Additional parameters from mtasc.yaml
  if @config['params']
    cmd += " #{@config['params']} "
  end

  if @config['trace']
    case @config['trace']
      when "xtrace"
        %x(open "$TM_BUNDLE_SUPPORT/bin/XTrace.app")
        cmd += " -cp \"#{ENV['TM_BUNDLE_SUPPORT']}/lib/\" -pack com/mab/util -trace com.mab.util.debug.trace "
      when "console"
        log_file_path = "#{ENV['HOME']}/Library/Preferences/Macromedia/Flash Player/Logs/"
        if(!File.exist?(log_file_path))
          Dir.mkdir(log_file_path)
          File.new("#{log_file_path}/flashlog.txt",'w')
        end
        %x(open -a Console.app "#{log_file_path}/flashlog.txt")
      when "terminal"
        log_file_path = "#{ENV['HOME']}/Library/Preferences/Macromedia/Flash Player/Logs/"
        if(!File.exist?(log_file_path))
          Dir.mkdir(log_file_path)
          File.new("#{log_file_path}/flashlog.txt",'w')
        end
        %x(osascript "$TM_BUNDLE_SUPPORT/Tools/tail.applescript")
      when "no"
        cmd += " -trace no "
      else
        cmd += " -trace #{@config['trace']} "
    end
  end

  if !File.exists? @config['swf']
    cmd += " -header #{@config['width']}:#{@config['height']}:#{@config['fps']}"
  end

  cmd += " -swf #{@config['swf']}"

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
    if @config['preview'] == 'textmate'
      puts preview()
      TextMate.exit_show_html
    else
      %x(open #{@config['preview']})
    end
  else
    TextMate.exit_show_html
  end
end

# compile with MTASC
TextMate.call_with_progress({:title => "MTASC", :message => "Compiling Classes"}) do
  mtasc_compile
end