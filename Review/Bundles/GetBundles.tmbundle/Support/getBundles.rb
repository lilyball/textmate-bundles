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
require "time"
require "rexml/document"

include ERB::Util

$DIALOG           = e_sh ENV['DIALOG']
$NIB              = `uname -r`.split('.')[0].to_i > 8 ? 'BundlesTree' : 'BundlesTreeTiger'
$isDIALOG2        = false # ! $DIALOG.match(/2$/).nil?

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
$timeout          = 30
# global thread vars
$x0=$x1=$x2=$x3=$x4 = nil
# bundle data hash containing data.json.gz 
$bundleCache = { }
# available installation modi
$availableModi = ["svn", "zip"]
# URL to the bundle server's cache file
$bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json.gz"
# $bundleServerFile = "http://bibiko.textmate.org/bundleserver/data.json"

# TextMate's Support Folder
$supportFolder = "/Library/Application Support/TextMate"
# should the Support Folder updated in beforehand?
$updateSupportFolder = true
# last bundle filter selection
$lastBundleFilterSelection = "All"


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
  # return unless dlg.has_key?('path')
  # info = { }
  # plist = { }
  # readme = ""
  # css = ""
  # data = ""
  # removeTempDir
  # FileUtils.mkdir_p $tempDir
  # bundle = $bundleCache['bundles'][dlg['path'].first.to_i]
  # $params['isBusy'] = true
  # $params['progressIsIndeterminate'] = true
  # $params['progressText'] = "Fetching information…"
  # updateDIALOG
  # return if $close
  # mode = case bundle
  #   when /github\.com/: "git"
  #   when 
  # end
  # if mode == 'git'
  #   namehasdot = false
  #   searchPath = path.gsub(/.*?com\/(.*?)\/(.*?)\/.*/, '\1-\2')
  #   url = path.gsub(/zipball\/master/, '')
  #   if ! url.match(/.*?com\/(.*?)\/(.*?)\..*/)
  #     begin
  #       GBTimeout::timeout($timeout) do
  #         d = YAML.load(open("http://github.com/api/v1/yaml/search/#{searchPath}"))
  #         if d.has_key?('repositories') and d['repositories'].size > 0
  #           info = d['repositories'].first
  #         else
  #           # if .../search/foo-bar-foo1 fails try .../search/foo+bar+foo1
  #           d = YAML.load(open("http://github.com/api/v1/yaml/search/#{searchPath.gsub('-','+')}"))
  #           if d.has_key?('repositories') and d['repositories'].size > 0
  #             info = d['repositories'].first
  #           # if .../search/foo+bar+foo1 fails init an empty dict
  #           else
  #             info = {}
  #           end
  #         end
  #       end
  #     rescue GBTimeout::Error
  #       $params['isBusy'] = false
  #       updateDIALOG
  #       removeTempDir
  #       writeToLogFile("Timeout error while fetching information") if ! $close
  #       return
  #     end
  #   else
  #     namehasdot = true
  #     info = {}
  #     info['name'] = ""
  #     info['description'] = ""
  #     info['owner'] = url.gsub(/.*?com\/(.*?)\/.*\//,'\1')
  #   end
  #   return if $close
  #   begin
  #     GBTimeout::timeout($timeout) do
  #       data = Net::HTTP.get( URI.parse("#{url}tree/master") )
  #     end
  #   rescue GBTimeout::Error
  #     $params['isBusy'] = false
  #     updateDIALOG
  #     removeTempDir
  #     writeToLogFile("Timeout error while fetching information") if ! $close
  #     return
  #   end
  #   return if $close
  #   begin
  #     GBTimeout::timeout($timeout) do
  #       begin
  #         plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{url}tree/master/info.plist?raw=true")).gsub(/.*?(<plist.*?<\/plist>)/m,'\1'))
  #       rescue
  #         writeToLogFile($!)
  #       end
  #     end
  #   rescue GBTimeout::Error
  #     $params['isBusy'] = false
  #     updateDIALOG
  #     removeTempDir
  #     writeToLogFile("Timeout error while fetching information") if ! $close
  #     return
  #   end
  #   return if $close
  #   plist['name'] = info['path'] if plist['name'].nil?
  #   plist['description'] = "" if plist['description'].nil?
  #   plist['contactName'] = "" if plist['contactName'].nil?
  #   plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?
  #   if ! data.index('<div id="readme">').nil?
  #     readme = data.gsub( /.*?(<div id="readme">.*?)<div class="push">.*/m, '\1').gsub(/<span class="name">README.*?<\/span>/, '')
  #   else
  #     readme = "<br /><i>No README found</i><br />"
  #   end
  #   css = data.gsub( /.*?(<link href="\/stylesheets\/.*?\/>).*/m, '\1')
  #   data = ""
  #   return if $close
  #   gitbugreport = (namehasdot) ? "&nbsp;&nbsp;&nbsp;<i><small>incomplete caused by the dot in project name (known GitHub bug)</small></i><br>" : ""
  #   File.open("#{$tempDir}/info.html", "w") do |io|
  #     io << <<-HTML01
  #       <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
  #       <base href='http://github.com'>
  #       <head>
  #       <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
  #       #{css}
  #       </head>
  #       <body><div id='main'><div class='site'>
  #       <font color='blue' size=12pt>#{plist['name']}</font><br /><br />
  #       <h3><u>git Information:</u></h3>#{gitbugreport}
  #       <b>Description:</b><br />&nbsp;#{info['description']}<br />
  #       <b>Name:</b><br />&nbsp;#{plist['name']}<br />
  #       <b>URL:</b><br />&nbsp;<a href='#{url}'>#{url}</a><br />
  #       <b>Owner:</b><br />&nbsp;<a href='http://github.com/#{info['owner']}'>#{info['owner']}</a><br />
  #       <b>Watchers:</b><br />&nbsp;#{info['watchers']}<br />
  #       <b>Private:</b><br />&nbsp;#{info['private']}<br />
  #       <b>Forks:</b><br />&nbsp;#{info['forks']}<br />
  #     HTML01
  #     if ! plist['contactName'].empty? or ! plist['contactEmailRot13'].empty? or ! plist['description'].empty?
  #       io << <<-HTML02
  #       <br /><br />
  #       <h3><u>Bundle Information (info.plist):</u></h3>
  #       #{plist['description']}<br /><br />
  #       <b>Contact Name:</b><br />&nbsp;<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a><br />
  #       HTML02
  #     end
  #     io << <<-HTML03
  #       <br /><br />
  #       <h2><u>README:</u></h2><br />
  #       #{readme}</div></div>
  #       </body></html>
  #     HTML03
  #   end
  # elsif mode == 'svn'
  #   if $SVN.length > 0
  #     begin
  #       GBTimeout::timeout($timeout) do
  #         data = executeShell("export LC_CTYPE=en_US.UTF-8;'#{$SVN}' info '#{path}'")
  #         if $errorcnt > 0
  #           removeTempDir
  #           $params['isBusy'] = false
  #           updateDIALOG
  #           return
  #         end
  #       end
  #     rescue GBTimeout::Error
  #       $params['isBusy'] = false
  #       updateDIALOG
  #       removeTempDir
  #       writeToLogFile("Timeout error while fetching information") if ! $close
  #       return
  #     end
  #     return if $close
  #     data.each_line do |l|
  #       info[l.split(': ').first] = l.split(': ').last
  #     end
  #     begin
  #       GBTimeout::timeout($timeout) do
  #         begin
  #           plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse("#{path}/info.plist")))
  #         rescue
  #           begin
  #             plist = OSX::PropertyList::load(Net::HTTP.get(URI.parse(URI.escape("#{thePath}/info.plist"))))
  #           rescue
  #             plist = OSX::PropertyList::load("{description='?';}")
  #           end
  #         end
  #       end
  #     rescue GBTimeout::Error
  #       $params['isBusy'] = false
  #       updateDIALOG
  #       removeTempDir
  #       writeToLogFile("Timeout error while fetching information") if ! $close
  #       return
  #     end
  #     return if $close
  #     plist['name'] = info['path'] if plist['name'].nil?
  #     plist['description'] = "" if plist['description'].nil?
  #     plist['contactName'] = "" if plist['contactName'].nil?
  #     plist['contactEmailRot13'] = "" if plist['contactEmailRot13'].nil?
  #     File.open("#{$tempDir}/info.html", "w") do |io|
  #       io << <<-HTML11
  #         <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
  #         <head>
  #         <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
  #         </head>
  #         <body style='font-family:Lucida Grande'>
  #       HTML11
  #       if plist['description'].match(/<hr[^>]*\/>/)
  #         io << "#{plist['description'].gsub(/.*?<hr[^>]*\/>/,'')}<br /><br />"
  #       else
  #         io << "<font color='blue' size=12pt>#{plist['name']}</font><br /><br />"
  #         io << "#{plist['description']}<br /><br />"
  #       end
  #       io << <<-HTML12
  #         <b>URL:</b><br />&nbsp;<a href='#{info['URL']}'>#{info['URL']}</a><br />
  #         <b>Contact Name:</b><br />&nbsp;<a href='mailto:#{plist['contactEmailRot13'].tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")}'>#{plist['contactName']}</a><br />
  #         <b>Revision:</b><br />&nbsp;#{info['Revision']}<br />
  #         <b>Last Changed Date:</b><br />&nbsp;#{info['Last Changed Date']}<br />
  #         <b>Last Changed Author:</b><br />&nbsp;#{info['Last Changed Author']}<br />
  #         <b>Last Changed Rev:</b><br />&nbsp;#{info['Last Changed Rev']}<br />
  #         </body></html>
  #       HTML12
  #     end
  #   else          #### no svn client found
  #     noSVNclientFound
  #   end
  # else
  #   return
  # end
  # $params['isBusy'] = false
  # updateDIALOG
  # $infoTokenOld = $infoToken
  # if $close
  #   removeTempDir
  #   return
  # end
  # if $isDIALOG2
  #   $infoToken = %x{#{$DIALOG} window create -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}" help }
  # else
  #   $infoToken = %x{#{$DIALOG} -a help -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"}
  # end
  # if ! $infoTokenOld.nil?
  #   if $isDIALOG2
  #     %x{#{$DIALOG} window close #{$infoTokenOld}}
  #   else
  #     %x{#{$DIALOG} -x#{$infoTokenOld}}
  #   end
  # end
  # removeTempDir
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
      # download data.json.gu from textmate.org
      data_file = "#{$tempDir}/data.json.gz"
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
  $bundleCache['bundles'].sort!{|a,b| (n = a['name'] <=> b['name']).zero? ? a['status'] <=> b['status'] : n}
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
    $dataarray << {
      'name' => bundle['name'],
      'path' => index.to_s,
      'bundleDescription' => desc,
      'searchpattern' => "#{bundle['name']} #{desc} r=#{repo}",
      'repo' => repo,
      'rev' => Time.parse(bundle['revision']).strftime("%Y/%m/%d %H:%M:%S"),
      'updated' => ""
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

def checkForSupportFolderUpdate
  val = 1
  if File.directory?("#{$supportFolder}/Support")
    # get svn info
    doc = REXML::Document.new(File.read("|svn info --xml '#{$supportFolder}/Support'"))
    localRev = Time.parse(doc.root.elements['//info/entry/commit/date'].text).getutc
    cacheRev = Time.parse($bundleCache['SupportFolder']['revision']).getutc
    val = (cacheRev > localRev) ? 1 : 0
    $updateSupportFolder = (cacheRev > localRev) ? true : false
  end
  $params['supportFolderCheck'] = val
  updateDIALOG
  writeToLogFile("It's recommended to update TextMate's “Support Folder”.") if val == 1
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
    writeToLogFile("Timeout error while installing %s" % name) if ! $close
    return
  end
  return if $close
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0
  removeTempDir
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
'#{$SVN}' co --no-auth-cache --non-interactive '#{path}' '#{name}.tmbundle'
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
        $params['progressText'] = 'Error while installing! Please check the Log.'
        updateDIALOG
        sleep(3)
        $errorcnt = 0
        break
      end
      writeToLogFile("Installation of “%s” done." % name) if mode != 'skip' and $errorcnt == 0
    end
    # $params['progressText'] = "Reload Bundles…"
    # updateDIALOG
    # # reload bundles only if TM is running
    # %x{osascript -e 'tell app "TextMate" to reload bundles'} if ! getInstallPathFor("App Bundles", false).empty?
    # # if $errorcnt > 0
    # #   $params['progressText'] = 'General error while installing! Please check the Activity Log.'
    # #   updateDIALOG
    # #   sleep(3)
    # # end
    $params['isBusy'] = false
    $params['progressText'] = ""
    updateDIALOG
  end
  # $params['nocancel'] = false
  # updateDIALOG
  removeTempDir
  $listsLoaded = true
end

def doUpdateSupportFolder
  path = $bundleCache['SupportFolder']['url']
  if path.nil?
    writeTimedMessage("No Support Folder URL found in cache file")
    return
  end
  unless File.directory?($supportFolder)
    $errorcnt += 1
    writeTimedMessage("‘#{$supportFolder}’ not found.")
    return
  end
  if $SVN.empty?
    $errorcnt += 1
    noSVNclientFound
    return
  end
  doc = REXML::Document.new(File.read("|svn info --xml '#{$supportFolder}/Support'"))
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
  $params['isBusy'] = true
  $params['progressText'] = "Updating TextMate's “Support Folder”…"
  $params['progressIsIndeterminate'] = true
  updateDIALOG
  begin
    GBTimeout::timeout(120) do
      if File.directory?("#{$supportFolder}/Support")
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolder}/Support';
'#{$SVN}' up
        }, true, true)
        return if $errorcnt > 0
      else
        executeShell(%Q{
export LC_CTYPE=en_US.UTF-8;
cd '#{$supportFolder}';
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

def writeTimedMessage(logtext, displaytext="An error occurred. Please check the Log.", sleepFor=2)
  return if $close
  writeToLogFile(logtext)
  $params['isBusy'] = true
  $params['progressText'] = displaytext
  updateDIALOG
  sleep(sleepFor)
  $params['isBusy'] = false
  $params['rescanBundleList'] = 0
  updateDIALOG
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
  'supportFolderCheck'      => 1,
}

initLogFile
orderOutDIALOG

$x1 = Thread.new do
  begin
    getBundleLists
    checkForSupportFolderUpdate
  rescue
    writeTimedMessage("Error while connecting Bundle Server:\n#{$!}", "An error occurred. Please check the Log!")
  end
end

$SVN = ""
if ! %x{type -p svn}.strip!().nil?
  $SVN = "svn"
end
if ENV.has_key?('TM_SVN')
  $SVN = ENV['TM_SVN']
end

while $run do
  getResultFromDIALOG
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
