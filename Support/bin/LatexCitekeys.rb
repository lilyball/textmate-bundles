#!/usr/bin/env ruby -s
#   LatexCitekeys.rb
#   Author: Charilaos Skiadas
#
# Checks whether files passed as arguments are bib files, and for those searches all cite keys and 
# returns them as list of options, optionally filtered by a word.
#
# If the files are tex files, looks for any \bibliography entries in them, and uses those bibfiles
#
# Shell option -p=phrase allows the search for the phrase p. It is stored in variable $p.
#
#################################
#  Helper class for parsing the bib files

class BibfileParser
# To be used with a block. Feeds to the block hash tables with entries: citekey author and title
# file is supposed to be a string with the contents of the bibfile
  def parsefile(file)
    info = Hash.new
    array = file.split("\n")
    line = ""
    until (array.empty? || line.match(/@[^{]*\{([^, ]*),/))
      line = array.shift
    end
    until (array.empty?)
      info["citekey"] = $1
      line = array.shift.strip
      until (array.empty? || line.match(/@[^{]*\{([^, ]*),/))
        if line.match(/(Editor|Author|Title) *= *\{(.*)\},$/i) then
          m1, m2 = $1, $2
          info[m1.downcase.sub("editor","author")] = m2
        end
        line = array.shift.strip
      end
      yield info
    end
    return
  end
end
##############################
#### Actual program
#
#
# First, create list of files to be processed
bibfilelist = Array.new
texfilelist = Array.new
bibpathlist = `kpsewhich -show-path=bib`.split(/:!!|:/) # list to locations for bib files
bibpathlist.unshift("")
texpathlist = `kpsewhich -show-path=tex`.split(/:!!|:/) # list to locations for tex files
texpathlist.unshift("")
initialfilelist = Array.new
ARGV.each {|filename| if File.exist?(filename) then initialfilelist << filename end}
initialfilelist.each do |filename|
  if File.exist?(filename) then
    if (filename.match(/\.bib$/)) then
      # It's a bib file! Pass it into the list for further work.
      bibfilelist << filename
    else
      # It's a tex file! pass it to the texfilelist
      texfilelist << filename
    end
  end
end
visitedfiles = Hash.new
### Create list of bib files by recursively traversing texfiles and files \included in them.
until (texfilelist.empty?)
  filename = texfilelist.shift
  # Have we visited this file already?
  unless visitedfiles.has_key?(filename) then
    visitedfiles[filename] = filename
    # First, find file's path.
    filepath = File.dirname(filename) + "/"
    File.open(filename) do |file|
      file.each do |line|
        # search for bibliography links
        if line.match(/\\bibliography\{([^}]*)\}/) then
          m = $1
          # Need to deal with the case of multiple words here, separated by comma.
          list = m.split(',')
          list.each do |item|
            # need to look at all paths in bibpathlist for the file
#puts (bibpathlist << filepath)
            (bibpathlist << filepath).each do |path|
              testfilepath = path + item.strip.sub(/\.bib$/,'') + ".bib"
#puts testfilepath
              if File.exist?(testfilepath) then
#puts testfilepath
                bibfilelist << testfilepath
                # Found first file with this filename
#                break
              end
            end
          end
        end
        # search for texfile include links
        if line.match(/\\include\{([^}]*)\}/) then
          m = $1
          # Need to deal with the case of multiple words here, separated by comma.
          list = m.split(',')
          list.each do |item|
            # need to look at all paths in texpathlist for the file
            (texpathlist << filepath).each do |path|
              testfilepath = path + item.strip.sub(/\.tex$/,'') + ".tex"
              if File.exist?(testfilepath) then
                texfilelist << testfilepath
                # Found first file with this filename
                break
              end
            end
          end
        end
      end
    end
  end
end
### Now, process list of files, and add to completions list
completionslist = Array.new
if ($full.nil?) then  
# Case where we don't need the titles as comments
  bibfilelist.each do |filename|
    File.open(filename) do |file|
      BibfileParser.new.parsefile(file.read) do |info|
        # This is the case when it's used from the inline completion command. 
        # Just searches for phrase in beginning of citekey.
        # NOTE: The case must also match.
        if ($p.nil? || (info["citekey"]).index($p) == 0) then
           completionslist << info["citekey"]
        end
      end
    end
  end
else
# Case where we return the titles and authors as well.
# Results are in the form "citekey % author % title".
  bibfilelist.each do |filename|
    File.open(filename) do |file|
      BibfileParser.new.parsefile(file.read) do |info|
        if ($p.nil? || ((info["citekey"] + info["author"]) + info["title"]).downcase.match($p.downcase)) then
          citekey = info["citekey"]
          author = info["author"].gsub(/\\\'|\'/,'')
          title = info["title"].gsub(/\\\'|\'/,'')
          completionslist << ("'#{citekey} \% #{author} \% #{title}'")
        end
      end
    end
  end
end
print completionslist.sort.join(", ")