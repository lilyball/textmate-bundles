#!/usr/bin/env ruby

# Copyright:
#   (c) 2006 syncPEOPLE, LLC.
#   Visit us at http://syncpeople.com/
# Author: Duane Johnson (duane.johnson@gmail.com)
# Description:
#   Gives the option of directly installing a plugin from the bundle to your
#   application.  Plugins listed in the drop-down box are stored in Support/plugins.

require 'rails_bundle_tools'
require 'fileutils'

plugins = Dir.glob(File.join(TextMate.bundle_path, 'Support', 'plugins', '*'))
names = plugins.map { |p| File.basename(p).gsub('_', ' ') }

# $logger.warn plugins.inspect

if choice = TextMate.choose("Choose a plugin to install:", names)
  source = plugins[choice]
  root = RailsPath.new.rails_root
  
  if root.nil?
    TextMate.message "Can't find the Rails application directory structure."
    TextMate.exit_discard
  end
  
  destination = File.join(root, 'vendor', 'plugins', File.basename(plugins[choice]))
  if File.exist?(destination)
    if !TextMate.message_yes_no_cancel("Overwrite the plugin?", :informative_text => "It appears that the plugin is already installed.")
      TextMate.exit_discard
    end
    FileUtils.rm_rf(destination)
  end

  FileUtils.cp_r source, destination
  TextMate.message("Installation successful.  Don't forget to restart your development server.")
end