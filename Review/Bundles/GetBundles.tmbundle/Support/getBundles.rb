#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/escape.rb'
require SUPPORT + '/lib/osx/plist'
require SUPPORT + '/lib/textmate.rb'
require "fileutils"
require "open-uri"
require "yaml"
require 'net/http'
require 'uri'
require 'cgi'
require "open3"
require "time"
require "rexml/document"

$DIALOG           = e_sh ENV['DIALOG']
$NIB              = `uname -r`.split('.')[0].to_i > 8 ? 'BundlesTree' : 'BundlesTreeTiger'
$isDIALOG2        = false # ! $DIALOG.match(/2$/).nil?

# the log file
$logFile          = "#{ENV['HOME']}/Library/Logs/TextMateGetBundles.log"
# GetBundles plist file
$plistFile        = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.getbundles.plist"
# GetBundles' plist hash
$gbplist          = nil
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
# set to true if Cancel button was pressed to interrput threads and each loops
$close            = false
# set to true for fetching something from the net (used for shut down procedure)
$listsLoaded      = false
# total number of found bundles
$numberOfBundles  = 0
# main run loop variable
$run              = true
# error counter
$errorcnt         = 0
# warning counter
$warningcnt       = 0
# temp dir for installation
$tempDir          = "/tmp/TM_GetBundlesTEMP"
# global timeout in seconds
$timeout          = 30
# global thread vars
$x0=$x1=$x2=$x3=$x4 = nil
# bundle data hash containing data.json.gz 
$bundleCache      = { }
# hash of used nicknames
$nicknames        = { }
# available installation modi
$availableModi    = ["svn", "zip"]
# URL to the bundle server's cache file
$bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json.gz"
# $bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json"
# URL to nicknames.txt
$nickNamesFile = "http://bibiko.textmate.org/bundleserver/nicknames.txt"
# locally installed bundles
$localBundles     = { }

# Pristine's Support Folder
$supportFolderPristine = "#{ENV['HOME']}/Library/Application Support/TextMate/Pristine Copy/Support"
# TextMate's Support Folder
$supportFolder    = "/Library/Application Support/TextMate/Support"
# should the Support Folder updated in beforehand?
$updateSupportFolder = true
# last bundle filter selection
$lastBundleFilterSelection = "All"

def local_bundle_paths
  { :Application       => TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles",
    :User              => "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
    :System            => '/Library/Application Support/TextMate/Bundles',
    :'User Pristine'   => "#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",
    :'System Pristine' => '/Library/Application Support/TextMate/Pristine Copy/Bundles',
    }
end

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

def strip_html(text)
  text.gsub(/<[^>]+>/, '')
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
  removeTempDir
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
  return unless dlg.has_key?('path')
  info = { }
  plist = { }
  readme = ""
  css = ""
  data = ""
  removeTempDir
  FileUtils.mkdir_p $tempDir
  bundle = $bundleCache['bundles'][dlg['path'].to_i]
  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = "Fetching information…"
  updateDIALOG
  return if $close
  url = bundle['url']
  mode = case bundle['status']
    when "Official": "svn"
    when "Under Review": "svn"
    else "url"
  end
  if mode == "url" && bundle.has_key?('url')
    mode = case bundle['url']
      when /^http:\/\/github\.com/: "github"
      else "url"
    end
  end
  if mode == 'github'
    namehasdot = false
    searchPath = url.gsub(/.*?com\/(.*?)\/(.*)/, '\1-\2')
    unless searchPath =~ /\./
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
        removeTempDir
        writeToLogFile("Timeout error while fetching information") if ! $close
        return
      end
    else
      namehasdot = true
      info = {}
      info['description'] = "<font color=silver><small>no data available</small></font>"
      info['watchers'] = "<font color=silver><small>no data available</small></font>"
      info['private'] = "<font color=silver><small>no data available</small></font>"
      info['forks'] = "<font color=silver><small>no data available</small></font>"
      info['owner'] = url.gsub(/.*?com\/(.*?)\/.*/,'\1')
    end
    return if $close
    begin
      GBTimeout::timeout($timeout) do
        data = Net::HTTP.get( URI.parse("#{url}/tree/master") )
      end
    rescue GBTimeout::Error
      $params['isBusy'] = false
      updateDIALOG
      removeTempDir
      writeToLogFile("Timeout error while fetching information") if ! $close
      return
    end
    return if $close
    begin
      GBTimeout::timeout($timeout) do
        begin
          plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{url}/tree/master/info.plist?raw=true")).gsub(/.*?(<plist.*?<\/plist>)/m,'\1'))
        rescue
          writeToLogFile($!)
        end
      end
    rescue GBTimeout::Error
      $params['isBusy'] = false
      updateDIALOG
      removeTempDir
      writeToLogFile("Timeout error while fetching information") if ! $close
      return
    end
    return if $close
    plist['name'] = bundle['name'] if plist['name'].nil?
    plist['description'] = "" if plist['description'].nil?
    plist['contactName'] = "" if plist['contactName'].nil?
    plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?
    readme = nil
    if data =~ /<div +id="readme".*?>/m
      readme = data.gsub( /.*?(<div +id="readme".*?>.*?)<div class="push">.*/m, '\1').gsub(/<span class="name">README.*?<\/span>/, '')
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
        <b>URL:</b><br />&nbsp;<a href='#{url}'>#{url}</a><br />
        <b>Owner:</b><br />&nbsp;<a href='http://github.com/#{info['owner']}'>#{info['owner']}</a><br />
        <b>Watchers:</b><br />&nbsp;#{info['watchers']}<br />
        <b>Private:</b><br />&nbsp;#{info['private']}<br />
        <b>Forks:</b><br />&nbsp;#{info['forks']}<br />
      HTML01
      io << <<-HTML02
      <br /><br />
      <h3><u>Bundle Information (info.plist):</u></h3>
      HTML02
      if ! plist['contactName'].empty? or ! plist['contactEmailRot13'].empty? or ! plist['description'].empty?
        io << "<b>Description:</b><br />&nbsp;#{plist['description']}<br />" unless plist['description'].empty?
        contact = ""
        contact = case
          when plist['contactName'].empty? && plist['contactEmailRot13'].empty?:  "<font color=#666666><small>no data available</small></font>"
          when plist['contactName'].empty? && !plist['contactEmailRot13'].empty?: "<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}</a>"
          when !plist['contactName'].empty? && plist['contactEmailRot13'].empty?: plist['contactName']
          when !plist['contactName'].empty? && !plist['contactEmailRot13'].empty?: "<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a>" 
        end
        io << "<b>Contact Name:</b><br />&nbsp;#{contact}<br />"
      end
      io << "<b>UUID:</b><br />&nbsp;#{plist['uuid']}"
      unless readme.nil?
        io << <<-HTML05
        <br /><br />
        <h3><u>README:</u></h3><br />
        #{readme}</div></div>
        </body></html>
        HTML05
      end
    end
  elsif mode == 'svn'
    if $SVN.length > 0
      begin
        GBTimeout::timeout($timeout) do
          data = executeShell("export LC_CTYPE=en_US.UTF-8;'#{$SVN}' info '#{bundle['source'].first['url']}'")
          if $errorcnt > 0
            removeTempDir
            $params['isBusy'] = false
            updateDIALOG
            return
          end
        end
      rescue GBTimeout::Error
        $params['isBusy'] = false
        updateDIALOG
        removeTempDir
        writeToLogFile("Timeout error while fetching information") unless $close
        return
      end
      return if $close
      svnlogs = nil
      begin
        GBTimeout::timeout($timeout) do
          svnlogs = executeShell("export LC_CTYPE=en_US.UTF-8;'#{$SVN}' log --limit 5 '#{bundle['source'].first['url']}'")
          $errorcnt -= 1 if $errorcnt > 0
        end
      rescue GBTimeout::Error
        writeToLogFile("Timeout error while fetching svn log information") unless $close
      end
      return if $close
      data.each_line do |l|
        info[l.split(': ').first] = l.split(': ').last.chomp
      end
      begin
        GBTimeout::timeout($timeout) do
          begin
            plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{bundle['source'].first['url']}/info.plist")))
          rescue
            begin
              plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse(URI.escape("#{bundle['source'].first['url']}/info.plist"))))
            rescue
              plist = OSX::PropertyList::load("{description='?';}")
            end
          end
        end
      rescue GBTimeout::Error
        $params['isBusy'] = false
        updateDIALOG
        removeTempDir
        writeToLogFile("Timeout error while fetching information") unless $close
        return
      end
      return if $close
      plist['name']               = bundle['name'] if plist['name'].nil?
      plist['description']        = "<font color=silver><small>no data available</small></font>" if plist['description'].nil?
      plist['contactName']        = "" if plist['contactName'].nil?
      plist['contactEmailRot13']  = "" if plist['contactEmailRot13'].nil?
      contact = ""
      contact = case
        when plist['contactName'].empty? && plist['contactEmailRot13'].empty?:  "<font color=#666666><small>no data available</small></font>"
        when plist['contactName'].empty? && !plist['contactEmailRot13'].empty?: "<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}</a>"
        when !plist['contactName'].empty? && plist['contactEmailRot13'].empty?: plist['contactName']
        when !plist['contactName'].empty? && !plist['contactEmailRot13'].empty?: "<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a>" 
      end
      info['Last Changed Author'] = $nicknames[info['Last Changed Author']] if ! $nicknames.nil? and $nicknames.has_key?(info['Last Changed Author'])
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
          <span style="background-color:#EEEEEE">
          <b>URL:</b><br />&nbsp;<a href='#{info['URL']}'>#{info['URL']}</a><br />
          <b>Contact Name:</b><br />&nbsp;#{contact}<br />
          <b>Last Changed Date:</b><br />&nbsp;#{Time.parse(info['Last Changed Date']).getutc.to_s}<br />
          <b>Last Changed Author:</b><br />&nbsp;#{info['Last Changed Author']}<br />
          <b>Last Changed Rev:</b><br />&nbsp;#{info['Last Changed Rev']}<br />
          <b>Revision:</b><br />&nbsp;#{info['Revision']}<br />
          <b>UUID:</b><br />&nbsp;#{plist['uuid']}<br />
          </span>
        HTML12
        io << "<br /><br /><b>Last svn log entries:</b><br /><pre>#{svnlogs}</pre>" unless svnlogs.nil?
        io <<  "</body></html>"
      end
    else          #### no svn client found
      noSVNclientFound
    end
  else
    if bundle.has_key?('url')
      %x{open "#{bundle['url']}"}
    else
      writeToLogFile("No method found to fetch information")
    end
    $params['isBusy'] = false
    $params['progressText'] = ""
    updateDIALOG
    return
  end
  $params['isBusy'] = false
  $params['progressText'] = ""
  updateDIALOG
  $infoTokenOld = $infoToken
  if $close
    removeTempDir
    return
  end
  if $isDIALOG2
    $infoToken = %x{#{$DIALOG} window create -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}" help }
  else
    $infoToken = %x{#{$DIALOG} -a help -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"}
  end
  unless $infoTokenOld.nil?
    if $isDIALOG2
      %x{#{$DIALOG} window close #{$infoTokenOld}}
    else
      %x{#{$DIALOG} -x#{$infoTokenOld}}
    end
  end
  removeTempDir
end

def noSVNclientFound
  writeToLogFile("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
  $params['progressText'] = 'No svn client found! Please check the Activity Log.'
  updateDIALOG
  sleep(3)
end

def askDIALOG(msg, text, btn1="No", btn2="Yes")
  msg.gsub!("'","’")
  text.gsub!("'","’")
  resStr = 0
  if $isDIALOG2
    resStr = %x{"$DIALOG" alert -s critical -m "#{msg}" -t "#{text}" -1 "#{btn1}" -2 "#{btn2}"}
  else
    resStr = %x{"$DIALOG" -e -p '{messageTitle="#{msg}";alertStyle=critical;informativeText="#{text}";buttonTitles=("#{btn1}","#{btn2}");}'}
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
  buildLocalBundleList
  $params['dataarray'] = [ ]
  updateDIALOG
  
  $listsLoaded = false

  $dataarray  = [ ]
  break if $close
  
  $params = {
    'isBusy'                  => true,
    'bundleSelection'         => 'All',
    'progressText'            => 'Connecting Bundle Server…',
    'progressIsIndeterminate' => true,
    'progressValue'           => 0,
  }
  updateDIALOG
  
  
  begin
    GBTimeout::timeout($timeout) do
      # download data.json.gz from textmate.org
      data_file = "#{$tempDir}/data.json.gz"
      nicks = nil
      FileUtils.mkdir_p $tempDir
      begin
        File.open(data_file, 'w') { |f| f.write(open($bundleServerFile).read) }
      rescue
        writeTimedMessage("Error: #{$!} while fetching the Bundle List file from the Bundle Server")
        return
      end
      # decompress data.json.gz
      begin
        %x{gzip -d '#{data_file}'}
      rescue
        writeTimedMessage("Error: #{$!} while decompressing the Bundle List file")
      end
      begin
        $bundleCache = YAML.load(open("#{$tempDir}/data.json"))
      rescue
        writeTimedMessage("Error: #{$!} while parsing the Bundle List file")
      end
      # get nicknames from textmte.org
      begin
        nicks = Net::HTTP.get(URI.parse($nickNamesFile))
      rescue
        writeToLogFile("Could not load nicknames: #{$!}")
      end
      unless nicks.nil?
        nicks.each_line do |l|
          $nicknames[l.split("\t").first] = l.split("\t").last
        end
      end
      # data_file = "#{$tempDir}/data.json"
      # FileUtils.mkdir_p $tempDir
      # begin
      #   File.open(data_file, 'w') { |f| f.write(open($bundleServerFile).read) }
      # rescue
      #   writeTimedMessage("Error: #{$!} while fetching the Bundle List file from the Bundle Server")
      #   return
      # end
      # begin
      #   $bundleCache = YAML.load(open(data_file))
      # rescue
      #   writeTimedMessage("Error: #{$!} while parsing the Bundle List file")
      # end
    end
  rescue GBTimeout::Error
    writeTimedMessage("Timeout while connecting Bundle Server", "Timeout while connecting Bundle Server")
  rescue
    writeTimedMessage("Error: #{$!} while connecting Bundle Server")
  end
  unless $bundleCache.has_key?('bundles')
    writeTimedMessage("Structural error in Bundle Server File")
    return
  end
  index = 0
  $bundleCache['bundles'].sort!{|a,b| (n = a['name'].downcase <=> b['name'].downcase).zero? ? a['status'] <=> b['status'] : n}
  $bundleCache['bundles'].each do |bundle|
    break if $close
    author = (bundle['contact'].empty?) ? "" : " (by %s)" % bundle['contact']
    desc = strip_html(bundle['description'].gsub(/(?m)<hr[^>]*?\/>.*/,'').gsub(/\n/, ' ') + author)
    repo = case bundle['status']
      when "Official": "O"
      when "Under Review": "R"
      else "❸"
    end
    if repo == "❸" && bundle.has_key?('url')
      repo = case bundle['url']
        when /github\.com/: "G"
        else "P"
      end
    end
    updated = ""
    updatedStr = ""
    if repo == "P"
      $localBundles.each_value do |h|
        if h['name'] == bundle['name']
          updated = (Time.parse(bundle['revision']).getutc > Time.parse(h['rev']).getutc) ? "U" : "✓"
          break
        end
      end
    else
      if $localBundles.has_key?(bundle['uuid'])
        updated = (Time.parse(bundle['revision']).getutc > Time.parse($localBundles[bundle['uuid']]['rev']).getutc) ? "U" : "✓"
        updated += $localBundles[bundle['uuid']]['scm']
      end
    end
    updatedStr = (updated.empty?) ? "" : (updated =~ /^U/) ? "=i=u" : "=i"
    $dataarray << {
      'name' => bundle['name'],
      'path' => index.to_s,
      'bundleDescription' => desc,
      'searchpattern' => "#{bundle['name']} #{desc} r=#{repo} #{updatedStr}",
      'repo' => repo,
      'rev' => Time.parse(bundle['revision']).strftime("%Y/%m/%d %H:%M:%S"),
      'updated' => updated
    }
    index += 1
  end
  writeToLogFile("Cache File lists %d bundles. Last modified date: %s" % [$dataarray.size, $bundleCache['cache_date'].to_s])
  unless $close
    $numberOfBundles = $dataarray.size
    $params['numberOfBundles'] = "%d in total found" % $numberOfBundles
    $params['dataarray'] = $dataarray
    updateDIALOG
  end
  $params['isBusy'] = false
  $params['rescanBundleList'] = 0
  updateDIALOG
  $listsLoaded = true
  writeTimedMessage("Probably no internet connection available", "Probably no internet connection available") if $dataarray.empty? and ! $close

  # suppress the updating of the table to preserve the selection
  $params.delete('dataarray')

end

def buildLocalBundleList
  $localBundles = { }
  local_bundle_paths.each do |name, path|
    Dir["#{path}/*.tmbundle"].each do |b|
      begin
        plist = OSX::PropertyList::load(open("#{b}/info.plist"))
        if !plist.has_key?('isDelta') && !plist['isDelta'] == true
          theCtime = File.new(b).ctime.getutc
          scm = (File.directory?("#{b}/.svn")) ? "  (svn)" : ""
          scm = (File.directory?("#{b}/.git")) ? "  (git)" : scm
          if $localBundles.has_key?(plist['uuid'])
            if Time.parse($localBundles[plist['uuid']]['rev']).getutc < theCtime
              $localBundles[plist['uuid']] = {'name' => plist['name'], 'scm' => scm, 'rev' => theCtime.to_s}
            end
          else
            $localBundles[plist['uuid']] = {'name' => plist['name'], 'scm' => scm, 'rev' => theCtime.to_s}
          end
        else
        end
      rescue
        writeToLogFile("Error while parsing “#{b}”: #{$!}")
      end
    end
  end
  writeToLogFile("Locally #{$localBundles.size} bundles are installed")
end

def updateUpdated
  buildLocalBundleList
  cnt = 0
  
  $dataarray.each do |r|
    updated = ""
    if r['repo'] == "P"
      $localBundles.each_value do |h|
        if h['name'] == r['name']
          updated = (Time.parse($bundleCache['bundles'][cnt]['revision']).getutc > Time.parse(h['rev']).getutc) ? "U" : "✓"
          break
        end
      end
    else
      if $localBundles.has_key?($bundleCache['bundles'][cnt]['uuid'])
        updated = (Time.parse($bundleCache['bundles'][cnt]['revision']).getutc > Time.parse($localBundles[$bundleCache['bundles'][cnt]['uuid']]['rev']).getutc) ? "U" : "✓"
      end
    end
    r['updated'] = (r['updated'].empty?) ? updated : r['updated'].gsub(/^./, updated)
    cnt += 1
  end
  b = case $params['bundleSelection']
    when "3rd Party":  $dataarray.select {|v| v['repo'] !~ /^O|R$/}
    when "Review":  $dataarray.select {|v| v['repo'] == 'R'}
    when "Official": $dataarray.select {|v| v['repo'] == 'O'}
    else $dataarray
  end
  $params['dataarray'] = b
  updateDIALOG
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
  File.open($logFile, "w") {}
end

# def initGetBundlesPlist
#   File.open($plistFile, "w") { |io| io << [].to_plist } unless File.exist?($plistFile)
#   $gbplist = OSX::PropertyList::load(open($plistFile))
# end

def removeTempDir
  if File.directory?($tempDir)
    if $tempDir == "/tmp/TM_GetBundlesTEMP"
      %x{rm -r #{$tempDir} 1> /dev/null}
    else
      writeToLogFile("TempDir alert!")
    end
  end
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

def writeTimedMessage(logtext, displaytext="An error occurred. Please check the Log.", sleepFor=2)
  return if $close
  writeToLogFile(logtext) unless logtext.nil?
  $params['isBusy'] = true
  $params['progressText'] = displaytext
  updateDIALOG
  sleep(sleepFor)
  $params['isBusy'] = false
  $params['rescanBundleList'] = 0
  updateDIALOG
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
  unless err.empty?
    $errorcnt += 1
    writeToLogFile(err)
    return
  end
  return out
end

def installBundles(dlg)
  doUpdateSupportFolder if $updateSupportFolder
  $listsLoaded = false
  cnt = 0 # counter for installed bundles
  unless $close
    $params['isBusy'] = true
    $params['progressIsIndeterminate'] = true
    $params['progressText'] = "Installing…"
    updateDIALOG
    items = dlg['returnArgument']
    items.each do |item|
      break if $close
      $errorcnt = 0
      cnt += 1
      # get the bundle data (from json file)
      bundleData = $bundleCache['bundles'][item.to_i]
      if $localBundles.has_key?(bundleData['uuid']) && ! $localBundles[bundleData['uuid']]['scm'].empty?
        next if askDIALOG("It seems that the bundle “#{bundleData['name']}” has been already installed under versioning control #{$localBundles[bundleData['uuid']]['scm'].gsub(/ +/,'')}. If you continue the versioning control will not be updated!", " Do you really want to continue?")
      end
      name = bundleData['name']
      zip_path = nil
      source = nil
      $availableModi.each do |mode|
        source = bundleData['source'].find { |m| m['method'] == mode }
        (source.nil?) ? next : break
      end
      if source.nil?
        writeTimedMessage("No method found to install “#{name}”", "Installation was skipped.", 1)
        next
      end
      path = source['url']
      mode = source['method']
      zip_path = source['zip_path'] if source.has_key?('zip_path')
      break if $close
      writeToLogFile("Installing “%s”" % name)
      if mode.nil? or path.nil?
        writeTimedMessage("No valid source data found")
        mode = "skip"
      end
      if mode != 'skip'
        $params['progressText'] = "Installing “#{name}”"
        $params['progressText'] += (items.size == 1) ? "…" : " (#{cnt} / #{items.size})…"
      end
      updateDIALOG
      break if $close
      case mode
        when "svn" 
          installSVN(name, path)
        when "zip"
          installZIP(name, path, zip_path)
        else
          writeToLogFile("No method found to install “#{name}”")
          $params['progressText'] = "Installing “#{name}” was skipped. Please check the Log."
          updateDIALOG
          sleep(1)
          next
      end
      break if $close
      if $errorcnt > 0
        writeTimedMessage(nil,'Error while installing! Please check the Log.')
        $errorcnt = 0
        break
      end
    end
    $params['isBusy'] = false
    $params['progressText'] = ""
    updateDIALOG
  end
  removeTempDir
  updateUpdated
  $listsLoaded = true
end

def installZIP(name, path, zip_path)
  removeTempDir
  FileUtils.mkdir_p $tempDir
  begin
    GBTimeout::timeout($timeout) do
      begin
        if path =~ /^http:\/\/github\.com/
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.zip" "#{path}"; then
  if unzip --qq "#{$tempDir}/archive.zip" -d "#{$tempDir}"; then
    rm "#{$tempDir}/archive.zip"
    mv "#{$tempDir}/"* "#{$tempDir}/#{name}.tmbundle"
  fi
fi
          }, false, true)
        elsif !zip_path.nil? and zip_path =~ /\.tmbundle$/
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.zip" "#{path}"; then
  if unzip --qq "#{$tempDir}/archive.zip" -d "#{$tempDir}"; then
    rm "#{$tempDir}/archive.zip"
    [[ ! -e "#{$tempDir}/#{zip_path}" ]] && mv "#{$tempDir}/"*"/#{zip_path}" "#{$tempDir}/#{name}.tmbundle"
  fi
fi
          }, false, true)
          name = zip_path.gsub(".tmbundle","")
        else
          $errorcnt += 1
          writeToLogFile("Could not install “#{name}” by using “#{path}”")
          removeTempDir
          return
        end
      rescue
        $errorcnt += 1
        writeToLogFile("Error: #{$!}")
        return
      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    writeToLogFile("Timeout error while installing %s" % name) unless $close
    return
  end
  return if $close
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0
end

def installSVN(name, path)
  removeTempDir
  FileUtils.mkdir_p $tempDir
  if $SVN.length > 0
    begin
      GBTimeout::timeout(60) do
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8
cd '#{$tempDir}'
'#{$SVN}' export '#{path}' '#{name}.tmbundle'
        }, true, true)
        if $errorcnt > 0
          removeTempDir
          return
        end
      end
    rescue GBTimeout::Error
      $errorcnt += 1
      removeTempDir
      writeToLogFile("Timeout error while installing %s" % name) unless $close
      return
    end
    # get the bundle's real name (esp. for spaces and other symbols)
    return if $close
    executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0
  else          #### no svn client found
    noSVNclientFound
  end
end

def checkForSupportFolderUpdate
  val = 1
  if File.directory?("#{$supportFolderPristine}/.svn")
    # get svn info
    begin
      doc = REXML::Document.new(File.read("|svn info --xml '#{$supportFolderPristine}'"))
      localRev = Time.parse(doc.root.elements['//info/entry/commit/date'].text).getutc
      cacheRev = Time.parse($bundleCache['SupportFolder']['revision']).getutc
    rescue
      writeTimedMessage("Error while getting 'svn info' data of the “Support Folder”")
      return
    end
    val = (cacheRev > localRev) ? 1 : 0
    $updateSupportFolder = (cacheRev > localRev) ? true : false
  end
  writeToLogFile("TextMate's “Support Folder” (#{$supportFolderPristine}) will be updated.") if val == 1
end

def doUpdateSupportFolder
  path = $bundleCache['SupportFolder']['url']
  folderCreated = false
  if path.nil?
    writeTimedMessage("No Support Folder URL found in cache file")
    return
  end
  if $SVN.empty?
    $errorcnt += 1
    noSVNclientFound
    return
  end
  if File.directory?("#{$supportFolderPristine}/.svn") 
    doc = REXML::Document.new(File.read("|svn info --xml '#{$supportFolderPristine}'"))
    supportURL = doc.root.elements['//info/entry/url'].text
    if supportURL =~ /^http:\/\/macromates/
      executeShell(%Q{
cd '/Library/Application Support/TextMate/Support'
svn switch --relocate http://macromates.com/svn/Bundles/trunk/Support http://svn.textmate.org/trunk/Support/
      }, true, true)
      if $errorcnt == 0
        writeToLogFile("“Support Folder”s svn repository was relocated")
      else
        writeTimedMessage("Error while relocating the svn repository of the “Support Folder”")
        return
      end
    end
  else
    begin
      FileUtils.rm_rf($supportFolderPristine)
      FileUtils.mkdir_p($supportFolderPristine)
    rescue
      writeTimedMessage("Error while creating “Support Folder”: #{$!}")
      return
    end
    folderCreated = true
  end
  begin
    File.symlink($supportFolderPristine, $supportFolder) unless File.directory?($supportFolder)
  rescue
    writeTimedMessage("Error while creating a symbolic link: #{$!}")
    return
  end
  if File.directory?($supportFolder) and ! File.symlink?($supportFolder)
    writeToLogFile("Please note that you are using your own “Support Folder” (#{$supportFolder}) which won't be touch by GetBundles' update!\n To use the update simply rename or delete ‘#{$supportFolder}’ and rerun ‘Update “Support Folder”’.")
  end
  $params['isBusy'] = true
  $params['progressText'] = "Updating TextMate's “Support Folder”…"
  $params['progressIsIndeterminate'] = true
  updateDIALOG
  begin
    GBTimeout::timeout(120) do
      if File.directory?($supportFolderPristine) and ! folderCreated
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolderPristine}';
'#{$SVN}' up
        }, true, true)
        return if $errorcnt > 0
      else
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolderPristine.gsub('/Support','')}';
'#{$SVN}' co --no-auth-cache --non-interactive '#{path}'
        }, true, true)
        return if $errorcnt > 0
      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    writeTimedMessage("Timeout while updating TextMate's “Support Folder”. Please check folder ‘#{$supportFolder}’!\n \
    If problems occur remove ‘#{$supportFolder}’ manully and retry it.")
  end
  $params['supportFolderCheck'] = 0
  $params['isBusy'] = false
  $params['progressText'] = ""
  updateDIALOG
end

def filterBundleList
  $params['isBusy'] = true
  $params['bundleSelection']  = $dialogResult['bundleSelection']
  $params['progressText']     = "Filtering bundle list…"
  updateDIALOG
  b = case $dialogResult['bundleSelection']
    when "3rd Party":  $dataarray.select {|v| v['repo'] !~ /^O|R$/}
    when "Review":  $dataarray.select {|v| v['repo'] == 'R'}
    when "Official": $dataarray.select {|v| v['repo'] == 'O'}
    else $dataarray
  end
  $lastBundleFilterSelection = $dialogResult['bundleSelection']
  $params['numberOfBundles'] = "%d in total found" % b.size
  $params['dataarray'] = b
  $params['progressIsIndeterminate'] = true
  $params['isBusy'] = false
  updateDIALOG
end

def checkUniversalAccess
  ui = %x{osascript -e 'tell app "System Events" to set isUIScriptingEnabled to UI elements enabled'}
  if ui =~ /^false/
    if askDIALOG("AppleScript's “UI scripting” is not enabled. Getbundles needs it to perform “Show Help Window”, “Open Bundle Editor”, and “to activate Getbundles if it's already open”.", "Do you want to open “System Preferences” to enable “Enable access for assistive devices”?", "Continue", "Cancel") == 0
      %x{osascript -e 'tell app "System Preferences" ' -e 'activate' -e 'set current pane to pane "com.apple.preference.universalaccess"' -e 'end tell'}
    end
  end
end

##------- main -------##

# init DIALOG's parameters hash
$params = {
  'isBusy'                  => true,
  'progressIsIndeterminate' => true,
  'updateTMlibBtn'          => 'updateTMlibButtonIsPressed',
  'showHelpBtn'             => 'helpButtonIsPressed',
  'infoBtn'                 => 'infoButtonIsPressed',
  'cancelBtn'               => 'cancelButtonIsPressed',
  'nocancel'                => false,
  'repoColor'               => '#0000FF',
  'logPath'                 => %x{cat '#{$logFile}'},
  'bundleSelection'         => 'All',
  'openBundleEditor'        => 0,
  'supportFolderCheck'      => 0,
  'progressText'            => "Parsing local bundles…"
}

initLogFile
# initGetBundlesPlist
orderOutDIALOG
checkUniversalAccess



$x1 = Thread.new do
  begin
    getBundleLists
    checkForSupportFolderUpdate
  rescue
    writeTimedMessage("Error while connecting Bundle Server:\n#{$!}", "An error occurred. Please check the Log!")
  end
end

$SVN = ""
unless %x{type -p svn}.strip!().nil?
  $SVN = "svn"
end
if ENV.has_key?('TM_SVN')
  $SVN = ENV['TM_SVN']
end

while $run do
  getResultFromDIALOG
  # writeToLogFile($dialogResult.inspect())
  if $dialogResult.has_key?('returnArgument')
    if $dialogResult['returnArgument'] == 'helpButtonIsPressed'
      helpDIALOG
    elsif $dialogResult['returnArgument'] == 'cancelButtonIsPressed'
      $close = true
    elsif $dialogResult['returnArgument'] == 'infoButtonIsPressed'
      $x3 = Thread.new { infoDIALOG($dialogResult) }
    else
      if $dialogResult['returnArgument'].size > 10
        if askDIALOG("Do you really want to install %d bundles?" % $dialogResult['paths'].size ,"") == 1
          $x2 = Thread.new { installBundles($dialogResult) }
        end
      else
        $x2 = Thread.new { installBundles($dialogResult) }
      end
    end
  elsif $dialogResult.has_key?('openBundleEditor') && $dialogResult['openBundleEditor'] == 1
    %x{osascript -e 'tell app "System Events" to keystroke "b" using {control down, option down, command down}' }
    $params['openBundleEditor'] = 0
    updateDIALOG
  elsif $dialogResult.has_key?('refreshBundleList') && $dialogResult['refreshBundleList'] == 1
    $x4 = Thread.new do
      begin
        updateUpdated
        $params['refreshBundleList'] = 0
        updateDIALOG
      rescue
        writeToLogFile("Fatal Error 02: #{$!}")
        $run = false
        exit 0
      end
    end
  elsif $dialogResult.has_key?('rescanBundleList') && $dialogResult['rescanBundleList'] == 1
    $x4 = Thread.new do
      begin
        getBundleLists
      rescue
        writeToLogFile("Fatal Error 02: #{$!}")
        $run = false
        exit 0
      end
    end
  elsif $dialogResult.has_key?('bundleSelection') and $lastBundleFilterSelection != $dialogResult['bundleSelection']
    filterBundleList
  elsif $dialogResult.has_key?('supportFolderCheck')
    if $dialogResult['supportFolderCheck'] == 1
      doUpdateSupportFolder
      checkForSupportFolderUpdate
    else
      writeToLogFile("Update “Support Folder” was switched off") if $updateSupportFolder
      $updateSupportFolder = false
    end
    $params['supportFolderCheck'] = 0
    updateDIALOG
  else ###### closing the window
    $close = true
    unless $listsLoaded  # while fetching something from the net wait for aborting of threads
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
