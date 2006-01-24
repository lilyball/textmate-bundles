#!/usr/bin/env ruby -s
#
# Checks whether files passed as arguments are bib files, and for those searches all cite keys and 
# returns them as list of options, optionally filtered by a word.
#
# If the files are tex files, looks for any \bibliography entries in them, and uses those bibfiles
#
# First, create list of files to be processed
filelist = Array.new
ARGV.each do |filename|
  if (filename.match(/\.bib$/)) then
    # It's a bib file! Pass it into the list for further work.
    filelist << filename
  elsif  (filename.match(/\.tex$/)) then
    # It's a tex file! search for \bibliography entries.
    # First, fine file's path.
    filepath = File.dirname(filename) + "/"
    File.open(filename) do |file|
      file.each { |line|
        if line.match(/\\bibliography\{([^}]*)(\.bib)?\}/) then
          filelist << (filepath + $1 + ".bib")
        end
      }
    end
  end
end
# Now, process list of files, and add to completions list
completionslist = Array.new
filelist.each do |filename|
  File.open(filename) do |file|
    file.each do |line|
      if line.match(/@[^{]*\{([^, ]*)/) then
        m = $1
        if ($p.nil? || m.downcase.index($p.downcase)==0) then
          completionslist << m
        end
      end
    end
  end
end
print completionslist.sort.join(", ")