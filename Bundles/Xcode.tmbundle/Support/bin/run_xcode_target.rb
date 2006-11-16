#!/usr/bin/env ruby -s

require "#{ENV['TM_SUPPORT_PATH']}/lib/plist"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/xcode_version"
#require 'pp'

def shell_escape (str)
  str.gsub(/[{}()`'"\\; $<>&]/, '\\\\\&')
end

class Xcode
  
  # project file
  class Project
    attr_reader :objects
    
    def initialize(path_to_xcodeproj)
      @project_path = path_to_xcodeproj
      @project_data = PropertyList::load(File.new(path_to_xcodeproj + "/project.pbxproj"))
      @objects      = @project_data['objects']
      @root_object  = @objects[@project_data['rootObject']]
    end
    
    def results_path
      # default to global build results
      prefs = PropertyList::load(File.new("#{ENV['HOME']}/Library/Preferences/com.apple.Xcode.plist"))
      dir = prefs['PBXProductDirectory'] || File.dirname(@project_path) + "/build"
      
      # || user pref for SYMROOT + the active configuration
      if Xcode.supports_configurations? then
        userFile      = @project_path + "/#{ENV['USER']}.pbxuser"
        user          = PropertyList::load(File.new(userFile)) if File.exists?(userFile)
        userBuild     = user && user[@project_data['rootObject']]['userBuildSettings']
        activeConfig  = user && user[@project_data['rootObject']]['activeBuildConfigurationName']
        if userBuild && userBuild['SYMROOT']
          dir = userBuild['SYMROOT']
        end
        dir += "/#{activeConfig || "Release"}"
      end
      dir
    end
    
    # targets
    class Target
    
      def initialize(project, target_data)
        @project      = project
        @target_data  = target_data
      end
      
      def name
        @target_data['name']
      end
      
      def product_path
        productKey = @target_data['productReference']
        product = @project.objects[productKey]
        product['path']
      end
      
      def inspect
        "Target name:#{@target_data['name']} productName:#{@target_data['productName']} path:#{product_path}"
      end
      
      def product_type
        case @target_data['productType']
        when 'com.apple.product-type.application'
          :application
        when 'com.apple.product-type.tool'
          :tool
        end
      end
      
      def is_application?
        product_type == :application
      end
      
      def is_tool?
        product_type == :tool
      end
      
      def run(detach = true)
        dir_path  = @project.results_path
        file_path = product_path
        escaped_dir = shell_escape(File.expand_path(dir_path))
        escaped_file = shell_escape(file_path)
        
        if is_application?
          # TODO: we need to parse the build configurations to retrieve the PRODUCT_NAME key to be able to find the executable so that we can directly run it and thus remain attached to the the output stream. 'productName' seems to be obsolete and ignored.
          # if detach then
            cmd = "cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir} open ./#{escaped_file}"
          # else
          #   cmd = "cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir} ./#{escaped_file}/Contents/MacOS/#{@target_data['productName']}"
          # end
          %x{#{cmd}}
        else
          cmd  = "clear; cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir} ./#{escaped_file}; echo -ne \\\\n\\\\nPress RETURN to Continue...; read foo;"
          cmd += 'osascript &>/dev/null'
          cmd += ' -e "tell app \"TextMate\" to activate"'
          cmd += ' -e "tell app \"Terminal\" to close first window" &'

          %x{osascript \
            -e 'tell app "Terminal"' \
            -e 'activate' \
            -e 'do script "#{cmd.gsub(/[\\"]/, '\\\\\\0')}"' \
            -e 'set position of first window to { 100, 100 }' \
            -e 'set custom title of first window to "#{file}"' \
            -e 'end tell'
          }
        end
        
      end
    end
    
    def targets
      @root_object['targets'].map { |t| Target.new(self, dereference(t)) }
    end

  private
      def dereference(key)
        @objects[key]
      end
  end
  
  class ProjectRunner
    def initialize( projdir )
      @project = Xcode::Project.new(projdir)
    end
    
    def run(detach = true)
      targets = @project.targets.select { |t| [:application, :tool].include?(t.product_type) }
      case
      when targets.size == 1
        targets.first.run(detach)
      when targets.size == 0
        failed(targets, "The project has no immediately executable target to run.")
      when ENV['XC_TARGET_NAME'].nil?
        failed(targets, "The project has multiple targets. Didn't know which to pick.\nTry setting project's XC_TARGET_NAME variable.")
      else
        info "Will try to run target #{ENV['XC_TARGET_NAME']}"
        found_target = targets.find { |t| t.name == ENV['XC_TARGET_NAME'] }
        if found_target
          found_target.run(detach)
        else
          failed(targets, "No such target: #{ENV['XC_TARGET_NAME']}")
        end
      end
    end
    
    def info(message)
      puts message
    end
    
    def failed(targets, message)
      puts message.chomp + "\n\n"
      targets.each {|t| puts t.inspect }
    end
  end
  
  class HTMLProjectRunner < ProjectRunner
    def info(message)
      puts message.gsub(/\n/, '<br>\n')
    end
    
    def failed(targets, message)
      puts message + "\n<ul>"
      targets.each {|t| puts "<li>target:<strong>#{t.name}</strong> product:<strong>#{t.product_path}</strong></li>" }
      puts '</ul>'
    end
  end
end

if __FILE__ == $0
  runner = Xcode::ProjectRunner.new($project_dir)
  runner.run
end
