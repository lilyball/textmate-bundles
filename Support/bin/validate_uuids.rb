#!/usr/bin/env ruby -wKU

require "find"
require File.join(File.dirname(__FILE__), *%w[.. lib plist])

ROOT_DIR = ARGV.shift || File.join(File.dirname(__FILE__), *%w[.. .. Bundles])

uuids = Hash.new { |ids, id| ids[id] = Array.new }

puts "Searching bundles ..." if $DEBUG
Find.find(ROOT_DIR) do |path|
  if File.file?(path) and File.extname(path) =~ /.*\.(tm[A-Z][a-zA-Z]+|plist)\Z/
    begin
      plist = File.open(path) { |io| PropertyList.load(io) }
      if uuid = plist["uuid"]
        uuids[uuid] << path
      else
        warn "Could not find a UUID for #{path}." if $DEBUG
      end
    rescue
      warn "Skipping #{path} due to #{$!.message}." if $DEBUG
    end
  end
end

duplicates = uuids.select { |_, paths| paths.size > 1 }
if duplicates.empty?
  puts "No duplicates found." if $DEBUG
else
  puts
  puts "UUID Duplicates:"
  puts
  duplicates.each do |uuid, paths|
    puts uuid, paths.map { |path| "  #{path}" }
    puts
  end
  exit 1
end
