#!/usr/bin/env ruby

require "tmpdir"
require ENV["TM_SUPPORT_PATH"] + "/lib/escape"

scratchdir = ENV["TM_SCRATCH_DIRECTORY"] || Dir::tmpdir
rssdir = ENV["TM_BUNDLE_SUPPORT"] + "/lib"
scratchdir += "/" if scratchdir[-1] != "/"
auxpath = rssdir + "/PubSubAgent/"

currentext = ENV["TM_FILEPATH"] ? File.extname(ENV["TM_FILEPATH"]).gsub('.','') : "tmp"
files = Dir.glob("#{scratchdir}textmate_scratch_*")
header = File.open("#{rssdir}/rss_header.html").read

usedext = []
filters = ""
files.each { |f| usedext << File.extname(f).gsub('.','') }
usedext.uniq!
filter = File.open("#{rssdir}/rss_filter.html").read
filtercnt = 2
usedext.sort.each do |filterext|
  filters += eval('"' + filter + '"')
  filtercnt += 1
end

puts header.gsub('#{filters}', filters).gsub('#{auxpath}', auxpath).gsub('#{files.length}', files.length.to_s).gsub('#{currentext}', currentext)

entry = File.open("#{rssdir}/rss_entry.html").read

cnt = files.length

files.reverse.each do |path|
  author = File.extname(path).gsub('.','')
  date = File.mtime(path).strftime("%a %b %d %Y, %H:%M:%S")
  url = e_url path
  id = path
  articlesortdate = Time.now.to_f
  articlelocaldate = date.to_f
  articlesorttitle = author
  articlesortid = cnt
  summary = File.open(path).readline.gsub("&","&amp;").gsub(">","&gt;").gsub("<","&lt;")
  puts eval('"' + entry + '"')
  File.readlines(path).each do |line|
    puts line.gsub("&","&amp;").gsub(">","&gt;").gsub("<","&lt;")
  end
  content = File.open(path).read.gsub('"','\"').gsub(/\n/,'\\n')
  puts "</code></pre>"
  puts "</div></div></div>"
  cnt -= 1
end
File.open("#{rssdir}/rss_footer.html").each { |l| puts l }
