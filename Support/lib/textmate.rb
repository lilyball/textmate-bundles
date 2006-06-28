#!/usr/bin/env ruby
$: << "#{ENV['TM_SUPPORT_PATH']}/lib"
require 'plist'

module TextMate

  class << self
    def app_path
      %x{ps -xww -o command|grep TextMate.app|grep -v grep}.sub(%r{/Contents/MacOS/TextMate.*\n}, '')
    end
  end

  class ProjectFileFilter
    def initialize
      @file_pattern = load_pattern('OakFolderReferenceFilePattern', '!(/\.(?!htaccess)[^/]*|\.(tmproj|o|pyc)|/Icon\r)$')
      @folder_pattern = load_pattern('OakFolderReferenceFolderPattern', '!.*/(\.[^/]*|CVS|_darcs|\{arch\}|blib|.*~\.nib|.*\.(framework|app|pbproj|pbxproj|xcode(proj)?|bundle))$')

      @text_types = prefs_for_key('OakProjectTextFiles')     || [ ]
      @binary_types = prefs_for_key('OakProjectBinaryFiles') || [ ".nib" ]
    end

    def prefs_for_key (key)
      prefs_file = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist"
      File.open(prefs_file) do |f|
        return PropertyList::load(f)[key]
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
        return false
      elsif @binary_types.member?(ext) then
        return true
      end

      type = %x{file '#{file.gsub(/'/, "'\\''")}'}
      if /\btext\b/.match(type) then
        @text_types.push(ext) unless(ext == "")
        return false
      else
        @binary_types.push(ext) unless(ext == "")
        return true
      end
    end

    def skip? (file)
      a_directory = File.directory?(file)
      ptrn = a_directory ? @folder_pattern : @file_pattern
      skip_it = ptrn[:regexp].match(file) ? ptrn[:negate] : !ptrn[:negate]
      return (skip_it or a_directory) ? skip_it : binary?(file)
    end
  end

  def TextMate.scan_dir (dir, block, filter)
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

end

# if $0 == __FILE__ then
#   ENV['TM_PROJECT_DIRECTORY'] = "/tmp"
#   TextMate.each_text_file { |f| puts f }
# end
