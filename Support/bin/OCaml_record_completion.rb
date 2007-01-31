#!/usr/bin/env ruby

require 'fileutils'

FileUtils.cd(File.dirname(ENV['TM_FILEPATH']))
lines = File.open(ENV['TM_FILEPATH'],'r').read()

packages = `/opt/local/godi/bin/ocamlfind list`.scan(/^\S+/).join(',')

openmodules = lines.scan(/\bopen\s+([A-Z][a-zA-Z0-9_.]+)/).map { |arr| arr[0] }
if ENV['TM_FILEPATH']
  openmodules << File.basename(ENV['TM_FILEPATH'])[/(.*)\.ml/,1].capitalize
end

currentword = Regexp.escape(ENV['TM_CURRENT_WORD'].to_s)

completions = openmodules.map { |modname|
  `/opt/local/godi/bin/cmigrep -package '#{packages}' -r '#{currentword}' #{modname}`.split(/\n/) 
}.flatten.select { |s| s =~ /\(\*/ }.map { |s| s[/^(?:mutable )?([^:]+)/,1] }.sort.uniq

puts completions.join("\n")
