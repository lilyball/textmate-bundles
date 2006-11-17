#!/usr/bin/env ruby -s

require "#{ENV['TM_SUPPORT_PATH']}/lib/plist"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/xcode_version"
require 'open3'

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

    def user_settings_data
      user_file     = @project_path + "/#{ENV['USER']}.pbxuser"
      user          = PropertyList::load(File.new(user_file)) if File.exists?(user_file)
    end
      
    def active_configuration_name
      user            = user_settings_data
      active_config   = user && user[@project_data['rootObject']]['activeBuildConfigurationName']      
      active_config || 'Release'
    end
    
    def results_path
      # default to global build results
      prefs = PropertyList::load(File.new("#{ENV['HOME']}/Library/Preferences/com.apple.Xcode.plist"))
      dir = prefs['PBXProductDirectory'] || File.dirname(@project_path) + "/build"
      
      # || user pref for SYMROOT + the active configuration
      if Xcode.supports_configurations? then
        user          = user_settings_data
        userBuild     = user && user[@project_data['rootObject']]['userBuildSettings']
        if userBuild && userBuild['SYMROOT']
          dir = userBuild['SYMROOT']
        end
        dir += "/#{active_configuration_name}"
      end
      dir
    end
    
    def targets
      @root_object['targets'].map { |t| Target.new(self, dereference(t)) }
    end
    
    def dereference(key)
      @objects[key]
    end
    
    # build configuration
    class BuildConfiguration
      def initialize(project, target, config_data)
        @project      = project
        @target       = target
        @config_data  = config_data
      end
      
      def name
        @config_data['name']
      end
      
      def setting(name)
        @config_data['buildSettings'][name]
      end
      
      def product_name
        setting('PRODUCT_NAME')
      end
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
      
      def configurations
        config_list = @project.dereference(@target_data['buildConfigurationList'])
        config_list = config_list['buildConfigurations']
        config_list.map {|config| BuildConfiguration.new(@project, self, @project.dereference(config)) }
      end
      
      def configuration_named(name)
        configurations.find { |c| c.name == name }
      end
      
      def product_path
        product_key = @target_data['productReference']
        product = @project.dereference(product_key)
        product['path']
      end
      
      def inspect
        "Target name:#{@target_data['name']}\nproductName:#{@target_data['productName']}\npath:#{product_path}\n---\n"
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
      
      def run(&block)
        dir_path  = @project.results_path
        file_path = product_path
        escaped_dir = shell_escape(File.expand_path(dir_path))
        escaped_file = shell_escape(file_path)
        
        if is_application?
          setup_cmd = "cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir}"

          # If we have a block, feed it stdout and stderr data
          if block_given? and Xcode.supports_configurations? then
            cmd = %Q{#{setup_cmd} "./#{escaped_file}/Contents/MacOS/#{configuration_named(@project.active_configuration_name).product_name}"}
            block.call(:start, file_path )
            
            stdin, stdout, stderr = Open3.popen3(cmd)
            selections = [stdout, stderr]
            while not selections.empty?
              data = select(selections)
              unless data.nil?
                data[0].each do |d|
                  line = d.gets
                  block.call(d == stdout ? :output : :error , line ) unless line.nil?
                end
              end
              
              # remove closed descriptors
              selections.reject! {|s| s.eof?}
            end

            block.call(:end, 'Process completed.' )
          else
            cmd = "#{setup_cmd} open ./#{escaped_file}"
            %x{#{cmd}}
          end
          
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
  end
  
  class ProjectRunner
    def initialize( projdir )
      @project = Xcode::Project.new(projdir)
    end
    
    def run(&block)
      targets = @project.targets.select { |t| [:application, :tool].include?(t.product_type) }
      case
      when targets.size == 1
        targets.first.run(&block)
      when targets.size == 0
        failed(targets, "The project has no immediately executable target to run.")
      when ENV['XC_TARGET_NAME'].nil?
        failed(targets, "The project has multiple executable products. Didn't know which to pick.\nTry setting project's XC_TARGET_NAME variable.")
      else
        info "Will try to run target #{ENV['XC_TARGET_NAME']}"
        found_target = targets.find { |t| t.name == ENV['XC_TARGET_NAME'] }
        if found_target
          found_target.run(&block)
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
