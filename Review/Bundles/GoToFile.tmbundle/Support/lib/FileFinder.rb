#!/usr/bin/env ruby -wKU

# max number of found files after sorting by score
MAX_OUTPUT = 100

require File.dirname(__FILE__) + '/fuzzy_file_finder'

begin
  project_path = ENV['TM_PROJECT_DIRECTORY'] || ENV['TM_DIRECTORY'] || File.dirname(ENV['TM_FILEPATH'])
rescue
  puts "<i><small>no search path given</small></i>"
  exit
end

search_string = ARGV[0].gsub(/\\ /, '￰').gsub(/ /, '').gsub(/￰/, ' ')

if search_string.empty?
  print ""
  exit
end

# counter for outputted files
cnt = 0

begin
  FuzzyFileFinder.new(project_path).find(search_string).sort{|b,a| a[:score] <=> b[:score] }.each do |p|  
    sc = (p[:score].to_f * 100).to_i
    puts %Q{
    <div class='file'>
      <div  title='#{sc}%' class='score_wrapper'>
        <div class='score' style='width: #{sc}%;'></div>
      </div>
      <div class='in_wrapper'>
        <input class='in' type='text' value=' ➲ ' size='3' readonly onfocus='setFile("#{p[:path]}")'>
      </div>
      <div>
        <span class='mylink' title='#{p[:path].gsub(/^#{ENV['HOME']}/, '~')}' onclick='myClick("#{p[:path]}")'>
    #{p[:highlighted_path].gsub('￰','<span class=\'highlight\'>').gsub('￱','</span>')}
        </span>
      </div>
    </div>
    }
    cnt = cnt + 1
    if cnt > MAX_OUTPUT
      puts "<i><small>… more than #{MAX_OUTPUT} files found.</small></i>"
      break
    end
  end
rescue
  puts $!
end


