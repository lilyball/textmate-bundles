#!/usr/bin/ruby
PROJECT_ROOT = ARGV[0] # Where to browse for images
RESOURCES_DIR = ARGV[1] + "/Resources" # Where to find ImageBrowser's images
require ARGV[1] + "/Tools/image_size"
require 'erb'

erb = ERB.new(IO.read(ARGV[1] + '/Resources/browser.rhtml'))
erb.run