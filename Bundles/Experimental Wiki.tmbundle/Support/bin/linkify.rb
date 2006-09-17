#!/usr/bin/env ruby -w

require "pathname"
require "fileutils"

markdown = "#{ENV['HOME']}/Library/Application Support/TextMate/Support/bin/Markdown.pl"

def e_url(str)
  str.gsub(/([^a-zA-Z0-9\/_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end
end

def e_sh(str)
  str.to_s.gsub(/(?=[^a-zA-Z0-9_.\/\-\x7F-\xFF])/, '\\')
end

def e_sh_js(str)
  (e_sh str).gsub("\\", "\\\\\\\\")
end

script = Pathname.new($0).realpath.to_s

file = ARGV.shift || "/Users/duff/Source/TextMate/manual/pages/010_preface.markdown"
path = Pathname.new(file).realpath
dir = path.parent.to_s

tmp = '/tmp/tm_wiki'
FileUtils.mkdir tmp unless File.exists? tmp
dst_name = tmp + '/' + path.basename.to_s.sub(/\..+\z/, '') + '.html'

open("|#{e_sh markdown} > #{e_sh dst_name}", "w") do |io|
  io << DATA.read

  line_no = 1
  open(file) do |src|
    src.each_line do |line|
      if line =~ /^#+.*/
        line = line + " <small>(<a href='txmt://open?line=#{line_no + 1}&url=file://#{e_url path.to_s}'>edit</a>)</small>"
      end

      line = line.gsub(/\[([^\]]+)\]\[\]/) do |m|
        dest = "#{dir}/#{$1}.mdown"
        if File.exists? dest
          "<a href='#' onClick='visit(\"#{e_sh_js script}\", \"#{e_sh_js dest}\"); return false;'>#{$1}</a>"
        else
          "#{$1} (<a href='txmt://open?url=file://#{e_url dest}'>create</a>)"
        end
      end

      line_no = line_no + 1

      io << line
    end
  end
end

print dst_name

__END__
<script type="text/javascript">
  function visit (script, page) {
    var link = TextMate.system(script + " " + page, null).outputString;
    window.location="tm-file://" + link;
  }
</script>

