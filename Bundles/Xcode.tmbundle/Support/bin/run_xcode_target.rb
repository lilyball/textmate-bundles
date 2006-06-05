#!/usr/bin/env ruby -s

require "#{ENV['TM_SUPPORT_PATH']}/lib/plist"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/xcode_version"

def shell_escape (str)
  str.gsub(/[{}()`'"\\; $<>&]/, '\\\\\&')
end

def run_target (dir,objs,target)
  productKey = target['productReference']
  product = objs[productKey]
  file = product['path']
  escaped_dir = shell_escape(File.expand_path(dir))
  escaped_file = shell_escape(file)
  if target['productType'] == 'com.apple.product-type.application' then
    cmd = "cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{escaped_dir} DYLD_LIBRARY_PATH=#{escaped_dir} open ./#{escaped_file}"
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

prefs = PropertyList::load(File.new("#{ENV['HOME']}/Library/Preferences/com.apple.Xcode.plist"))
dir = prefs['PBXProductDirectory'] || File.dirname($project_dir) + "/build"

proj       = PropertyList::load(File.new($project_dir + "/project.pbxproj"))
objs       = proj['objects']
rootObj    = objs[proj['rootObject']]

if Xcode.supports_configurations? then
  userFile      = $project_dir + "/#{ENV['USER']}.pbxuser"
  user          = PropertyList::load(File.new(userFile)) if File.exists?(userFile)
  userBuild     = user && user[proj['rootObject']]['userBuildSettings']
  activeConfig  = user && user[proj['rootObject']]['activeBuildConfigurationName']
  if userBuild['SYMROOT']
    dir = userBuild['SYMROOT']
  end
  dir += "/#{activeConfig || "Development"}"
end

targets = rootObj['targets'].reject { |t| not ['com.apple.product-type.tool', 'com.apple.product-type.application'].include?(objs[t]['productType']) }
if targets.size == 1
  target = objs[targets[0]]
  run_target(dir,objs,target)
elsif targets.size == 0
  puts "The project had no recognizable target to run.\n\n"
  rootObj['targets'].each { |t| puts objs[t].inspect.gsub(/, /, ",\n ") }
else
  unless ENV['XC_TARGET_NAME']
    puts "The project had multiple targets. Didn't know which to pick."
    puts "Try setting project's XC_TARGET_NAME variable."
    targets.each { |t| puts objs[t].inspect }
    exit
  end
  puts "Will try to run target #{ENV['XC_TARGET_NAME']}"
  found_target = targets.find { |t| objs[t]['name'] == ENV['XC_TARGET_NAME']}
  if found_target
    run_target(dir,objs,objs[found_target])
  else
      puts "No such target: #{ENV['XC_TARGET_NAME']}"
      targets.each { |t| puts objs[t].inspect }
      exit
  end
end

