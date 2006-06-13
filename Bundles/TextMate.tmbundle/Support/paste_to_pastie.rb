#!/usr/bin/env ruby -rjcode -Ku

require 'cgi'
require 'progress'
require 'fileutils'
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/doctohtml.rb"

TextMate.call_with_progress(:title => "Paste to Pastie", :message => "Contacting Server “pastie.caboo.se”…") do
  text_file, html_file = `mktemp -t tm_paste && mktemp -t tm_paste`.split("\n")

  xml = STDIN.read

  text = CGI::unescapeHTML(xml.gsub(/<[^>]+>/, ''))
  open(text_file, "w") { |io| io.write(text); }

  html = document_to_html(xml)
  open(html_file, "w") { |io| io.write(html); }

  ext = File.extname(ENV['TM_FILENAME'].to_s).sub(/\A\./, '')

  print %x{
    curl http://pastie.caboo.se/pastes/create \
    	-s -L -o /dev/null -w "%{url_effective}" \
    	-H "Expect:" \
    	-F "paste[parser]=plaintext" \
    	-F "paste[file_extension]=#{ext}" \
    	-F "paste[body]=<#{text_file}" \
    	-F "paste[textmate_html]=<#{html_file}"
  }

  File.unlink(text_file)
  File.unlink(html_file)
end
