#!/usr/bin/env ruby
path = ARGV.first || ENV['TM_FILEPATH']
parents = [case path
  when %r{/controllers/}, %r{_controller\.rb$} then 'test/functional'
  when %r{/(models|helpers)/} then 'test/unit'
  when %r{/test/unit/} then %w(app/models app/helpers lib)
  when %r{/test/functional/} then 'app/controllers'
  when %r(/test/|(_test\.rb$)) then %w(app lib)
end].flatten
 
file_name = File.basename path
if parents.any? { |parent| parent =~ %r{test(/|$)} }
  file_name.gsub! /\.rb$/, '_test.rb'
else
  file_name.gsub! /_test\.rb$/, '.rb'
end
 
find_parents = parents.collect { |parent| File.join(ENV['TM_PROJECT_DIRECTORY'], parent).inspect }
 
matches = `find #{find_parents * ' '} -name #{file_name}`.strip.split("\n").collect {|match| match.strip}

`mate #{matches}` unless matches.empty?
