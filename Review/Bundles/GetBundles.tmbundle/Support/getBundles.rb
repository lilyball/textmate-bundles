#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/escape.rb'
require SUPPORT + '/lib/osx/plist'
require SUPPORT + '/lib/textmate.rb'
require "fileutils"
require "open-uri"
require "yaml"
require 'net/http'
require "open3"
require "time"
require "rexml/document"

$DIALOG           = e_sh ENV['DIALOG']
$NIB              = `uname -r`.split('.')[0].to_i > 8 ? 'BundlesTree' : 'BundlesTreeTiger'
$isDIALOG2        = false # ! $DIALOG.match(/2$/).nil?

# the log file
$logFile          = "#{ENV['HOME']}/Library/Logs/TextMateGetBundles.log"
# Log file handle
$logFileHandle    = nil

# DIALOG's parameters hash
$params           = { }
# DIALOG's async token
$token            = nil
$infoToken        = nil
# result hash of the the DIALOG
$dialogResult     = { }

# table of all bundles with repo, name, bundleDescription, path
$dataarray        = [ ]

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
# temp dir for installation
$tempDir          = "/tmp/TM_GetBundlesTEMP"
# global timeout in seconds
$timeout          = 45
# global thread vars
$initThread=$installThread=$infoThread=$refreshThread=$reloadThread=$svnlogThread=$svndataThread = nil
# bundle data hash containing data.json.gz 
$bundleCache      = { }
# hash of used nicknames
$nicknames        = { }
# available installation modi
$availableModi    = ["svn", "tar", "zip"]
# URL to the bundle server's cache file
$bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json.gz"
# URL to nicknames.txt
$nickNamesFile = "http://bibiko.textmate.org/bundleserver/nicknames.txt"
# locally installed bundles
$localBundles     = { }

# Pristine's Support Folder
$supportFolderPristine = "#{ENV['HOME']}/Library/Application Support/TextMate/Pristine Copy/Support"
# TextMate's standard Support folder
$asFolder    = "/Library/Application Support/TextMate"
# TextMate's Support Folder
$supportFolder    = "#{$asFolder}/Support"
# should the Support Folder updated in beforehand?
$updateSupportFolder = true
# last bundle filter selection
$lastBundleFilterSelection = "All"
# hash with uuid of deleted or disabled bundles stored in TextMate's plist
$deletedCoreAndDisabledBundles = { }
# array of just installed bundles which are marked as deleted/disabled for status
$justUndeletedCoreAndEnabledBundles = [ ]



def local_bundle_paths
  [
    TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles",
   "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
   '/Library/Application Support/TextMate/Bundles',
   "#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",
   '/Library/Application Support/TextMate/Pristine Copy/Bundles'
  ]
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

  writeToLogFile("GetBundles' DIALOG runs at token #{$token}")
  $params['nocancel'] = false
  updateDIALOG

end

def closeDIALOG

  list = ""
  # close all DIALOGs containing 'GetBundles' in their titles (main, info)
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
  url = bundle['url']

  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = "Fetching information…"
  updateDIALOG

  return if $close

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
    projectName = url.gsub(/.*?com\/(.*?)\/(.*)/, '\2')
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

    else # github project contains a dot => due to a bug of github's API no info
      namehasdot = true
      info = {}
      info['description'] = "<font color=silver><small>no data available</small></font>"
      info['watchers'] = "<font color=silver><small>no data available</small></font>"
      info['private'] = "<font color=silver><small>no data available</small></font>"
      info['forks'] = "<font color=silver><small>no data available</small></font>"
      info['owner'] = url.gsub(/.*?com\/(.*?)\/.*/,'\1')
    end

    return if $close

    lastCommit = nil

    begin
      GBTimeout::timeout(10) do
        loop do
          begin
            lastCommit = YAML.load(open("http://github.com/api/v1/json/#{info['owner']}/#{projectName}/commits/master"))['commits'].first['committed_date']
          rescue
            lastCommit = nil
          end
          break unless lastCommit.nil?
        end
      end
    rescue GBTimeout::Error
      puts "Last commit date read error for #{url}."
      lastCommit = nil
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
    
    gitsource = bundle['source'].find { |m| m['method'] == "git" }['url']
    zipsource = bundle['source'].find { |m| m['method'] == "zip" }['url']
    tarsource = bundle['source'].find { |m| m['method'] == "tar" }['url']

    plist['name'] = bundle['name'] if plist['name'].nil?
    plist['description'] = "" if plist['description'].nil?
    plist['contactName'] = "" if plist['contactName'].nil?
    plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?

    # get Readme if available plus CSS for display
    readme = nil
    if data =~ /<div +id="readme".*?>/m
      readme = data.gsub( /.*?(<div +id="readme".*?>.*?)<div class="push">.*/m, '\1').gsub(/<span class="name">README.*?<\/span>/, '')
    end
    css = data.gsub( /.*?(<link href="\/stylesheets\/.*?\/>).*/m, '\1')
    data = ""

    return if $close

    gitbugreport = (namehasdot) ? "&nbsp;&nbsp;&nbsp;<i><small>incomplete caused by the dot in project name (known GitHub bug)</small></i><br>" : ""

    updateinfo = ""
    if !lastCommit.nil? && Time.parse(lastCommit).getutc > Time.parse(bundle['revision']).getutc
      t = "This bundle was updated meanwhile."
      updateinfo = "<p align='right'><small><font color='#darkgreen'>#{t}</font></small></p>"
    end

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
        #{updateinfo}
        <h3><u>git Information:</u></h3>#{gitbugreport}
        <b>Description:</b><br />&nbsp;#{info['description']}<br />
        <b>URL:</b><br />&nbsp;<a href='#{url}'>#{url}</a><br />
        <b>Owner:</b><br />&nbsp;<a href='http://github.com/#{info['owner']}'>#{info['owner']}</a><br />
        <b>Watchers:</b><br />&nbsp;#{info['watchers']}<br />
        <b>Private:</b><br />&nbsp;#{info['private']}<br />
        <b>Forks:</b><br />&nbsp;#{info['forks']}<br />
        <b>git clone:</b><br /><pre><small><small>export LC_CTYPE=en_US.UTF-8
mkdir -p ~/Library/Application\\ Support/TextMate/Bundles
cd ~/Library/Application\\ Support/TextMate/Bundles
git clone #{gitsource} '#{plist['name']}.tmbundle'
osascript -e 'tell app "TextMate" to reload bundles'</small></small></pre>
        HTML01
        
      if $localBundles.has_key?(bundle['uuid']) && ! $localBundles[bundle['uuid']]['scm'].empty?
        io << <<-HTML011
        <b>git pull:</b><br /><pre><small><small>export LC_CTYPE=en_US.UTF-8
cd '#{$localBundles[bundle['uuid']]['path']}'
git pull
osascript -e 'tell app "TextMate" to reload bundles'</small></small></pre>
      HTML011
      end
        
      io << <<-HTML02
      <b>zip archive:</b><br />&nbsp;<a href='#{zipsource}'>#{zipsource}</a><br />
      <b>tar archive:</b><br />&nbsp;<a href='#{tarsource}'>#{tarsource}</a><br />        
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
  
    if $SVN.empty?
      $errorcnt += 1
      writeToLogFile("Could not install “#{name}”.")
      noSVNclientFound
      return
    end
    
    data = nil
    svnlogs = nil
    svnsource = bundle['source'].find { |m| m['method'] == "svn" }['url']

    $svnlogThread = Thread.new($SVN, bundle['source'].first['url']) { %x{'#{$SVN}' log --limit 5 #{bundle['source'].first['url']}} }
    $svndataThread = Thread.new($SVN, bundle['source'].first['url']) { %x{#{$SVN} info #{bundle['source'].first['url']}} }
    $svnInfoHostThread = Thread.new(svnsource) do
      # get info.plist data
      begin
        plist = OSX::PropertyList::load(%x{curl -L "#{svnsource}/info.plist"})
      rescue
        plist = nil
      end
    end

    begin
      GBTimeout::timeout($timeout) do
        $svnlogThread.join
        $svndataThread.join
        $svnInfoHostThread.join
      end
    rescue GBTimeout::Error
      begin
        $svnInfoHostThread.kill
      rescue
      end
      begin
        $svnlogThread.kill
      rescue
      end
      begin
        $svndataThread.kill
      rescue
      end
      writeToLogFile("Timeout error while fetching information") unless $close
      $params['isBusy'] = false
      updateDIALOG
    rescue
      $params['isBusy'] = false
      updateDIALOG
      writeToLogFile("Error while fetching information:\n#{$!}") unless $close
      return
    end
    
    svnlogs = $svnlogThread.value
    data    = $svndataThread.value
    plist   = $svnInfoHostThread.value

    if data.nil? || plist.nil?
      writeTimedMessage("Could not fetch svn information entirely for “#{bundle['name']}”") unless $close
      return
    end

    return if $close

    data.each_line do |l|
      info[l.split(': ').first] = l.split(': ').last.chomp
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
    
    # check for versionig control to alert
    relocateHint = ""
    if $localBundles.has_key?(bundle['uuid']) && ! $localBundles[bundle['uuid']]['scm'].empty?
      localUrl = %x{head -n5 '#{$localBundles[bundle['uuid']]['path']}/.svn/entries' | tail -n1}
      if localUrl =~ /macromates\.com/
        relocateHint << <<-HINT
      <pre>cd '#{$localBundles[bundle['uuid']]['path']}'
svn switch --relocate #{localUrl} #{localUrl.gsub("http://macromates.com/svn/Bundles/trunk/","http://svn.textmate.org/trunk/")}
</pre>
      HINT
      end
    end
    
    
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
      if Time.parse(info['Last Changed Date']).getutc > Time.parse(bundle['revision']).getutc
        t = "This bundle was updated meanwhile."
        io << "<p align='right'><small><font color='#darkgreen'>#{t}</font></small></p>"
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
        <b>svn checkout</b><br /><pre>export LC_CTYPE=en_US.UTF-8
mkdir -p ~/Library/Application\\ Support/TextMate/Bundles
cd ~/Library/Application\\ Support/TextMate/Bundles
svn co #{svnsource}
osascript -e 'tell app "TextMate" to reload bundles'
</pre>
       HTML12

      if $localBundles.has_key?(bundle['uuid']) && ! $localBundles[bundle['uuid']]['scm'].empty?
        io << <<-HTML121
        <b>svn update</b><br /><pre>export LC_CTYPE=en_US.UTF-8
cd '#{$localBundles[bundle['uuid']]['path']}'
svn up
osascript -e 'tell app "TextMate" to reload bundles'
</pre>
        HTML121
      end
      io << "<br /></span>"
      unless relocateHint.empty?
        io << <<-HTML112
        <br /><b><span style="color:red">Hint</span></b> The svn URL points to an old repository. To relocate it please use the following command:<br />
        #{relocateHint}
        HTML112
      end

      io << "<br /><br /><b>Last svn log entries:</b><br /><pre>#{svnlogs}</pre>" unless svnlogs.nil?
      io <<  "</body></html>"
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
  
  # order out info window
  if $isDIALOG2
    $infoToken = %x{#{$DIALOG} window create -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}" help }
  else
    $infoToken = %x{#{$DIALOG} -a help -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"}
  end

  # close old info window if it exists
  unless $infoTokenOld.nil?
    if $isDIALOG2
      %x{#{$DIALOG} window close #{$infoTokenOld}}
    else
      %x{#{$DIALOG} -x#{$infoTokenOld}}
    end
  end
  
  removeTempDir
  
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

def noSVNclientFound
  writeTimedMessage("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
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
    writeToLogFile("Fatal error while retrieving data from DIALOG.")
    $run = false
    exit 1
  end

end

def getBundleLists

  # only to speed up the init process
  locBundlesThread = Thread.new { buildLocalBundleList }
  
  $listsLoaded = false
  $dataarray  = [ ]
  break if $close
  
  unless $firstrun
    $params = {
      'isBusy'                  => true,
      'bundleSelection'         => 'All',
      'progressText'            => 'Connecting Bundle Server…',
      'progressIsIndeterminate' => true,
      'progressValue'           => 0,
      'dataarray'               => [],
    }
    updateDIALOG
  end
  
  begin
    GBTimeout::timeout($timeout) do
      
      # read data file from bundle server
      begin
        $bundleCache = YAML.load(File.read("|curl #{$bundleServerFile} | gzip -d"))
      rescue
        writeTimedMessage("Error: #{$!} while parsing the Bundle Server file")
      end
      
      # get nicknames from textmte.org
      nicks = nil
      begin
        nicks = File.read("|curl --compressed #{$nickNamesFile}")
      rescue
        writeToLogFile("Could not load nicknames: #{$!}")
      end
      unless nicks.nil?
        nicks.each_line do |l|
          $nicknames[l.split("\t").first] = l.split("\t").last
        end
      end
      
    end
  rescue GBTimeout::Error
    writeTimedMessage("Timeout while connecting Bundle Server", "Timeout while connecting Bundle Server")
  rescue
    writeTimedMessage("Error: #{$!} while loading the bundle list")
  end
  
  # check $bundleCache hash for key 'bundles'
  begin
    unless $bundleCache.has_key?('bundles')
      writeTimedMessage("Structural error in Bundle Server File")
      return
    end
  rescue
    writeTimedMessage("Structural error in Bundle Server File")
    return
  end
  
  # sort the cache first against name then against host
  $bundleCache['bundles'].sort!{|a,b| (n = a['name'].downcase <=> b['name'].downcase).zero? ? a['status'] <=> b['status'] : n}

  # wait for parsing local bundles
  begin
    $params['isBusy'] = true
    $params['progressText'] = "Parsing local bundles…"
    updateDIALOG
    GBTimeout::timeout($timeout) {locBundlesThread.join}
  rescue
    writeToLogFile("Timeout while parsing local bundles") unless $close
    begin
      locBundlesThread.kill
    rescue
    end
  end
  
  # build $dataarray for NIB
  index = 0
  $bundleCache['bundles'].each do |bundle|

    break if $close

    author = (bundle['contact'].empty?) ? "" : " (by #{bundle['contact']})"

    # show only first part of description if description is subdivided by <hr>
    desc = strip_html(bundle['description'].gsub(/(?m)<hr[^>]*?\/>.*/,'').gsub(/\n/, ' ') + author)

    repo = case bundle['status']
      when "Official":      "O"
      when "Under Review":  "R"
      else "3"
    end
    if repo == "3" && bundle.has_key?('url')
      repo = case bundle['url']
        when /github\.com/: "G"
        else "P"
      end
    end
    
    # get update status
    updated = ""
    updatedStr = "" # for searching
    if repo == "P" # then compare names
      $localBundles.each_value do |localBundle|
        if localBundle['name'] == bundle['name']
          updated = (Time.parse(bundle['revision']).getutc > Time.parse(localBundle['rev']).getutc) ? "U" : "✓"
          break
        end
      end
    else # compare ctime of local tmbundle dir
      if $localBundles.has_key?(bundle['uuid'])
        updated = (Time.parse(bundle['revision']).getutc > Time.parse($localBundles[bundle['uuid']]['rev']).getutc) ? "U" : "✓"
        updated += $localBundles[bundle['uuid']]['scm'] + $localBundles[bundle['uuid']]['deleted'] + $localBundles[bundle['uuid']]['disabled']
      end
    end

    # set searchpattern
    updatedStr = (updated.empty?) ? "" : (updated =~ /^U/) ? "=i=u" : "=i"

    $dataarray << {
      'name'              => bundle['name'],
      'path'              => index.to_s,        # index of $dataarray to identify
      'bundleDescription' => desc,
      'searchpattern'     => "#{bundle['name']} #{desc} r=#{repo} #{updatedStr}",
      'repo'              => repo,
      'rev'               => Time.parse(bundle['revision']).strftime("%Y/%m/%d %H:%M:%S"),
      'updated'           => updated
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

  unless $firstrun
    $params['isBusy'] = true
    $params['progressText'] = "Parsing local bundles…"
    updateDIALOG
  end

  $localBundles  = { }
  
  # get deleted/disabled bundles from TM's plist
  $deletedCoreAndDisabledBundles = { }
  begin
    tmPlist = OSX::PropertyList::load(open("#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist"))
    begin
      $deletedCoreAndDisabledBundles['deleted'] = tmPlist['OakBundleManagerDeletedBundles']
    rescue
      $deletedCoreAndDisabledBundles['deleted'] = [ ]
    end
    begin
      $deletedCoreAndDisabledBundles['disabled'] = tmPlist['OakBundleManagerDisabledBundles']
    rescue
      $deletedCoreAndDisabledBundles['disabled'] = [ ]
    end
    tmPlist = { }
  rescue
    writeToLogFile("Could not read TextMate's plist")
    $deletedCoreAndDisabledBundles['disabled'] = [ ]
    $deletedCoreAndDisabledBundles['deleted']  = [ ]
  end

  $deletedCoreAndDisabledBundles['deleted']  = [ ] if $deletedCoreAndDisabledBundles['deleted'].nil?
  $deletedCoreAndDisabledBundles['disabled'] = [ ] if $deletedCoreAndDisabledBundles['disabled'].nil?

  # get the creation date of TextMate's binary to set it to each default bundle
  theCtimeOfDefaultBundle = File.new(TextMate::app_path).mtime.getutc

  # loop through all locally installed bundles

  local_bundle_paths.each do |path|
    next unless File.directory?(path)
    break if $close
    Dir["#{path}/*.tmbundle"].each do |b|
      begin
        break if $close
        plist = OSX::PropertyList::load(open("#{b}/info.plist"))
        unless plist['isDelta']
          
          # get ctime of local bundle folder for comparison 
          theCtime = (b =~ /Shared/) ? theCtimeOfDefaultBundle : File.new(b).ctime.getutc
          
          # check for svn / git repos ; if so take the last commit date
          scm = (File.directory?("#{b}/.svn")) ? "  (svn)" : (File.directory?("#{b}/.git")) ? "  (git)" : ""
          if scm =~ /svn/
            begin
              theCtime = Time.parse(%x{head -n10 '#{b}/.svn/entries' | tail -n1}).getutc
            rescue
              writeToLogFile("svn error for “#{b}”: #{$!}")
              scm += " probably not working"
              theCtime = File.new(b).ctime.getutc
            end
          elsif scm =~ /git/
            begin
              theCtime = Time.parse(File.read("|cd '#{b}'; git show | head -n3 | tail -n 1 | perl -pe 's/Date: +//;s/(.*?) (.*?) (.*?) (.*?) (.*?) (.*)/\1 \2 \3 \4\6 \5/'").chomp).getutc
            rescue
              writeToLogFile("git error for “#{b}”: #{$!}")
              scm += " probably not working"
              theCtime = File.new(b).ctime.getutc
            end
          end
          
          # check deleted/disabled status
          disabled = ""
          deleted  = ""
          unless $justUndeletedCoreAndEnabledBundles.include?(plist['uuid']) # it was just installed? then don't ask TM's plist
            disabled = " bundle disabled" if $deletedCoreAndDisabledBundles['disabled'].include?(plist['uuid'])
            deleted  = " default bundle deleted" if $deletedCoreAndDisabledBundles['deleted'].include?(plist['uuid'])
          end

          # update local bundle list; if bundles with the same uuid -> take the latest ctime for revision
          if $localBundles.has_key?(plist['uuid'])
            if Time.parse($localBundles[plist['uuid']]['rev']).getutc < theCtime
              $localBundles[plist['uuid']] = {'path' => b, 'name' => plist['name'], 'scm' => scm, 'rev' => theCtime.to_s, 'deleted' => deleted, 'disabled' => disabled }
            end
          else
            $localBundles[plist['uuid']] = {'path' => b, 'name' => plist['name'], 'scm' => scm, 'rev' => theCtime.to_s, 'deleted' => deleted, 'disabled' => disabled }
          end
          
        end
      rescue
        writeToLogFile("Error while parsing “#{b}”: #{$!}")
      end
    end
  end

  # clean array of just installed bundles
  $justUndeletedCoreAndEnabledBundles = [ ]
  
  unless $firstrun
    $params['isBusy'] = false
    updateDIALOG
  end
  
end

def refreshUpdatedStatus
  
  $params['isBusy'] = true
  $params['nocancel'] = true
  $params['progressText'] = "Parsing local bundles…"
  updateDIALOG
  
  buildLocalBundleList
  
  # loop through all shown bundles
  cnt = 0  # counter to link $dataaray and $bundleCache['bundles']
  $dataarray.each do |r|

    break if $close

    updated = ""

    cBundle = $bundleCache['bundles'][cnt]

    if r['repo'] == "P"
      $localBundles.each_value do |h|
        if h['name'] == r['name']
          updated = (Time.parse(cBundle['revision']).getutc > Time.parse(h['rev']).getutc) ? "U" : "✓"
          break
        end
      end
    else
      if $localBundles.has_key?(cBundle['uuid'])
        updated = (Time.parse(cBundle['revision']).getutc > Time.parse($localBundles[cBundle['uuid']]['rev']).getutc) ? "U" : "✓"
        updated += $localBundles[cBundle['uuid']]['scm'] + $localBundles[cBundle['uuid']]['deleted'] + $localBundles[cBundle['uuid']]['disabled']
      end
    end

    # set the bundle status and the search patterns
    r['searchpattern'].gsub!(/=[^ ]*$/, (updated.empty?) ? "" : (updated =~ /^U/) ? "=i=u" : "=i")
    r['updated'] = updated
    cnt += 1

  end

  # reset to current host filter
  $params['dataarray'] = case $params['bundleSelection']
    when "Official":    $dataarray.select {|v| v['repo'] == 'O'}
    when "Review":      $dataarray.select {|v| v['repo'] == 'R'}
    when "3rd Party":   $dataarray.select {|v| v['repo'] !~ /^O|R$/}
    else $dataarray
  end

  $params['isBusy'] = false
  $params['nocancel'] = false
  updateDIALOG

  # suppress the updating of the table to preserve the selection
  $params.delete('dataarray')

end

def killThreads
  begin
    $initThread.kill    unless $initThread.nil?
    $installThread.kill unless $installThread.nil?
    $infoThread.kill    unless $infoThread.nil?
    $refreshThread.kill unless $refreshThread.nil?
    $reloadThread.kill  unless $reloadThread.nil?
    $svnlogThread.kill  unless $svnlogThread.nil?
    $svndataThread.kill unless $svndataThread.nil?
  rescue
  end
end

def initLogFile
  File.open($logFile, "w") {}
end

def removeTempDir
  if File.directory?($tempDir)
    if $tempDir == "/tmp/TM_GetBundlesTEMP"
      %x{rm -r #{$tempDir} 1> /dev/null}
    else
      writeToLogFile("TempDir alert!")
    end
  end
end

def writeToLogFile(text, printTime=true)
  $logFileHandle.puts Time.now.strftime("\n%m/%d/%Y %H:%M:%S") + "\tTextMate[GetBundles]" if printTime
  $logFileHandle.puts text
  $logFileHandle.flush
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
  Open3.popen3("export LC_CTYPE=en_US.UTF-8;"+cmd) { |stdin, stdout, stderr|
    out << stdout.read
    err << stderr.read
  }
  writeToLogFile(out, false) if (!out.empty? && outToLog)
  unless err.empty?
    $errorcnt += 1
    writeToLogFile(err)
    return
  end
  return out
end

def installBundles(dlg)
  
  doUpdateSupportFolder if $updateSupportFolder

  return if $close

  $listsLoaded = false

  cnt = 0 # counter for installed bundles

  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = "Installing…"
  updateDIALOG

  items = dlg['returnArgument']
  items.each do |item|
    
    break if $close
    
    $errorcnt = 0

    # get the bundle data (from cache file)
    bundleData = $bundleCache['bundles'][item.to_i]
    name = bundleData['name']

    # check for versioning control to alert
    if $localBundles.has_key?(bundleData['uuid']) && ! $localBundles[bundleData['uuid']]['scm'].empty?
      hint = ""
      if $localBundles[bundleData['uuid']]['scm'] =~ /svn/
        doc = REXML::Document.new(File.read("|'#{$SVN}' info --xml '#{$localBundles[bundleData['uuid']]['path']}'"))
        localUrl = doc.root.elements['//info/entry/url'].text
        hint = "Please note that the svn checkout of “#{name}” was done by using an old URL.\nSee details in the “Info Window”." if localUrl =~ /macromates\.com/
      end
      next askDIALOG("It seems that the bundle “#{name}” has been already installed under versioning control #{$localBundles[bundleData['uuid']]['scm'].gsub(/ +/,'')}.","Please update that bundle manually or remove/rename it and use “GetBundles” to install.\n#{hint}", "OK", "")
    end
    
    cnt += 1 # counts the bundle to install

    # check for disabled bundles
    if $localBundles.has_key?(bundleData['uuid']) && ! $localBundles[bundleData['uuid']]['disabled'].empty?
      $justUndeletedCoreAndEnabledBundles << bundleData['uuid']
    end

    # check for deleted default bundle
    if $localBundles.has_key?(bundleData['uuid']) && ! $localBundles[bundleData['uuid']]['deleted'].empty?
      $justUndeletedCoreAndEnabledBundles << bundleData['uuid']
    end

    source = nil
    
    # look for a method to install
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
    zip_path = source['zip_path']

    break if $close

    writeToLogFile("Installing “#{name}”")
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
      when "tar"
        installTAR(name, path, zip_path)
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

  removeTempDir
  refreshUpdatedStatus if cnt > 0

  $listsLoaded = true
  
end

def installZIP(name, path, zip_path)

  removeTempDir
  FileUtils.mkdir_p $tempDir

  begin
    GBTimeout::timeout($timeout) do
      begin

        if path =~ /^http:\/\/github\.com/  # hosted on github ?
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.zip" "#{path}"; then
  if unzip --q "#{$tempDir}/archive.zip" -d "#{$tempDir}"; then
    rm "#{$tempDir}/archive.zip"
    mv "#{$tempDir}/"* "#{$tempDir}/#{name}.tmbundle"
  fi
fi
          }, false, true)

        elsif !zip_path.nil? and zip_path =~ /\.tmbundle$/
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.zip" "#{path}"; then
  if unzip --q "#{$tempDir}/archive.zip" -d "#{$tempDir}"; then
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
    writeToLogFile("Timeout error while installing “#{name}”") unless $close
    return
  end

  return if $close
  # install bundle if everything went fine
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0

end

def installTAR(name, path, zip_path)

  removeTempDir
  FileUtils.mkdir_p $tempDir

  begin
    GBTimeout::timeout($timeout) do
      begin

        if path =~ /^http:\/\/github\.com/  # hosted on github ?
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.tar" "#{path}"; then
  if tar -xf "#{$tempDir}/archive.tar" -C "#{$tempDir}"; then
    rm "#{$tempDir}/archive.tar"
    mv "#{$tempDir}/"* "#{$tempDir}/#{name}.tmbundle"
  fi
fi
          }, false, true)

        elsif !zip_path.nil? and zip_path =~ /\.tmbundle$/
          executeShell(%Q{
if curl -sSLo "#{$tempDir}/archive.zip" "#{path}"; then
  if tar -xf "#{$tempDir}/archive.zip" -D "#{$tempDir}"; then
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
    writeToLogFile("Timeout error while installing “#{name}”") unless $close
    return
  end

  return if $close
  # install bundle if everything went fine
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0

end


def installSVN(name, path)

  if $SVN.empty?
    $errorcnt += 1
    writeToLogFile("Could not install “#{name}”.")
    noSVNclientFound
    return
  end

  removeTempDir
  FileUtils.mkdir_p $tempDir

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
    writeToLogFile("Timeout error while installing “#{name}”") unless $close
    return
  end

  return if $close

  # install bundle if everything went fine
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0

end

def checkForSupportFolderUpdate

  $updateSupportFolder = true

  if File.directory?($supportFolder) and ! File.symlink?($supportFolder)
    writeTimedMessage(%Q{Warning:
Please note that you have already installed an update of TextMate's “Support Folder” in ‘#{$supportFolder}’.
This folder won't be touched by GetBundles' update!
GetBundles will always check out the latest version into ‘#{$supportFolderPristine}’.
To activate GetBundles' “Support Folder” simply rename or delete ‘#{$supportFolder}’ and run ‘Update “Support Folder”’.
Otherwise you have to update ‘#{$supportFolder}’ by yourself.},
  "Warning: Please check the Log!", 1)
  end

  localRev = nil
  trunkRev = nil

  if File.directory?("#{$supportFolderPristine}/.svn")
    
    # get svn info and compare last modified date
    begin
      localRev = Time.parse(%x{head -n10 '#{$supportFolderPristine}/.svn/entries' | tail -n1}).getutc
    rescue
      writeTimedMessage("Error while getting 'svn info' data of the “Support Folder”:\n#{$!}")
      return
    end
    
    # for safety reasons check always http://svn.textmate.org/trunk/Support/
    begin
      GBTimeout::timeout($timeout) do
        doc = REXML::Document.new(File.read("|'#{$SVN}' info --xml #{$bundleCache['SupportFolder']['url']}"))
        trunkRev = Time.parse(doc.root.elements['//info/entry/commit/date'].text).getutc
        $updateSupportFolder = (trunkRev > localRev) ? true : false
      end
    rescue
      writeTimedMessage("Error while getting current 'svn info' data of the “Support Folder” from trunk:\n#{$!}")
      return
    end

  end

  writeToLogFile("TextMate's “Support Folder” (#{$supportFolderPristine}) will be updated before you install a bundle automatically.") if $updateSupportFolder

end

def doUpdateSupportFolder

  if $SVN.empty?
    $errorcnt += 1
    writeToLogFile("Could not update the “Support Folder”.")
    noSVNclientFound
    return
  end

  path = $bundleCache['SupportFolder']['url']
  if path.nil?
    writeTimedMessage("No Support Folder URL found in cache file")
    return
  end

  folderCreated = false

  if File.directory?("#{$supportFolderPristine}/.svn") 
    doc = REXML::Document.new(File.read("|'#{$SVN}' info --xml '#{$supportFolderPristine}'"))
    supportURL = doc.root.elements['//info/entry/url'].text

    if supportURL =~ /^http:\/\/macromates/  # relocate repo if old url
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
      writeTimedMessage("Error while creating “Support Folder”:\n#{$!}")
      return
    end

    folderCreated = true

  end
  
  # check for /Lib/AS/TM
  FileUtils.mkdir_p($asFolder) unless File.directory?($asFolder)
  
  # create symlink if no /Lib/AS/TM/Support
  begin
    File.symlink($supportFolderPristine, $supportFolder) unless File.directory?($supportFolder)
  rescue
    writeTimedMessage("Error while creating a symbolic link:\n#{$!}")
    return
  end
  
  $params['isBusy'] = true
  $params['nocancel'] = true
  $params['progressText'] = "Updating TextMate's “Support Folder”…"
  $params['progressIsIndeterminate'] = true
  updateDIALOG
  
  # do a svn co/up
  begin
    GBTimeout::timeout(60) do
      if File.directory?($supportFolderPristine) && folderCreated
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolderPristine.gsub('/Support','')}';
'#{$SVN}' co '#{path}'
        }, true, true)
        return if $errorcnt > 0

      else

        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolderPristine}';
'#{$SVN}' up
        }, true, true)
        return if $errorcnt > 0

      end
    end
  rescue GBTimeout::Error
    $errorcnt += 1
    FileUtils.rm_rf($supportFolderPristine) # for safety reasons to be able to reinit it
    writeTimedMessage("Timeout while updating TextMate's “Support Folder”. Please check the folder ‘#{$supportFolder}’!\n If problems occur remove ‘#{$supportFolder}’ manully and retry it.")
  end
  
  checkForSupportFolderUpdate
  
  $params['supportFolderCheck'] = 0
  $params['isBusy'] = false
  $params['nocancel'] = false
  $params['progressText'] = ""
  updateDIALOG
  
end

def filterBundleList
  
  $params['isBusy']           = true
  $params['bundleSelection']  = $dialogResult['bundleSelection']
  $params['progressText']     = "Filtering bundle list…"
  updateDIALOG
  
  b = case $dialogResult['bundleSelection']
    when "Review":      $dataarray.select {|v| v['repo'] == 'R'}
    when "Official":    $dataarray.select {|v| v['repo'] == 'O'}
    when "3rd Party":   $dataarray.select {|v| v['repo'] !~ /^O|R$/}
    else $dataarray
  end
  
  $lastBundleFilterSelection = $dialogResult['bundleSelection']
  
  $params['numberOfBundles']          = "#{b.size} in total found"
  $params['dataarray']                = b
  $params['progressIsIndeterminate']  = true
  $params['isBusy']                   = false
  updateDIALOG
  
end

def checkUniversalAccess
  ui = %x{osascript -e 'tell app "System Events" to set isUIScriptingEnabled to UI elements enabled'}
  if ui =~ /^false/
    if askDIALOG("AppleScript's “UI scripting” is not enabled. Getbundles needs it to perform “Show Help Window”, “Open Bundle Editor”, and “to activate Getbundles if it's already open”.", "Do you want to open “System Preferences” to enable “Enable access for assistive devices”?", "Yes", "No") == 0
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
  'progressText'            => "Connecting Bundle Server…"
}

$firstrun = true

initLogFile
$logFileHandle = File.open($logFile, "a")

orderOutDIALOG
checkUniversalAccess

# init DIALOG
$initThread = Thread.new do
  begin
    getBundleLists
    checkForSupportFolderUpdate
    $firstrun = false
  rescue
    writeTimedMessage("Error while initialization:\n#{$!}")
  end
end

# set svn client
$SVN = ENV['TM_SVN'] || ((%x{type -p svn}.strip!.nil?) ? "" : "svn")

# main loop
while $run do

  getResultFromDIALOG
  # writeToLogFile($dialogResult.inspect())

  if $dialogResult.has_key?('returnArgument')
    case $dialogResult['returnArgument']
      when 'helpButtonIsPressed':   helpDIALOG
      when 'cancelButtonIsPressed': 
        $close = true
        $params['isBusy'] = false
        $firstrun = false
        updateDIALOG
      when 'infoButtonIsPressed':   $infoThread = Thread.new { infoDIALOG($dialogResult) }
      else # install bundle(s)
        if $params['isBusy'] == false
          if $dialogResult['returnArgument'].size > 10
            if askDIALOG("Do you really want to install %d bundles?" % $dialogResult['paths'].size ,"") == 1
              $installThread = Thread.new { installBundles($dialogResult) }
            end
          else
            $installThread = Thread.new { installBundles($dialogResult) }
          end
        else
          writeToLogFile("User interaction was ignored. GetBundles is busy…\n#{$params['progressText']}")
        end
      end
  elsif $dialogResult['openBundleEditor'] == 1
    %x{osascript -e 'tell app "System Events" to keystroke "b" using {control down, option down, command down}' }
    $params['openBundleEditor'] = 0 # hide checkmark in menu
    updateDIALOG

  elsif $dialogResult['refreshBundleList'] == 1
    $refreshThread = Thread.new do
      refreshUpdatedStatus
      $params['refreshBundleList'] = 0 # hide checkmark in menu
      updateDIALOG
    end

  elsif $dialogResult['rescanBundleList'] == 1
    $reloadThread = Thread.new do
      begin
        getBundleLists
        checkForSupportFolderUpdate
      rescue
        writeTimedMessage("Error while initialization:\n#{$!}", "An error occurred. Please check the Log!")
        $run = false
        exit 1
      end
    end

  elsif $dialogResult['bundleSelection'] && $lastBundleFilterSelection != $dialogResult['bundleSelection']
    filterBundleList

  elsif $dialogResult['supportFolderCheck']
    if $params['isBusy'] == false
      if $dialogResult['supportFolderCheck'] == 1
        doUpdateSupportFolder
        checkForSupportFolderUpdate
      end
      $params['supportFolderCheck'] = 0 # hide checkmark in menu
      updateDIALOG
    else
      writeToLogFile("User interaction was ignored. GetBundles is busy…\n#{$params['progressText']}")
    end

  else ###### closing the window
    $close = true
    unless $listsLoaded  # while fetching something from the net wait for aborting of threads
      $params['isBusy'] = true
      $params['progressText'] = 'Closing…'
      $params['progressIsIndeterminate'] = true
      updateDIALOG
      begin
        killThreads
      rescue
        break
      end
    end
    break
  end

  $dialogResult = { }

end

closeDIALOG
$logFileHandle.close