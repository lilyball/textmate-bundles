#!/usr/bin/env ruby -s

ENV['TM_SUPPORT_PATH'] = "/Users/chris/Library/Application Support/TextMate/Support"
ENV['TM_BUNDLE_SUPPORT'] = "/Users/chris/Library/Application Support/TextMate/Bundles/Xcode.tmbundle/Support"

require "#{ENV['TM_SUPPORT_PATH']}/lib/osx/plist"
require "#{ENV['TM_SUPPORT_PATH']}/lib/escape"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/xcode_version"
require 'open3'
require 'pty'

class Xcode
  
  # N.B. lots of cheap performance wins to be made by aggressive (or any) caching.
  # Not clear it's worthwhile. Could also be stale if these objects live a long time and
  # the user makes changes to the project in Xcode.
  
  # project file
  class Project
    attr_reader :objects
    attr_reader :root_object
    
    def initialize(path_to_xcodeproj)
      @project_path = path_to_xcodeproj
      @project_data = PropertyList::load(File.new(path_to_xcodeproj + "/project.pbxproj"))
      @objects      = @project_data['objects']
      @root_object  = @objects[@project_data['rootObject']]
    end

    def user_settings_data
      user_file     = @project_path + "/#{`whoami`.chomp}.pbxuser"
      user          = PropertyList::load(File.new(user_file)) if File.exists?(user_file)
    end
        
    def active_configuration_name
      raise unless Xcode.supports_configurations?
      
      user            = user_settings_data
      active_config   = user && user[@project_data['rootObject']]['activeBuildConfigurationName']

      active_config || configurations.first.name
    end

		def configurations
			targets.first.configurations
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

    def source_root
      root = @root_object['projectRoot']
      if root.nil? or root.empty?
        root = File.expand_path(File.dirname(@project_path))
      end
      root
    end

    def source_tree_for_group(group)
      type      = false
      path      = group['path']
      case group['sourceTree']
      when '<group>'
        type = :group
      when '<absolute>'
        type = :absolute
      when 'SOURCE_ROOT'
        path = source_root + "/" + path
        type = :source_root
      else
        puts "unknown sourceTree:#{group['sourceTree']}"
      end # case
      [type, path]
    end
    
    def nodepath_for_ref(ref, group, parents)      
      # maybe we're the parent
      return nil unless group['isa'] == 'PBXGroup'

      parents = parents.dup
      parents << group      

      children = group['children']
    
      # is the path in this group?
      if children.include?(ref) then
        return parents
      else
        out_parents = nil
        children.find do |child|
          out_parents = nodepath_for_ref(ref, dereference(child), parents)
          out_parents
        end
        out_parents
      end
    end
  
    
    def path_for_fileref(ref)
      # find the node path
      value = nodepath_for_ref(ref, dereference(@root_object['mainGroup']), Array.new) 
      return nil if value.nil?
      
      # create a filesystem path
      fs_path = source_root
      
      value.each do |group|
        type, segment = source_tree_for_group(group)
        unless type == :group
          fs_path = segment
        end
      end
      fs_path
    end
    
    def path_for_basename(basename)
      path = nil
      @objects.each_pair do |key, obj|
        next unless obj['isa'] == 'PBXFileReference'
        next unless obj['path'] == basename
        path = path_for_fileref(key) + '/' + basename
        break
      end
      path
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
        setting('PRODUCT_NAME') || @target.name
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
        escaped_dir = e_sh(File.expand_path(dir_path))
        escaped_file = e_sh(file_path)
        
        if is_application?
          setup_cmd = %Q{cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir}}

          # If we have a block, feed it stdout and stderr data
          if block_given? and Xcode.supports_configurations? then
            executable = "./#{file_path}/Contents/MacOS/#{configuration_named(@project.active_configuration_name).product_name}"

            cmd = %Q{#{setup_cmd} #{e_sh executable}}
            block.call(:start, file_path )

            # If the executable doesn't exist, PTY.spawn might not return immediately
						executable_path = File.expand_path(dir_path) + '/' + executable
            if not File.exist?(executable_path)
              block.call(:error, "Executable doesn't exist: #{executable_path}")
              return nil
            end
            
            # NSLog needs a tty. PTY.spawn throws a bogus exception when the process exits.
            begin
              PTY.spawn(cmd) do |reader, writer, pid|
                line = reader.gets
                until line.nil?
                  block.call(:output, line )
                  line = reader.gets
                end
              end
            rescue
            end
            
            block.call(:end, 'Process completed.' )
          else
            cmd = "#{setup_cmd} open ./#{escaped_file}"
            %x{#{cmd}}
          end
          
        else
          block.call(:start, escaped_dir )

          cmd  = "clear; cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir} ./#{escaped_file}; echo -ne \\\\n\\\\nPress RETURN to Continue...; read foo;"
          cmd += 'osascript &>/dev/null'
          cmd += ' -e "tell app \"TextMate\" to activate"'
          cmd += ' -e "tell app \"Terminal\" to close first window" &'

          %x{osascript \
            -e 'tell app "Terminal"' \
            -e 'activate' \
            -e 'do script "#{cmd.gsub(/[\\"]/, '\\\\\\0')}"' \
            -e 'set position of first window to { 100, 100 }' \
            -e 'set custom title of first window to "#{file_path}"' \
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
    
    # intercept formatter output to highlight files in the standard file:line:(column:)? format.
    def run(&original_block)
      super do |type, line|
        case type
        when :output
          begin
            type = :HTML
            line = htmlize(line.chomp)
            line = line.gsub(/((\w|\.|\/)+):(\d+):((\d+):)?(?!\d+\.\d+)/) do |string|
              # the negative lookahead suffix prevents matching the NSLog time prefix
            
              path        = @project.path_for_basename($1)
              line_number = $3
              column      = $4.nil? ? '' : "&column=#{$5}"
              
              if path != nil and File.exist?(path) then
                %Q{<a href="txmt://open?url=file://#{e_url(path)}&line=#{line_number}#{column}">#{string}</a>}
              else
                string
              end
            end
          rescue Exception => exception
            line = "==> <b>Exception during output formatting:</b>\n #{htmlize(exception.backtrace)}\n\n"
          end
        end
        original_block.call(type, line)
      end
    end
    
    def info(message)
      puts output.gsub(/\n/, '<br>\n')
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
