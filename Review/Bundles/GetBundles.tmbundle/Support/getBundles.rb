#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/escape.rb'
require SUPPORT + '/lib/osx/plist'
require SUPPORT + '/lib/textmate.rb'
require 'erb'
require "fileutils"
require "open-uri"
require "yaml"
require 'net/http'
require 'uri'
require 'cgi'
require "open3"

include ERB::Util

$DIALOG           = e_sh ENV['DIALOG']
$NIB              = `uname -r`.split('.')[0].to_i > 8 ? 'BundlesTree' : 'BundlesTreeTiger'
$isDIALOG2        = false # ! $DIALOG.match(/2$/).nil?
# cache file for short svn descriptions
$chplistPath      = File.dirname(__FILE__) + "/lib/cachedDescriptions.plist"
# internal used cache for svn descriptions
$chplist          = { }
# the log file
$logFile          = "#{e_sh ENV['HOME']}/Library/Logs/TextMateGetBundles.log"
# DIALOG's parameters hash
$params           = { }
# DIALOG's async token
$token            = nil
$infoToken        = nil
# result hash of the the DIALOG
$dialogResult     = { }
# table of all bundles with repo, name, bundleDescription, path
$dataarray        = [ ]
# thread array for downloading svn descriptions
$threads          = [ ]
# default bundleDescription if no description is available
$notDownloadedStr = "…not yet downloaded…"
# set to true if Cancel button was pressed to interrput threads and each loops
$close            = false
# set to true for fetching something from the net (used for shut down procedure)
$listsLoaded      = false
# total number of found bundles
$numberOfBundles  = 0
# total number of bundles without downloaded description
$numberOfNoDesc   = 0
# main run loop variable
$run              = true
# time stamp for renaming existing folders
$ts               = ""
# does the installation folder exist
$installFolderExists = false
# error counter
$errorcnt         = 0
# temp dir for installation
$tempDir          = "/tmp/TM_GetBundlesTEMP"
# global timeout in seconds
$timeout          = 30
# global thread vars
$x0=$x1=$x2=$x3=$x4 = nil

CAPITALIZATION_EXCEPTIONS = %w[tmbundle on as iphone]

# keywords used in GitHub's search API to find as much as possible tmbundles
$gitKeywords      = ["bundle","tmbundle","textmate"]
# if at least one of these stop words occurs in the description do not show up it
$stopGitKeywords  = ["my own","my personal","personal bundle","obsolete","deprecated","work in progress"]

module GBTimeout
  class Error<Interrupt
  end
  def timeout(sec, exception=Error)
    return yield if sec == nil or sec.zero?
    raise ThreadError, "timeout within critical session" if Thread.critical
    begin
      x = Thread.current
      y = Thread.start {
        s = Time.now.to_i
        while Time.now.to_i - s < sec and ! $close do sleep 0.5 end
        writeToLogFile("Current task was interrupted by the user") if $close
        x.raise exception, "execution expired" if x.alive?
      }
      yield sec
    ensure
      y.kill if y and y.alive?
    end
  end
  module_function :timeout
end

def remote_bundle_locations
  [ {:display => :'Macromates Bundles', :scm => :svn, :name => 'B',
      :url => 'http://macromates.com/svn/Bundles/trunk/Bundles/'},
    {:display => :'Macromates Review', :scm => :svn, :name => 'R',
      :url => 'http://macromates.com/svn/Bundles/trunk/Review/Bundles/'},
    {:display => :'GitHub', :scm => :git, :name => 'G',
      :url => 'http://github.com/api/v1/yaml/search/'} ]
end

def targetPaths
  {
    'Users Lib Pristine'  => "#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",
    'Users Lib Bundles'   => "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
    'Lib Bundles'         => "/Library/Application Support/TextMate/Bundles",
    'App Bundles'         => "",
    'Users Desktop'       => "#{ENV["HOME"]}/Desktop",
    'Users Downloads'     => "#{ENV["HOME"]}/Downloads",
  }
end

def getInstallPathFor(abbr, copyToParams = true)
  # update params
  $params['targetSelection'] = abbr if copyToParams
  updateDIALOG
  if targetPaths.has_key?(abbr)
    if abbr == 'App Bundles'
      begin
        path = TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles"
      rescue
        $errorcnt += 1
        writeToLogFile("No path to TextMate found!")
        return ""
      end
      return path
    end
    return targetPaths[abbr]
  else
    return "#{ENV["HOME"]}/Desktop"
    # return %x{osascript -e 'tell application "TextMate"' -e 'activate' -e 'POSIX path of (choose folder with prompt "as installation target")' -e 'end tell' 2>/dev/null}.strip().gsub(/\/$/,'')
  end
end

def normalize_github_repo_name(name)
  # Convert a GitHub repo name into a "normal" TM bundle name
  # e.g. ruby-on-rails-tmbundle => Ruby on Rails.tmbundle
  # and delete all variants like "textmate bundle", "tm bundle", or "bundle"
  name = name.gsub(/\btextmate\b/i,"").gsub(/\bbundle\b/,"").gsub(/\btm\b/,"").gsub(/-+/,"-").gsub("-", " ").split.each{|part|
    part.capitalize! unless CAPITALIZATION_EXCEPTIONS.include? part}.join(" ")
  name[-9] = ?. if name =~ / tmbundle$/
  name.gsub("iphone","iPhone") # ;)
end

def strip_html(text)
  text.gsub(/<[^>]+>/, '')
end

def initSVNDescriptionCache
  # get cached svn descriptions; if this fails an empty cached plist will be used
  begin     # try to load cache
    $chplist = OSX::PropertyList::load(File.read($chplistPath))
  rescue    # if that fails use an empty plist instead
    remote_bundle_locations.each {|r| $chplist[r[:name]] = {} if r[:scm] == :svn }
  end
end

def writeSVNDescriptionCacheToDisk
  open($chplistPath, "w") { |io| io.write $chplist.to_plist }
end

def orderOutDIALOG
  $params['nocancel'] = true
    if $isDIALOG2
    $token = %x{#{$DIALOG} window create -p #{e_sh $params.to_plist} #{e_sh $NIB} }
  else
    $token = %x{#{$DIALOG} -a #{e_sh $NIB} -p #{e_sh $params.to_plist}}
  end
  writeToLogFile("Get Bundles DIALOG runs at token #{$token}")
  $params['nocancel'] = false
  updateDIALOG
end

def closeDIALOG
  list = ""
  if $isDIALOG2
    %x{#{$DIALOG} window close #{$token}}
    list = %x{#{$DIALOG} window list | egrep 'GetBundles'}
    list.each_line do |l|
      t = l.split(' ').first
      %x{#{$DIALOG} window close #{t}}
    end
  else
    %x{#{$DIALOG} -x#{$token}}
    list = %x{#{$DIALOG} -l | egrep 'GetBundles'}
    list.each_line do |l|
      t = l.split(' ').first
      %x{#{$DIALOG} -x#{t}}
    end
  end
  %x{rm -rf #{$tempDir} 1> /dev/null}
  # go back to the front most doc if TM is running
  # %x{open 'txmt://open?'} if ! getInstallPathFor("App Bundles").empty?
end

def updateDIALOG
  if $isDIALOG2
    %x{#{$DIALOG} window update #{$token} -p #{e_sh $params.to_plist}}
  else
    open("|#{$DIALOG} -t#{$token}", "w") { |io| io.write $params.to_plist }
  end
end

def helpDIALOG
  err = %x{open "txmt://open?"; osascript -e 'tell application "TextMate" to activate' -e 'tell application "System Events" to tell process "TextMate" to tell menu bar 1 to tell menu bar item "Bundles" to tell menu "Bundles" to tell menu item "GetBundles" to tell menu "GetBundles" to click menu item "Help"' 2>&1}
  writeToLogFile(err) if err.match(/error/)
end

def infoDIALOG(dlg)
  return if ! dlg.has_key?('path')
  info = plist = { }
  readme = css = data = ""
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  path = dlg['path'].split('|').last
  mode = dlg['path'].split('|').first
  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = "Fetching information…"
  updateDIALOG
  return if $close
  if mode == 'git'
    namehasdot = false
    searchPath = path.gsub(/.*?com\/(.*?)\/(.*?)\/.*/, '\1-\2')
    url = path.gsub(/zipball\/master/, '')
    if ! url.match(/.*?com\/(.*?)\/(.*?)\..*/)
      begin
        GBTimeout::timeout($timeout) do
          d = YAML.load(open("http://github.com/api/v1/yaml/search/#{searchPath}"))
          if d.has_key?('repositories') and d['repositories'].size > 0
            info = d['repositories'].first
          else
            # if .../search/foo-bar-foo1 fails try .../search/foo+bar+foo1
            d = YAML.load(open("http://github.com/api/v1/yaml/search/#{searchPath.gsub('-','+')}"))
            if d.has_key?('repositories') and d['repositories'].size > 0
              info = d['repositories'].first
            # if .../search/foo+bar+foo1 fails init an empty dict
            else
              info = {}
            end
          end
        end
      rescue GBTimeout::Error
        $params['isBusy'] = false
        updateDIALOG
        %x{rm -rf #{$tempDir}}
        writeToLogFile("Timeout error while fetching information") if ! $close
        return
      end
    else
      namehasdot = true
      info = {}
      info['name'] = ""
      info['description'] = ""
      info['owner'] = url.gsub(/.*?com\/(.*?)\/.*\//,'\1')
    end
    return if $close
    begin
      GBTimeout::timeout($timeout) do
        data = Net::HTTP.get( URI.parse("#{url}tree/master") )
      end
    rescue GBTimeout::Error
      $params['isBusy'] = false
      updateDIALOG
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while fetching information") if ! $close
      return
    end
    return if $close
    begin
      GBTimeout::timeout($timeout) do
        begin
          plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{url}tree/master/info.plist?raw=true")).gsub(/.*?(<plist.*?<\/plist>)/m,'\1'))
        rescue
          writeToLogFile($!)
        end
      end
    rescue GBTimeout::Error
      $params['isBusy'] = false
      updateDIALOG
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while fetching information") if ! $close
      return
    end
    return if $close
    plist['name'] = info['path'] if plist['name'].nil?
    plist['description'] = "" if plist['description'].nil?
    plist['contactName'] = "" if plist['contactName'].nil?
    plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?
    if ! data.index('<div id="readme">').nil?
      readme = data.gsub( /.*?(<div id="readme">.*?)<div class="push">.*/m, '\1').gsub(/<span class="name">README.*?<\/span>/, '')
    else
      readme = "<br /><i>No README found</i><br />"
    end
    css = data.gsub( /.*?(<link href="\/stylesheets\/.*?\/>).*/m, '\1')
    data = ""
    return if $close
    gitbugreport = (namehasdot) ? "&nbsp;&nbsp;&nbsp;<i><small>incomplete caused by the dot in project name (known GitHub bug)</small></i><br>" : ""
    File.open("#{$tempDir}/info.html", "w") do |io|
      io << <<-HTML01
        <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
        <base href='http://github.com'>
        <head>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
        #{css}
        </head>
        <body><div id='main'><div class='site'>
        <font color='blue' size=12pt>#{plist['name']}</font><br /><br />
        <h3><u>git Information:</u></h3>#{gitbugreport}
        <b>Description:</b><br />&nbsp;#{info['description']}<br />
        <b>Name:</b><br />&nbsp;#{plist['name']}<br />
        <b>URL:</b><br />&nbsp;<a href='#{url}'>#{url}</a><br />
        <b>Owner:</b><br />&nbsp;<a href='http://github.com/#{info['owner']}'>#{info['owner']}</a><br />
        <b>Watchers:</b><br />&nbsp;#{info['watchers']}<br />
        <b>Private:</b><br />&nbsp;#{info['private']}<br />
        <b>Forks:</b><br />&nbsp;#{info['forks']}<br />
      HTML01
      if ! plist['contactName'].empty? or ! plist['contactEmailRot13'].empty? or ! plist['description'].empty?
        io << <<-HTML02
        <br /><br />
        <h3><u>Bundle Information (info.plist):</u></h3>
        #{plist['description']}<br /><br />
        <b>Contact Name:</b><br />&nbsp;<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a><br />
        HTML02
      end
      io << <<-HTML03
        <br /><br />
        <h2><u>README:</u></h2><br />
        #{readme}</div></div>
        </body></html>
      HTML03
    end
  elsif mode == 'svn'
    if $SVN.length > 0
      begin
        GBTimeout::timeout($timeout) do
          data = executeShell("export LC_CTYPE=en_US.UTF-8;'#{$SVN}' info '#{path}'")
          if $errorcnt > 0
            %x{rm -r #{$tempDir}}
            $params['isBusy'] = false
            updateDIALOG
            return
          end
        end
      rescue GBTimeout::Error
        $params['isBusy'] = false
        updateDIALOG
        %x{rm -rf #{$tempDir}}
        writeToLogFile("Timeout error while fetching information") if ! $close
        return
      end
      return if $close
      data.each_line do |l|
        info[l.split(': ').first] = l.split(': ').last
      end
      begin
        GBTimeout::timeout($timeout) do
          begin
            plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{path}/info.plist")))
          rescue
            begin
              plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse(URI.escape("#{thePath}/info.plist"))))
            rescue
              plist = OSX::PropertyList::load("{description='?';}")
            end
          end
        end
      rescue GBTimeout::Error
        $params['isBusy'] = false
        updateDIALOG
        %x{rm -rf #{$tempDir}}
        writeToLogFile("Timeout error while fetching information") if ! $close
        return
      end
      return if $close
      plist['name'] = info['path'] if plist['name'].nil?
      plist['description'] = "" if plist['description'].nil?
      plist['contactName'] = "" if plist['contactName'].nil?
      plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?
      File.open("#{$tempDir}/info.html", "w") do |io|
        io << <<-HTML11
          <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
          <head>
          <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
          </head>
          <body style='font-family:Lucida Grande'>
        HTML11
        if plist['description'].match(/<hr[^>]*\/>/)
          io << "#{plist['description'].gsub(/.*?<hr[^>]*\/>/,'')}<br /><br />"
        else
          io << "<font color='blue' size=12pt>#{plist['name']}</font><br /><br />"
          io << "#{plist['description']}<br /><br />"
        end
        io << <<-HTML12
          <b>URL:</b><br />&nbsp;<a href='#{info['URL']}'>#{info['URL']}</a><br />
          <b>Contact Name:</b><br />&nbsp;<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a><br />
          <b>Revision:</b><br />&nbsp;#{info['Revision']}<br />
          <b>Last Changed Date:</b><br />&nbsp;#{info['Last Changed Date']}<br />
          <b>Last Changed Author:</b><br />&nbsp;#{info['Last Changed Author']}<br />
          <b>Last Changed Rev:</b><br />&nbsp;#{info['Last Changed Rev']}<br />
          </body></html>
        HTML12
      end
    else          #### no svn client found
      noSVNclientFound
    end
  else
    return
  end
  $params['isBusy'] = false
  updateDIALOG
  $infoTokenOld = $infoToken
  if $close
    %x{rm -rf #{$tempDir} 1> /dev/null}
    return
  end
  if $isDIALOG2
    $infoToken = %x{#{$DIALOG} window create -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}" help }
  else
    $infoToken = %x{#{$DIALOG} -a help -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"}
  end
  if ! $infoTokenOld.nil?
    if $isDIALOG2
      %x{#{$DIALOG} window close #{$infoTokenOld}}
    else
      %x{#{$DIALOG} -x#{$infoTokenOld}}
    end
  end
  %x{rm -rf #{$tempDir} 1> /dev/null}
end

def noSVNclientFound
  writeToLogFile("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
  $params['progressText'] = 'No svn client found! Please check the Activity Log.'
  updateDIALOG
  sleep(3)
end

def askDIALOG(msg, text)
  msg.gsub!("'","’")
  text.gsub!("'","’")
  resStr = 0
  if $isDIALOG2
    resStr = %x{"$DIALOG" alert -s critical -m "#{msg}" -t "#{text}" -1 No -2 Yes}
  else
    resStr = %x{"$DIALOG" -e -p '{messageTitle="#{msg}";alertStyle=critical;informativeText="#{text}";buttonTitles=("No","Yes");}'}
    return resStr.to_i
  end
  begin
    plist = OSX::PropertyList.load(resStr)
    resStr = plist['buttonClicked']
  rescue
  end
  return resStr
end

def getResultFromDIALOG
  resStr = ""
  if $isDIALOG2
    resStr = %x{#{$DIALOG} window wait #{$token}}
  else
    resStr = %x{#{$DIALOG} -w#{$token}}
  end
  $close = false
  begin
    $dialogResult = OSX::PropertyList.load(resStr)
  rescue
  end
end

def getBundleLists
  $params['dataarray'] = [ ]
  updateDIALOG
  begin
    $listsLoaded = false
    $dataarray  = [ ]
    remote_bundle_locations.each do |r|
      break if $close
      $params = {
        'isBusy'                  => true,
        'bundleSelection'         => 'All',
        'progressText'            => 'Fetching List for %s…' % r[:display].to_s,
        'progressIsIndeterminate' => true,
        'progressValue'           => 0,
      }
      updateDIALOG
      # $params['progressText'] = 'Fetching List for %s…' % r[:display].to_s
      # updateDIALOG
      bundlearray = [ ]
      if r[:scm] == :svn
        list = [ ]
        begin
          GBTimeout::timeout($timeout) do
            list = Net::HTTP.get( URI.parse(r[:url]) ).gsub( /<[^>]+?>/, '').gsub( /(?m)^.*?\.\.\n/, '').gsub( /(?m)\/[^\/]*$/, '').strip().split(/\n/)
          end
        rescue GBTimeout::Error
          writeToLogFile("Timeout for fetching %s list" % r[:display].to_s) if ! $close
          $params['progressText'] = 'Timeout'
          $params['isBusy'] = false
          updateDIALOG
        end
        list.collect! {|x| CGI::unescapeHTML(x.strip())}
        list.each do |io|
          break if $close
          theName = io.gsub(/^(.*)\.tmbundle$/,'\1')
          theDescription = ""
          # do we have the description in the cache
          if $chplist[r[:name]][theName].nil?
            theDescription = $notDownloadedStr
            $numberOfNoDesc += 1
          else
            theDescription = $chplist[r[:name].to_s][theName]
          end
          $dataarray << {
            'name' => theName,
            'path' => r[:scm].to_s + "|" + URI.escape(r[:url] + io),
            'bundleDescription' => theDescription,
            'searchpattern' => theName.downcase+" "+theDescription.downcase,
            'repo' => r[:name].to_s
          }
        end
      elsif r[:scm] == :git
        list = [ ]
        gitThreads = [ ]
        t_counter = 0
        # collect all bundles for gitKeywords in separate threads
        $gitKeywords.each do |keyword|
          gitThreads[t_counter] = Thread.new do
            begin
              GBTimeout::timeout($timeout) do
                page=1
                while true
                  found = YAML.load(open("http://github.com/api/v1/yaml/search/#{keyword}?page=#{page}"))['repositories']
                  break if found.empty?
                  page += 1
                  list << found
                end
              end
            rescue GBTimeout::Error
              writeToLogFile("Timeout while fetching GitHub list for %s" % keyword) if ! $close
              t_error = true
            end
          end
          t_counter += 1
        end
        begin
          GBTimeout::timeout($timeout) do
            gitThreads.each {|t| t.join}
          end
        rescue GBTimeout::Error
          gitThreads.each {|t| t.kill}
          writeToLogFile("Timeout while fetching GitHub lists") if ! $close
          t_error = true
        end
        if t_error and ! $close
          $params['progressText'] = 'Error while fetching GitHub lists. Please check the Activity Log'
          updateDIALOG
          sleep(2)
        end
        # hash to make git bundles unique by using their urls
        $seen = []
        list.flatten!
        list.find_all{|result| result['name'].match(/(tmbundle|textmate.bundle|tm.bundle)$/)}.sort{|a,b| a['name'] <=> b['name']}.each do |result|
          break if $close
          if not $seen.include?result['url']
            if result['description'].nil? or not result['description'].match(/\b(#{$stopGitKeywords.join('|')})\b/i)
              $seen << result['url']
              theName = normalize_github_repo_name(result['name']).split('.').first
              theDescription = ""
              if result.has_key?('description')
                theDescription = strip_html(result['description'])
              end
              theDescription += " (by %s)" % result['owner']
              thePath = r[:scm].to_s + "|" + URI.escape(result['url'] + "/zipball/master") unless result['url'].nil?
              $dataarray << {
                'name' => theName,
                'path' => thePath,
                'bundleDescription' => theDescription,
                'searchpattern' => theName.downcase+" "+theDescription.downcase,
                'repo' => r[:name].to_s
              }
            end
          end
        end
      else
      end
      if ! $close
        $numberOfBundles = $dataarray.size
        $params['numberOfBundles'] = "%d in total found" % $numberOfBundles
        if $numberOfNoDesc > 0
          $params['updateBtnLabel'] = 'Update (%d missing)' % $numberOfNoDesc
        end
        $dataarray.sort!{|a,b| a['name'] <=> b['name']}
        $params['dataarray'] = $dataarray
        updateDIALOG
      end
    end
    if $numberOfNoDesc > 0
      $params['progressText'] = 'Please update the descriptions (%d missing)' % $numberOfNoDesc
      updateDIALOG
      sleep(3)
    end
    $params['isBusy'] = false
    $params['rescanBundleList'] = 0
    updateDIALOG
    $listsLoaded = true
  rescue
    $params['progressText'] = 'Unknown error occured!'
    $params['rescanBundleList'] = 0
    $params['isBusy'] = false
    updateDIALOG
  end
  if $dataarray.size == 0 and ! $close
    writeToLogFile("Probably no internet connection available")
    $params['isBusy'] = true
    $params['progressText'] = 'Probably no internet connection available'
    updateDIALOG
    sleep(3)
    $params['isBusy'] = false
    $params['rescanBundleList'] = 0
    updateDIALOG
  end    
  # suppress the updating of the table to preserve the selection
  $params.delete('dataarray')
end

def getSVNBundleDescriptions
  $listsLoaded = false
  $threads.each {|t| t.kill}
  remote_bundle_locations.each do |r|
    # update only svn stuff
    if r[:scm] == :svn && ! $close
      bundles = $dataarray.select {|v| v['repo'] == r[:name]}
      $params = {
        'isBusy'                  => true,
        'progressText'            => 'Updating Descriptions for %s…' % r[:display],
        'progressIsIndeterminate' => true,
        'progressValue'           => 0,
        'progressMinValue'        => 0,
        'progressMaxValue'        => bundles.size,
      }
      updateDIALOG
      # how many thread groups to download the descriptions
      grp = 6
      offset = (bundles.size/grp).to_i + 1
      offset.times do |i|
        break if $close
        $threads[i] = Thread.new do
          itemStart = i*grp
          itemEnd   = i*grp+grp-1
          if itemEnd >= bundles.size
            itemEnd = bundles.size - 1
          end
          bundles[itemStart..itemEnd].each do |bundle|
            break if $close
            thePath = bundle['path'].split("|").last
            begin
              plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{thePath}/info.plist")))
            rescue
              begin
                plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse(URI.escape("#{thePath}/info.plist"))))
              rescue
                plist = OSX::PropertyList::load("{description='?';}")
              end
            end
            # sometimes the svn name differs from the actual bundle name (only for caching)
            myBundleName = bundle['name']
            bundle['uuid'] = plist['uuid'] unless plist['uuid'].nil?
            bundle['name'] = plist['name'] unless plist['name'].nil?
            bundle['bundleDescription'] = strip_html plist['description'].to_s.gsub(/(?m)<hr[^>]*?\/>.*/,'').gsub(/\n/, ' ')
            # update the cache only if something is found
            $chplist[r[:name]][myBundleName] = bundle['bundleDescription'] if bundle['bundleDescription'] != '?'
            $params['progressText'] = "Updating Descriptions for %s (#{$params['progressValue'] + 1} / #{bundles.size})…" % r[:display]
            $params['progressValue'] += 1
          end
          if ! $close
            $params['dataarray'] = $dataarray
            $params['bundleSelection'] = 'All'
            $params['progressIsIndeterminate'] = false
            updateDIALOG
            writeSVNDescriptionCacheToDisk
          end
        end
      end
      # wait for threads before downloading the descriptions for the next trunk
      $threads.each {|t| t.join}
      $threads.each {|t| t.kill}
    end
  end
  $params['dataarray'] = $dataarray
  $params['isBusy'] = false
  # $params['numberOfNoDesc'] = " "
  $params['updateBtnLabel'] = "Update Descriptions"
  $params['doUpdate'] = 0
  updateDIALOG
  $listsLoaded = true
  # suppress the updating of the table to preserve the selection
  $params.delete('dataarray')
end

def joinThreads
  begin
    $x1.join
    $x1.kill
  rescue
  end
  begin
    $x0.join
    $x0.kill
  rescue
  end
  begin
    $x2.join
    $x2.kill
  rescue
  end
  begin
    $x3.join
    $x3.kill
  rescue
  end
  begin
    $x4.join
    $x4.kill
  rescue
  end
end

def killThreads
  begin
    $x1.kill
  rescue
  end
  begin
    $x0.kill
  rescue
  end
  begin
    $x2.kill
  rescue
  end
  begin
    $x3.kill
  rescue
  end
  begin
    $x4.kill
  rescue
  end
end

def initLogFile
  f = File.open($logFile, "w")
  f.close
end

def writeToLogFile(text)
  f = File.open($logFile, "a")
  f.puts Time.now.strftime("\n%m/%d/%Y %H:%M:%S") + "\tTextMate[GetBundles]"
  f.puts text
  f.flush
  f.close
  $params['logPath'] = %x{cat '#{$logFile}'}
  updateDIALOG
end

def resetOldBundleFolder(aFolder)
  executeShell("cp -R '#{aFolder}' '#{aFolder}TEMP' 1> /dev/null")
  executeShell("rm -rf '#{aFolder}' 1> /dev/null")
  executeShell("cp -R '#{aFolder}#{$ts}' '#{aFolder}' 1> /dev/null")
  executeShell("rm -rf '#{aFolder}TEMP' 1> /dev/null")
  executeShell("rm -rf '#{aFolder}#{$ts}' 1> /dev/null")
  if $errorcnt > 0
    writeToLogFile("Error while resetting “#{aFolder}#{$ts}” to “#{aFolder}”")
  else
    writeToLogFile("Reset: Renaming of “#{aFolder}#{$ts}” into “#{aFolder}”")
  end
end

def renameOldBundleFolder(aFolder)
  $installFolderExists = true
  # rename old folder by appending a time stamp
  $ts = Time.now.strftime("%m%d%Y%H%M%S")
  writeToLogFile("Renaming of “#{aFolder}” into “#{aFolder}#{$ts}”")
  executeShell("cp -R '#{aFolder}' '#{aFolder}#{$ts}' 1> /dev/null")
  executeShell("rm -r '#{aFolder}' 1> /dev/null")
  if $errorcnt > 0
    writeToLogFile("Cannot rename “#{aFolder}” into “#{aFolder}#{$ts}”")
  end
end

def executeShell(cmd, cmdToLog = false, outToLog = false)
  writeToLogFile(cmd) if cmdToLog
  out = ""
  err = ""
  Open3.popen3(cmd) { |stdin, stdout, stderr|
    out << stdout.read
    err << stderr.read
  }
  writeToLogFile(out) if (! out.empty? and outToLog)
  if ! err.empty?
    $errorcnt += 1
    writeToLogFile(err)
    return
  end
  return out
end

def installGitZipball(path, installPath)
  errors = ""
  download_file = "#{$tempDir}/github.tmbundle.zip"
  # the name of the bundle
  name = normalize_github_repo_name( 
    path.gsub(/.*github.com\/.*?\/(.*?)\/.*/,'\1') ).split('.').first + ".tmbundle"
  # the name of the zipball without zip id
  idname = path.gsub(/.*github.com\/(.*?)\/(.*?)\/zipball.*/,'\1-\2')
  writeToLogFile("Install:\t%s\ninto:\t%s/%s\nusing:\tunzip\ntemp folder:\t%s" \
    % [path, installPath, name, $tempDir])
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  begin
    GBTimeout::timeout($timeout) do
      begin
        File.open(download_file, 'w') { |f| f.write(open(path).read)}
      rescue
        $errorcnt += 1
        writeToLogFile("No access to “#{path}”")
        return
      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    %x{rm -rf #{$tempDir}}
    writeToLogFile("Timeout error while installing %s" % name) if ! $close
    return
  end
  return if $close
  if $errorcnt == 0
    # try to unzip the zipball
    executeShell("unzip '#{download_file}' -d '#{$tempDir}' 1> /dev/null")
    if $errorcnt > 0
      %x{rm -rf #{$tempDir}}
      return
    end
    return if $close
    # get the zip id from the downloaded zipball
    id = executeShell("unzip -z '#{download_file}' | head -n2 | tail -n1")
    if id.nil? or id.length == 0
      $errorcnt += 1
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Cannot get the zip id from “#{download_file}”!")
      return
    end
    idname += "-" + id.strip!
    FileUtils.rm(download_file)
    return if $close
    executeShell("cd '#{$tempDir}'; mv '#{idname}' '#{name}' 1> /dev/null")
    if $errorcnt > 0
      %x{rm -r #{$tempDir}}
      return
    end
    info = executeShell("cd '#{$tempDir}'; find . -name info.plist")
    if info.nil? or info.empty?
      writeToLogFile("The bundle #{name} does not contain the file 'info.plist'.")
      $errorcnt += 1
      return
    end
    renameOldBundleFolder("#{installPath}/#{name}") if $installFolderExists
    executeShell("cp -R '#{$tempDir}/#{name}' #{e_sh installPath}")
    if $errorcnt > 0
      %x{rm -r #{$tempDir}}
      writeToLogFile("Cannot copy “#{$tempDir}/#{name}” to “#{installPath}”")
      resetOldBundleFolder("#{installPath}/#{name}") if $installFolderExists
      return
    end
    %x{rm -r #{$tempDir}}
  end
end

def installGitClone(path, installPath)
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  if ENV.has_key?('TM_GIT')
    git = "'%s'" % ENV['TM_GIT']
  else
    git = "git"
  end
  thePath = path.sub('http', 'git').sub('/zipball/master', '.git')
  theName = normalize_github_repo_name(path.sub('/zipball/master', '').gsub(/.*\/(.*)/, '\1'))
  begin
    GBTimeout::timeout($timeout) do
      executeShell("#{git} clone #{e_sh thePath} '#{$tempDir}/#{theName}'", true, true)
      if $errorcnt > 0
        %x{rm -r #{$tempDir}}
        return
      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    %x{rm -rf #{$tempDir}}
    writeToLogFile("Timeout error while installing %s" % theName) if ! $close
    return
  end
  return if $close
  if $errorcnt == 0
    info = executeShell("cd '#{$tempDir}'; find . -name info.plist")
    if info.nil? or info.empty?
      writeToLogFile("The bundle #{theName} does not contain the file 'info.plist'.")
      $errorcnt += 1
      return
    end
    renameOldBundleFolder("#{installPath}/#{theName}") if $installFolderExists
    executeShell("cp -R '#{$tempDir}/#{theName}' '#{installPath}/#{theName}'")
    if $errorcnt > 0
      %x{rm -r #{$tempDir}}
      writeToLogFile("Cannot copy “#{$tempDir}/#{theName}” to “#{installPath}/#{theName}”")
      resetOldBundleFolder("#{installPath}/#{theName}") if $installFolderExists
      return
    end
  end
  %x{rm -r #{$tempDir}}
end

def installSVN(path, installPath)
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  name = path.gsub(/.*\/(.*)\.tmbundle.*/,'\1')
  if $SVN.length > 0
    begin
      GBTimeout::timeout($timeout) do
        executeShell("export LC_CTYPE=en_US.UTF-8;cd '#{$tempDir}';'#{$SVN}' co --no-auth-cache --non-interactive '#{path}'",true,true)
        if $errorcnt > 0
          %x{rm -r #{$tempDir}}
          return
        end
      end
    rescue GBTimeout::Error
      $errorcnt += 1
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while installing %s" % name) if ! $close
      return
    end
    # get the bundle's real name (esp. for spaces and other symbols)
    realname = executeShell("ls '#{$tempDir}' | head -n1").strip!
    if $errorcnt > 0
      %x{rm -r #{$tempDir}}
      return
    end
    return if $close
    if $errorcnt == 0
      info = executeShell("cd '#{$tempDir}'; find . -name info.plist")
      if info.nil? or info.empty?
        writeToLogFile("The bundle #{realname} does not contain the file 'info.plist'.")
        $errorcnt += 1
        return
      end
      renameOldBundleFolder("#{installPath}/#{realname}") if $installFolderExists
      executeShell("cp -R '#{$tempDir}/#{realname}' '#{installPath}/#{realname}'")
      if $errorcnt > 0
        %x{rm -r #{$tempDir}}
        writeToLogFile("Cannot copy “#{$tempDir}#{realname}” to “#{installPath}/#{realname}”")
        resetOldBundleFolder("#{installPath}/#{realname}") if $installFolderExists
        return
      end
    end
    %x{rm -r #{$tempDir}}
  else          #### no svn client found
    noSVNclientFound
  end
end

def installBundles(dlg)
  $listsLoaded = false
  cnt = 0 # counter for installed bundles
  # $params['nocancel'] = false # avoid pressing Cancel
  $params['usingGitZip'] = dlg['usingGitZip']
  updateDIALOG
  # $dialogResult['returnArgument'] helds the installation target 
  installPath = getInstallPathFor(dlg['returnArgument'])
  if installPath.length() > 0 and dlg.has_key?('paths') and ! $close
    FileUtils.mkdir_p installPath
    items = dlg['paths']
    items.each do |item|
      break if $close
      $errorcnt = 0
      $params['isBusy'] = true
      $params['progressIsIndeterminate'] = true
      $params['progressText'] = "Installing…"
      updateDIALOG
      cnt += 1
      path = item.split("|").last
      mode = item.split("|").first
      name = ""
      if mode == 'git'
        name = normalize_github_repo_name(path.gsub(/.*github.com\/.*?\/(.*?)\/.*/,'\1')).split('.').first
      elsif mode == 'svn'
        name = path.gsub(/.*\/(.*)\.tmbundle.*/,'\1')
      end
      name = URI.unescape(name)
      break if $close
      writeToLogFile("Install “%s” into %s" % [name, installPath])
      if File.directory?(installPath + "/#{name}.tmbundle")
        if askDIALOG("“#{name}” folder already exists.", "Do you want to replace it?\n➠If yes, the old folder will be renamed\nby appending a time stamp!") == 0
          mode = 'skip'
          writeToLogFile("Installation of “#{name}” was skipped")
        else
          $installFolderExists = true
        end
      else
        $installFolderExists = false
      end
      if mode != 'skip'
        $params['progressText'] = "Installing #{name}"
        $params['progressText'] += (items.size == 1) ? "…" : " (#{cnt} / #{items.size})…"
      end
      updateDIALOG
      # git := install via zipball, gitclone := install via 'git clone...'
      # dlg['usingGitZip'] could give 0 (DIALOG1) or false (DIALOG2)
      mode += $GITMODE if mode == 'git' and (dlg['usingGitZip'] == false or dlg['usingGitZip'] == 0)
      break if $close
      if mode == 'git'
        installGitZipball(path, installPath)
      elsif mode == 'gitclone'
        installGitClone(path, installPath)
      elsif mode == 'svn'
        installSVN(path, installPath)
      end
      break if $close
      if $errorcnt > 0
        $params['progressText'] = 'Error while installing! Please check the Activity Log.'
        updateDIALOG
        sleep(3)
        $errorcnt = 0
        break
      end
      writeToLogFile("Installation of “%s” done." % name) if mode != 'skip' and $errorcnt == 0
    end
    $params['progressText'] = "Reload Bundles…"
    updateDIALOG
    # reload bundles only if TM is running
    %x{osascript -e 'tell app "TextMate" to reload bundles'} if ! getInstallPathFor("App Bundles", false).empty?
    # if $errorcnt > 0
    #   $params['progressText'] = 'General error while installing! Please check the Activity Log.'
    #   updateDIALOG
    #   sleep(3)
    # end
    $params['isBusy'] = false
    $params['progressText'] = ""
    updateDIALOG
  end
  # $params['nocancel'] = false
  # updateDIALOG
  %x{rm -rf #{$tempDir} 1> /dev/null}
  $listsLoaded = true
end

def updateTMlibPath
  return if askDIALOG("Do you really want to update TextMate's Support folder?","") == 0
  path = "http://macromates.com/svn/Bundles/trunk/Support/"
  $params['isBusy'] = true
  $params['progressText'] = "Installing TextMate's Support folder…"
  updateDIALOG
  begin
    installPath = "/Library/Application Support/TextMate"
    %x{mkdir -p "#{installPath}"}
  rescue
    $errorcnt += 1
    writeToLogFile("No path to TextMate found!")
    return
  end
  if ! File.directory?(installPath)
    $errorcnt += 1
    writeToLogFile("#{installPath} not found!")
    return
  end
  if $SVN.length == 0
    $errorcnt += 1
    writeToLogFile("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
    $params['progressText'] = 'No svn client found! Please check the Activity Log.'
    updateDIALOG
    sleep(3)
    return
  end
  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = 'Installing Support folder'
  updateDIALOG
  # renameOldBundleFolder("#{installPath}")
  ts = Time.now.strftime("%m%d%Y%H%M%S")
  writeToLogFile("Backup of “#{installPath}” into “#{installPath}#{ts}”")
  executeShell("cp -R '#{installPath}' '#{installPath}#{ts}' 1> /dev/null")
  return if $errorcnt > 0
  begin
    GBTimeout::timeout($timeout) do
      executeShell("export LC_CTYPE=en_US.UTF-8;cd '#{installPath}';'#{$SVN}' co --no-auth-cache --non-interactive '#{path}'", true, true)
      if $errorcnt > 0
        # resetOldBundleFolder("#{installPath}")
        return
      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    # resetOldBundleFolder("#{installPath}")
  end
end

def filterBundleList
  $params['isBusy'] = true
  $params['bundleSelection']  = $dialogResult['bundleSelection']
  $params['targetSelection']  = $dialogResult['targetSelection']
  $params['usingGitZip']      = $dialogResult['usingGitZip']
  $params['progressText']     = "Filtering bundle list…"
  updateDIALOG
  b = []
  if $dialogResult['bundleSelection'] == 'GitHub'
    b = $dataarray.select {|v| v['repo'] == 'G'}
  elsif $dialogResult['bundleSelection'] == 'Review'
    b = $dataarray.select {|v| v['repo'] == 'R'}
  elsif $dialogResult['bundleSelection'] == 'Bundles'
    b = $dataarray.select {|v| v['repo'] == 'B'}
  else
    b = $dataarray
  end
  $params['numberOfBundles'] = "%d in total found" % b.size
  $params['dataarray'] = b
  $params['progressIsIndeterminate'] = true
  $params['isBusy'] = false
  updateDIALOG
end

def setTimeout
  if $dialogResult.has_key?('timeout')
    begin
      $timeout = $dialogResult['timeout'].to_i
    rescue
      $timeout = 30
      writeToLogFile("Timeout was set to 30")
    end
    if $timeout < 1 or $timeout > 600
      $timeout = 30
      writeToLogFile("Timeout was set to 30")
    end
  end
  $params['timeout'] = $timeout.to_s
end

##------- main -------##

# init DIALOG's parameters hash
$params = {
  'isBusy'                  => true,
  'progressIsIndeterminate' => true,
  'updateTMlibBtn'          => 'updateTMlibButtonIsPressed',
  'showHelpBtn'             => 'helpButtonIsPressed',
  'infoBtn'                 => 'infoButtonIsPressed',
  'revealBtn'               => 'revealButtonIsPressed',
  'openBundleEditorBtn'     => 'openBundleEditorButtonIsPressed',
  'cancelBtn'               => 'cancelButtonIsPressed',
  'targets'                 => targetPaths.keys.sort {|x,y| y <=> x },
  'targetSelection'         => targetPaths.keys.sort {|x,y| y <=> x }.first,
  'nocancel'                => false,
  'repoColor'               => '#0000FF',
  'logPath'                 => %x{cat '#{$logFile}'},
  'bundleSelection'         => 'All',
  'usingGitZip'             => false,
  'timeout'                 => '30',
  'updateBtnLabel'          => 'Update Descriptions',
}

initSVNDescriptionCache
initLogFile

orderOutDIALOG

$x1 = Thread.new do
  begin
    getBundleLists
  rescue
    writeToLogFile("Fatal Error")
    $run = false
    exit 0
  end
end

$SVN = ""
if ! %x{type -p svn}.strip!().nil?
  $SVN = "svn"
end
if ENV.has_key?('TM_SVN')
  $SVN = ENV['TM_SVN']
end

$GITMODE = ""
if ! %x{type -p git}.strip!().nil?
  $GITMODE = "clone"
end

while $run do
  getResultFromDIALOG
  setTimeout
  # writeToLogFile($dialogResult.inspect())
  if $dialogResult.has_key?('returnArgument')
    if $dialogResult['returnArgument'] == 'updateTMlibButtonIsPressed'
      $errorcnt = 0
      updateTMlibPath
      if $errorcnt > 0
        $params['progressText'] = 'Error while installing! Please check the Activity Log.'
        updateDIALOG
        sleep(3)
      end
      $errorcnt = 0
      $params['isBusy'] = false
      updateDIALOG
    elsif $dialogResult['returnArgument'] == 'helpButtonIsPressed'
      helpDIALOG
    elsif $dialogResult['returnArgument'] == 'cancelButtonIsPressed'
      $close = true
    elsif $dialogResult['returnArgument'] == 'infoButtonIsPressed'
      $x3 = Thread.new do
        infoDIALOG($dialogResult)
      end
    elsif $dialogResult['returnArgument'] == 'revealButtonIsPressed'
      %x{open -a Finder '#{getInstallPathFor($dialogResult['folder'])}'}
    elsif $dialogResult['returnArgument'] == 'openBundleEditorButtonIsPressed'
      %x{osascript -e 'tell app "System Events" to keystroke "b" using {control down, option down, command down}' }
    else
      if $dialogResult.has_key?('paths') and $dialogResult['paths'].size > 10
        if askDIALOG("Do you really want to install %d bundles?" % $dialogResult['paths'].size ,"") == 1
          $x2 = Thread.new do
            installBundles($dialogResult)
          end
        end
      else
        $x2 = Thread.new do
          installBundles($dialogResult)
        end
      end
    end
  elsif $dialogResult.has_key?('doUpdate') && $dialogResult['doUpdate'] == 1
    $x0 = Thread.new do
      getSVNBundleDescriptions
    end
  elsif $dialogResult.has_key?('rescanBundleList') && $dialogResult['rescanBundleList'] == 1
    $x4 = Thread.new do
      begin
        getBundleLists
      rescue
        writeToLogFile("Fatal Error")
        $run = false
        exit 0
      end
    end
  elsif $dialogResult.has_key?('bundleSelection')
    filterBundleList
  else ###### closing the window
    $close = true
    if ! $listsLoaded  # while fetching something from the net wait for aborting of threads
      $params['isBusy'] = true
      $params['progressText'] = 'Closing…'
      $params['progressIsIndeterminate'] = true
      updateDIALOG
      begin
        joinThreads
        killThreads
      rescue
      end
    end
    break
  end
  $dialogResult = { }
end
closeDIALOG
