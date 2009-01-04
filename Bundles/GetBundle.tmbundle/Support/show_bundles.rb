#!/usr/bin/env ruby -wKU
# encoding: utf-8

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/escape.rb'
require SUPPORT + '/lib/osx/plist'
require 'rexml/document'
require 'erb'

include ERB::Util

DIALOG = e_sh ENV['DIALOG'];
NIB = 'Bundles'

def strip_html(text)
  text.gsub(/<[^>]+>/, '')
end

params = {
  'isBusy'                  => true,
  'progressText'            => 'Fetching List…',
  'progressMinValue'        => 0,
  'progressIsIndeterminate' => true,
  'bundles'                 => [ ]
}

token = %x{#{DIALOG} -a #{e_sh NIB} -p #{e_sh params.to_plist}}

x = Thread.new do

  bundles = [ ]
  open("|svn list --xml http://macromates.com/svn/Bundles/trunk/Bundles") do |io|

    doc = REXML::Document.new io
    doc.elements.to_a("//entry/name").each do |node|
      bundles << { 'name' => $1, 'path' => $& } if node.text =~ /^(.*)\.tmbundle$/
    end
    
    params['bundles']                 = bundles
    params['isBusy']                  = true
    params['progressText']            = "Fetching Descriptions (1 / #{bundles.size})…"
    params['progressValue']           = 0
    params['progressMinValue']        = 0
    params['progressMaxValue']        = bundles.size
    params['progressIsIndeterminate'] = false

    open("|#{DIALOG} -t#{token}", "w") { |dialog| dialog.write params.to_plist }
    params['isBusy']                  = true

    bundles.each do |bundle|
      puts "Load #{bundle['path']}…"
      plist = open("|svn cat http://macromates.com/svn/Bundles/trunk/Bundles/#{url_encode bundle['path']}/info.plist") do |svn|
				OSX::PropertyList.load(svn) 
			end
      # puts "Got #{plist}"
      bundle['uuid'] = plist['uuid'] unless plist['uuid'].nil?
      bundle['name'] = plist['name'] unless plist['name'].nil?
      bundle['bundleDescription'] = strip_html plist['description'].to_s
      params['progressValue'] += 1
      params['progressText'] = "Fetching Descriptions (#{params['progressValue'] + 1} / #{bundles.size})…"
      open("|#{DIALOG} -t#{token}", "w") { |dialog| dialog.write params.to_plist }
    end

  end

end

res = %x{#{DIALOG} -w#{token}}
open("/dev/console", "w") { |io| io.write res }
%x{#{DIALOG} -x#{token}}

x.kill; x.join
