#!/usr/bin/env ruby -rjcode -Ku

$: << ENV['TM_SUPPORT_PATH'] + '/lib'

require 'cgi'
require 'zlib'
require 'progress'
require "textmate"
require "plist"
require 'fileutils'
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/doctohtml.rb"

def find_language_ext
	bundle_dirs = [
		File.expand_path('~/Library/Application Support/TextMate/Bundles'),
		'/Library/Application Support/TextMate/Bundles',
		TextMate.app_path + '/Contents/SharedSupport/Bundles'
	]

  if scope = ENV['TM_SCOPE'] then
    scope = scope.split(' ').first
    bundle_dirs.each do |dir|
      Dir.glob(dir + '/*.tmbundle/Syntaxes/*.{plist,tmLanguage}') do |filename|
        File.open(filename) do |io|
          plist = PropertyList.load(io)
          if scope == plist['scopeName'].to_s then
            return Array(plist['fileTypes']).first || 'txt'
          end
        end
      end
    end
  end

  ext = File.extname(ENV['TM_FILENAME'].to_s).sub(/\A\./, '')
  ext.empty? ? 'txt' : ext
end

TextMate.call_with_progress(:title => "Paste to Pastie", :message => "Contacting Server “pastie.caboo.se”…") do
  text_file, html_file = `/usr/bin/mktemp -t tm_paste && /usr/bin/mktemp -t tm_paste`.split("\n")

  xml = STDIN.read

  open(text_file, 'w') do |io|
    io.write CGI::unescapeHTML(xml.gsub(/<[^>]*>/, ''))
  end

  Zlib::GzipWriter.open(html_file) do |gz|
    gz.write document_to_html(xml)
  end

  author = "#{`niutil -readprop / "/users/$USER" realname`.chomp} (#{ENV['USER']})"
  ext = find_language_ext

  url = ENV['TM_PASTIE_URL'] || 'http://pastie.caboo.se/pastes/create'
  print %x{
    curl #{url} \
    	-s -L -o /dev/null -w "%{url_effective}" \
    	-H "Expect:" \
    	-F "paste[parser]=plaintext" \
    	-F "paste[display_name]=#{author}" \
    	-F "paste[file_extension]=#{ext}" \
    	-F "paste[body]=<#{text_file}" \
    	-F "paste[textmate_html_gz]=<#{html_file}"
  }

  File.unlink(text_file)
  File.unlink(html_file)
end
