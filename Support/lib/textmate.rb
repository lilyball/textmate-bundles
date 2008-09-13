#!/usr/bin/env ruby
require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"
require "#{ENV['TM_SUPPORT_PATH']}/lib/exit_codes"

module TextMate

  class AppPathNotFoundException < StandardError; end

  class << self
    def app_path
      return %x{ps -xwwp "$TM_PID" -o "command"|tail -n1}.sub(%r{(.app)/Contents/MacOS/.*\n}, '\1') if ENV.has_key? 'TM_PID'

      # legacy code, required before TextMate r1466
      apps = %x{ps -xwwco "pid command"}
      apps.send(apps.respond_to?(:lines) ? :lines : :to_s).grep(/^\s*(\d+)\s+(TextMate)$/) do |match|
        return %x{ps -xwwp #{$1} -o "command"|tail -n1}.sub(%r{(.app)/Contents/MacOS/TextMate.*\n}, '\1')
      end
      raise AppPathNotFoundException
    end

    def go_to(options = {})
      default_line = options.has_key?(:file) ? 1 : ENV['TM_LINE_NUMBER']
      options = {:file => ENV['TM_FILEPATH'], :line => default_line, :column => 1}.merge(options)
      if options[:file]
        `open "txmt://open?url=file://#{e_url options[:file]}&line=#{options[:line]}&column=#{options[:column]}"`
      else
        `open "txmt://open?line=#{options[:line]}&column=#{options[:column]}"`
      end
    end

    def require_cmd(command, message = nil)
      if `which "#{command}"`.empty?
        require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'
        
        TextMate::HTMLOutput.show(
          :title      => "Command Not Found",
          :sub_title  => "Command Not Found - #{command}"
        ) do |io|
          io << <<-HTML
            <h3 class="error">Unable to locate <tt>#{command}</tt></h3>

            <p>#{message || "To succesfully run this action you need to
            install <tt>«#{command}»</tt>. If you know that it is already
            installed on your system, you instead need to update
            your search path.</p>

            <p>The manual has a section about
            <a href=\"help:anchor='search_path'%20bookID='TextMate%20Help'\">
            how to update your search path</a>."}</p>

            <p>For diagnostic purposes, the paths searched for <tt>«#{command}»</tt> were:</p>

            <ul>
              #{`echo $PATH`.gsub(/:/, "\n").gsub(/^(.*)$/, "<li>\\&</li>")}
            </ul>
          HTML
        end
        
        TextMate.exit_show_html
      end
    end

    def min_support(version)
      actual_version = ::IO.read(ENV['TM_SUPPORT_PATH'] + '/version').to_i
      if actual_version < version then
		require "#{ENV['TM_SUPPORT_PATH']}/lib/ui"		
        TextMate::UI.request_confirmation(:title => "Support Folder is Outdated", :prompt => "Your version of the shared support folder is too old for this action to run.\n\nYou need version #{version} but only have #{actual_version}.", :button1 => "More Info") do
          help_url = "file://#{e_url(self.app_path + '/Contents/Resources/English.lproj/TextMate Help Book/bundles.html')}#support_folder"
          %x{ open #{e_sh help_url} }
          # # unfortuantely the help viewer ignores the fragment specifier of the URL
          # %x{ osascript <<'APPLESCRIPT'
          # 	tell app "Help Viewer"
          # 	  handle url "#{e_as help_url}"
          # 	  activate
          # 	end tell	
          # }
        end
        raise SystemExit
      end
    end

    def rescan_project
      `osascript &>/dev/null \
    	   -e 'tell app "SystemUIServer" to activate'; \
    	 osascript &>/dev/null \
    	   -e 'tell app "TextMate" to activate' &`
    end
  end

  class ProjectFileFilter
    def initialize
      @file_pattern = load_pattern('OakFolderReferenceFilePattern', '!(/\.(?!htaccess)[^/]*|\.(tmproj|o|pyc)|/Icon\r)$')
      @folder_pattern = load_pattern('OakFolderReferenceFolderPattern', '!.*/(\.[^/]*|CVS|_darcs|\{arch\}|blib|.*~\.nib|.*\.(framework|app|pbproj|pbxproj|xcode(proj)?|bundle))$')

      @text_types = prefs_for_key('OakProjectTextFiles')     || [ ]
      @text_types.collect! { |ext| '.' + ext }
      @binary_types = prefs_for_key('OakProjectBinaryFiles') || [ "nib" ]
      @binary_types.collect! { |ext| '.' + ext }
    end

    def prefs_for_key (key)
      prefs_file = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist"
      File.open(prefs_file) do |f|
        return OSX::PropertyList::load(f)[key]
      end
    end

    def load_pattern (key, default_pattern)
      str = prefs_for_key(key)
      str = default_pattern if str.to_s.empty?
      if str[0] == ?! then
        { :regexp => Regexp.new(str[1..-1]), :negate => true }
      else
        { :regexp => Regexp.new(str), :negate => false }
      end
    end

    def binary? (file)
      ext = File.extname(file)
      if @text_types.member?(ext) then
        false
      elsif @binary_types.member?(ext) then
        true
      else
        # ask the file shell command about the type
        case `file #{e_sh file}`
        when /\bempty\b/ then
          # treat empty files as binary, but do not record the extension
          true
        when /\btext\b/ then
          @text_types << ext unless ext.empty?
          false
        else
          @binary_types << ext unless ext.empty?
          true
        end
      end
    end

    def skip? (file)
      a_directory = File.directory?(file)
      ptrn = a_directory ? @folder_pattern : @file_pattern
      skip_it = ptrn[:regexp].match(file) ? ptrn[:negate] : !ptrn[:negate]
      return (skip_it or a_directory) ? skip_it || File.symlink?(file) : binary?(file)
    end
  end

  def TextMate.scan_dir (dir, block, filter)
    return unless File.executable?(dir)
    Dir.entries(dir).each do |filename|
      fullpath = File.join(dir, filename)
      if(filter.skip?(fullpath)) then
        # skip hidden files and folders
      elsif(File.directory?(fullpath)) then
        scan_dir(fullpath, block, filter)
      else
        block.call(fullpath)
      end
  	end
  end

  def TextMate.each_text_file (&block)
    project_dir = ENV['TM_PROJECT_DIRECTORY']
    current_file = ENV['TM_FILEPATH']

    if project_dir then
      TextMate.scan_dir(project_dir, block, ProjectFileFilter.new)
    elsif current_file then
      block.call(current_file)
    end
  end
  
  # returns a array if all currently selected files or nil
  def TextMate.selected_files( tm_selected_files = ENV['TM_SELECTED_FILES'] )
    return nil  if tm_selected_files.nil? or tm_selected_files.empty?
    require 'shellwords'
    Shellwords.shellwords( tm_selected_files )
  end
  
end

# if $0 == __FILE__ then
#   ENV['TM_PROJECT_DIRECTORY'] = "/tmp"
#   TextMate.each_text_file { |f| puts f }
# end
