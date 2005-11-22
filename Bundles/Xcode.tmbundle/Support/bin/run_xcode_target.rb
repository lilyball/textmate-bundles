#!/usr/bin/ruby -s

require "#{ENV['TM_SUPPORT_PATH']}/lib/plist"
require "#{ENV['TM_BUNDLE_SUPPORT']}/bin/xcode_version"

def shell_escape (str)
  str.gsub(/[{}()`'"\\; $<>&]/, '\\\\\&')
end

prefs = PropertyList::load(File.new("#{ENV['HOME']}/Library/Preferences/com.apple.Xcode.plist"))
dir = prefs['PBXProductDirectory'] || File.dirname($project_dir) + "/build"

proj       = PropertyList::load(File.new($project_dir + "/project.pbxproj"))
objs       = proj['objects']
rootObj    = objs[proj['rootObject']]

if Xcode.supports_configurations? then
  userFile      = $project_dir + "/#{ENV['USER']}.pbxuser"
  user          = PropertyList::load(File.new(userFile))
  activeConfig  = user[proj['rootObject']]['activeBuildConfigurationName']
  dir += "/#{activeConfig || "Development"}"
end

targets = rootObj['targets'].reject { |t| not ['com.apple.product-type.tool', 'com.apple.product-type.application'].include?(objs[t]['productType']) }
if targets.size == 1
  target = objs[targets[0]]
  productKey = target['productReference']
  product = objs[productKey]
  file = product['path']
  escaped_dir = shell_escape(dir)
  escaped_file = shell_escape(file)
  expanded_dir = escaped_dir.gsub(/^~/, ENV['HOME'])
  if target['productType'] == 'com.apple.product-type.application' then
    cmd = "cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{expanded_dir} DYLD_LIBRARY_PATH=#{expanded_dir} open ./#{escaped_file}"
    %x{#{cmd}}
  else
    cmd  = "clear; cd #{escaped_dir}; env DYLD_FRAMEWORK_PATH=#{expanded_dir} DYLD_LIBRARY_PATH=#{expanded_dir} ./#{escaped_file}; echo -ne \\\\n\\\\nPress RETURN to Continue...; read foo;"
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
else
  puts "The project had multiple targets.\nDidn't know which to pick."
end
