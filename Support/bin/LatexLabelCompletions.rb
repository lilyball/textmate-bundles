#!/usr/bin/env ruby
# Searches current file for \label{} commands. If in a project setting, and if TM_LATEX_MASTER is set, then
# searches all files \include'd in the master latex file.
#
#
#####################
# Helper function
#####################
def recursiveFileSearch(initialList,fileExt)
  extraPathList = ([`kpsewhich -show-path=#{fileExt}`.chomp.split(/:!!|:/)].flatten.map{|i| i.sub(/\/*$/,'/')})
  extraPathList.unshift("")
  case fileExt 
    when "bib" then regexp = /\\bibliography\{([^}]*)\}/
    when "tex" then regexp = /\\(?:include|input)\{([^}]*)\}/   # ?: don't capture group
    else return
  end
  visitedFilesList = Hash.new
  tempFileList = initialList.clone
  listToReturn = Array.new
  until (tempFileList.empty?) 
    filename = tempFileList.shift
    # Have we visited this file already?
    unless visitedFilesList.has_key?(filename) then
      visitedFilesList[filename] = filename
      # First, find file's path.
      filepath = File.dirname(filename) + "/"
      File.open(filename) do |file|
        file.each do |line|
          # search for links
          if line.match(regexp) then
            m = $1
            # Need to deal with the case of multiple words here, separated by comma.
            list = m.split(',')
            list.each do |item|
              item.strip!
              # need to look at all paths in extraPathList for the file
              (extraPathList << filepath).each do |path|
                testFilePath = path + if (item.slice(-4,4) != ".#{fileExt}") then item + ".#{fileExt}" else item end
                if File.exist?(testFilePath) then
                  listToReturn << testFilePath
                  if (fileExt == "tex") then tempFileList << testFilePath end
                  if block_given? then 
                    File.open(testFilePath) {|file| yield file}
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return listToReturn
end
######################
# Program start
######################
#
# Work with the current file; if TM_LATEX_MASTER is set, work with both
# Thanks to Alan Schussman
#
filelist = if (ENV.has_key?("TM_LATEX_MASTER")) then
          [ENV["TM_FILEPATH"], ENV["TM_LATEX_MASTER"]]
        else
          [ENV["TM_FILEPATH"]]
        end

# Recursively find all relevant files. Don't forget to include current files
filelist += recursiveFileSearch(filelist,"tex")
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
filelist.uniq.each {|filename|
  File.open("#{filename}") do |theFile|
    theFile.each { |line|
      if line.match(matchregex)
        m = $~
        completionslist << "#{m[1]}"
      end
    }
  end
}
print completionslist.uniq.sort.join("\n")