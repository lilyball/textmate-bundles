#!/usr/bin/env ruby
# Searches current file for \label{} commands. If in a project setting, and if TM_LATEX_MASTER is set, then
# searches all files \include'd in the master latex file.
#
#
# If TM_LATEX_MASTER is present, look for all \include commands in it, and add those files to the search.
# Otherwise, work with current file.
if (ENV.has_key?("TM_LATEX_MASTER")) then
  masterfile = ENV["TM_LATEX_MASTER"].to_s
else
  masterfile = ENV["TM_FILEPATH"].to_s
end
filepath = File.dirname(masterfile) + "/"
filelist = Array.new
filelist << ENV["TM_FILEPATH"].to_s
File.open("#{masterfile}") do |theFile|
  theFile.each { |line|
    if line.match(/\\include\{([^}]*)(\.tex)?\}/) then
      filelist << (filepath + $1 + ".tex")
    end
  }
end

# Get label prefix to expand
if !(ENV.has_key?("TM_CURRENT_WORD")) then
  matchregex = /^(.*)\\label\{([^}]*)\}/
else
  word = ENV["TM_CURRENT_WORD"].to_s
  if !(/\{/.match(word)) then
    word = word.gsub(/\}/,'')
    matchregex = Regexp.new("\\\\label\\{(#{word}[^}]*)\\}")
  else
    matchregex = /\\label\{([^}]*)\}/
  end
end
# Process the filelist looking for \label{} commands.

completionslist= Array.new
filelist.each {|filename|
  File.open("#{filename}") do |theFile|
    theFile.each { |line|
      if line.match(matchregex)
        m = $~
        completionslist << "#{m[1]}"
      end
    }
  end
}
print completionslist.sort.join("\n")