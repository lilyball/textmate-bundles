#!/usr/bin/env ruby

require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/exit_codes'

support = ENV['TM_BUNDLE_SUPPORT']
header_dir = "#{support}/headers"
project_license = ENV['TM_PROJECT_LICENSE']

unless project_license.nil?
  header_file_path = "#{header_dir}/#{project_license}"
  TextMate.exit_show_tool_tip("No license header exists for project license '#{project_license}'") unless File.exist? header_file_path
  header_file = File.new(header_file_path)
  puts header_file.read
else
  entries = nil

  Dir.chdir(header_dir) do
    entries = Dir.glob("*")
  end

  license = TextMate::UI.request_item(
    :items => entries
  )

  header = *open("#{header_dir}/#{license}")
  puts header.join("")
end