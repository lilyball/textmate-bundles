#!/usr/bin/env ruby -wKU

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/osx/plist'
require SUPPORT + '/lib/textmate.rb'
require "fileutils"
require "yaml"
require "open3"
require "time"
require "rexml/document"
# require "Benchmark"

require File.dirname(__FILE__) + '/lib/globalVariables'
require File.dirname(__FILE__) + '/lib/infoWindow'
require File.dirname(__FILE__) + '/lib/installBundles'

def local_bundle_paths
  {
   'default'         => TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Bundles",
   'System Lib'      => '/Library/Application Support/TextMate/Bundles',
   'Users Lib'       => "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
   'System Pristine' => '/Library/Application Support/TextMate/Pristine Copy/Bundles',
   'Users Pristine'  => "#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",
  }
end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
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
        unless $close
          x.raise exception, "execution expired" if x.alive?
        else
          x.kill
        end
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

def secToStr(t1, t2)
  d = t1.getutc - t2.getutc
  if d>=86400
    return "#{(d/86400).round.to_s} day#{((d/86400).round <= 1) ? "" : "s"} old"
  elsif d<86400 && d>=3600
    return "#{(d/3600).round.to_s} hour#{((d/3600).round <= 1) ? "" : "s"} old"
  elsif d<3600 && d>=60
    return "#{(d/60).round.to_s} minute#{((d/60).round <= 1) ? "" : "s"} old"
  else
    return "#{d.round.to_s} second#{(d.round <= 1) ? "" : "s"} old"
  end
  return ""
end

def orderOutDIALOG

  $params['nocancel'] = true

  if $isDIALOG2
    $token = %x{"$DIALOG" nib --load #{e_sh $NIB} --model #{e_sh $params.to_plist}}
  else
    $token = %x{"$DIALOG" -a #{e_sh $NIB} -p #{e_sh $params.to_plist}}
  end

  writeToLogFile("GetBundles – version 1.2 – Hans-Jörg Bibiko - bibiko@eva.mpg.de")
  writeToLogFile("GetBundles' DIALOG runs at token #{$token}")
  $params['nocancel'] = false
  updateDIALOG

end

def closeDIALOG

  list = ""
  # close all DIALOGs containing 'GetBundles' in their titles (main, info)
  if $isDIALOG2
    %x{"$DIALOG" nib --dispose #{$token}}
    list = %x{"$DIALOG" nib --list | egrep 'GetBundles'}
    list.each_line do |l|
      t = l.split(' ').first
      %x{"$DIALOG" nib --dispose #{t}}
    end
  else
    %x{"$DIALOG" -x#{$token}}
    list = %x{"$DIALOG" -l | egrep 'GetBundles'}
    list.each_line do |l|
      t = l.split(' ').first
      %x{"$DIALOG" -x#{t}}
    end
  end

  removeTempDir

end

def updateDIALOG

  $params['logPath'] = open($logFilePath,"r").read

  if $isDIALOG2
    a={}
    a['model']=$params
    open("|'#{ENV['DIALOG']}' nib --update #{$token}", "w") { |io| io.write a.to_plist }
  else
    open("|'#{ENV['DIALOG']}' -t#{$token}", "w") { |io| io.write $params.to_plist }
  end

end

def getResultFromDIALOG

  resStr = ""
  if $isDIALOG2
    resStr = %x{"$DIALOG" nib --wait #{$token} }
  else
    resStr = %x{"$DIALOG" -w#{$token}}
  end

  $close = false

  begin
    if $isDIALOG2
      a = OSX::PropertyList.load(resStr)
      $dialogResult = a['eventInfo'] if a['eventInfo']
      $dialogResult.merge!(a['model']) if a['model']
    else
      $dialogResult = OSX::PropertyList.load(resStr)
    end
  rescue
    writeToLogFile("Fatal error while retrieving data from DIALOG.")
    closeDIALOG
    $run = false
    exit 1
  end

end

def helpDIALOG
  # err = %x{open "txmt://open?"; osascript -e 'tell application "TextMate" to activate' -e 'tell application "System Events" to tell process "TextMate" to tell menu bar 1 to tell menu bar item "Bundles" to tell menu "Bundles" to tell menu item "GetBundles" to tell menu "GetBundles" to click menu item "Help"' 2>&1}
  err = %x{
open "txmt://open?";
cat <<-AS | iconv -f UTF-8 -t MACROMAN | osascript -- 2>&1 1>/dev/null
tell application "TextMate" to activate
tell application "System Events" to tell process "TextMate" to tell menu bar 1 to tell menu bar item "Bundles" to tell menu "Bundles" to tell menu item "GetBundles" to tell menu "GetBundles" to click menu item "Help"
tell application "System Events" to tell process "TextMate" to tell menu bar 1 to tell menu bar item "Window" to tell menu "Window" to click menu item "TextMate — GetBundles" 
delay 0.5
tell application "System Events" to tell process "TextMate" to tell menu bar 1 to tell menu bar item "Window" to tell menu "Window" to click menu item "Get Bundles — Help" 
AS
  }
  writeToLogFile(err) if err.match(/error/)
end

def askDIALOG(msg, text, btn1="No", btn2="Yes", style="informational")

  msg.gsub!("'","’")
  text.gsub!("'","’")

  resStr = 0

  if $isDIALOG2
    resStr = %x{"$DIALOG" alert --alertStyle #{style} --body "#{text}" --title "#{msg}" --button1 "#{btn1}" --button2 "#{btn2}"}
  else
    resStr = %x{"$DIALOG" -e -p '{messageTitle="#{msg}";alertStyle=#{style};informativeText="#{text}";buttonTitles=("#{btn1}","#{btn2}");}'}
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

def getRepoAbbrev(aBundleDict)
  repo = case aBundleDict['status']
    when "Official":      "Official"
    when "Under Review":  "Review"
    else "3"
  end
  if repo == "3" && aBundleDict.has_key?('url')
    repo = case aBundleDict['url']
      when /github\.com/: "Github"
      else "Private"
    end
  end
  return repo
end

def checkSources
  # check the sources for each installed bundle if bundle is listed in the bundle cache
  mustBeResolved = [ ]
  
  # reset source if only one source available to get rid of relocating bundles (e.g. from Review to Official)
  $localBundles.each do |uuid, bundle|
    if $numberOfBundleSources[uuid] == 1
      if bundle['scm'] =~ /git/ # under git control
        $bundleSources[uuid].each do |g|
            g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "git" }
        end
      elsif $bundleSources[uuid].first['sources'].size > 1 # not under git control but from github.com
        $bundleSources[uuid].each do |g|
            g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "tar" }
        end
      else
        $gbPlist['bundleSources'][uuid] = $bundleSources[uuid].first['sources'].first['url']
      end
    end
  end

  $localBundles.each do |uuid, bundle|
    if !$gbPlist['bundleSources'].has_key?(uuid) && $bundleSources.has_key?(uuid)
      
      if $numberOfBundleSources[uuid] == 1 || bundle['location'] == 'default'
        if bundle['scm'] =~ /git/ # under git control
          $bundleSources[uuid].each do |g|
              g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "git" }
          end
        elsif $bundleSources[uuid].first['sources'].size > 1 # not under git control but from github.com
          $bundleSources[uuid].each do |g|
              g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "tar" }
          end
        else
          $gbPlist['bundleSources'][uuid] = $bundleSources[uuid].first['sources'].first['url']
        end
      
      else # try to identify the bundle via its infoMD5
        found = false
        uniqInfoMD5 = []
        md5Cnt = 0
        $bundleSources[uuid].each {|b| uniqInfoMD5 << b['infoMD5']; md5Cnt += 1}
        if uniqInfoMD5.uniq.size == md5Cnt
          $bundleSources[uuid].each do |b|
            if b['infoMD5'] == bundle['infoMD5']
              if b['sources'].size == 1
                if bundle['scm'] =~ /git/ # under git control
                  $bundleSources[uuid].each do |g|
                      g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "git" }
                  end
                elsif $bundleSources[uuid].first['sources'].size > 1 # not under git control but from github.com
                  $bundleSources[uuid].each do |g|
                      g['sources'].each { |t| $gbPlist['bundleSources'][uuid] = t['url'] if t['method'] == "tar" }
                  end
                else
                  $gbPlist['bundleSources'][uuid] = $bundleSources[uuid].first['sources'].first['url']
                end
              else
                b['sources'].each do |s|
                  if s['url'] =~ /tarball/
                    $gbPlist['bundleSources'][uuid] = s['url']
                    break
                  end
                end
              end
              found = true
              p "Source of the bundle “#{bundle['name']}” was set by identifying the MD5 value of ‘info.plist’."
              break
            end
          end
        end
      
        unless found || ENV['TM_GETBUNDLES_SKIP_RESOLVE_SOURCES']
          urls = [ ]
          $bundleSources[uuid].each do |b|
            if b['sources'].size == 1
              urls << b['sources'].first['url']
            else
              b['sources'].each { |t| urls << t['url'] if t['url'] =~ /tarball/ }
            end
          end
          urls << 'unknown'
          mustBeResolved << { 'uuid' => uuid, 'name' => bundle['name'], 'urls' => urls, 'selectedUrl' => urls.last }
        end
      end
    end
  end
  if mustBeResolved.size > 0
    mustBeResolved.sort! {|a,b| a['name'].downcase <=> b['name'].downcase}
    pl = (mustBeResolved.size > 1) ? "s" : ""
    parameters = {
      'title'   => 'GetBundles – Resolve Bundle Sources',
      'prompt'  => "Please specify the source#{pl} of the following bundle#{pl}:",
      'items'   => mustBeResolved,
    }
    res = nil
    begin
      if $isDIALOG2
        tk = %x{"$DIALOG" nib --load ResolveSources --model #{e_sh parameters.to_plist}}
        res = OSX::PropertyList.load(%x{"$DIALOG" nib --wait #{tk}})['eventInfo']
        %x{"$DIALOG" nib --dispose #{tk}}
      else
        res = OSX::PropertyList.load(%x{"$DIALOG" -m ResolveSources -p #{e_sh parameters.to_plist}})['result']
      end
    rescue
      writeToLogFile("Error while retrieving data from “Resolve Sources” dialog\n#{$!}")
    end
    unless res.nil?
      res['returnArgument'].each do |s|
        $gbPlist['bundleSources'][s['uuid']] = s['selectedUrl']
      end
      writeGbPlist
    end
  end


  # delete uuids in gbPlist if not installed
  $gbPlist['bundleSources'].delete_if {|k,v| ! $localBundles.has_key?(k)}
  writeGbPlist
end

def getBundleLists

  # only to speed up the init process
  $locBundlesThread = Thread.new { buildLocalBundleList }
  
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
      'dataarray'               => [ ],
    }
    updateDIALOG
  end
  
  begin
    GBTimeout::timeout($timeout) do
      
      # read data file from bundle server
      begin
        $bundleCache = YAML.load(File.read("|curl -sSL #{$bundleServerFile} | gzip -d"))
      rescue
        writeTimedMessage("Error: #{$!} while parsing the Bundle Server file")
      end
      
      # get nicknames from textmte.org
      nicks = nil
      begin
        nicks = File.read("|curl -sSL --compressed #{$nickNamesFile}")
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
  $bundleCache['bundles'].sort!{|a,b| (n = a['name'].downcase <=> b['name'].downcase).zero? ? a['status'].reverse <=> b['status'].reverse : n}

  # wait for parsing local bundles
  $params['isBusy'] = true
  $params['progressText'] = "Parsing local bundles…"
  updateDIALOG
  begin
    GBTimeout::timeout(15) do
      $locBundlesThread.join
    end
  rescue GBTimeout::Error
    writeToLogFile("Timeout while parsing local bundles") unless $close
    begin
      $locBundlesThread.kill unless $locBundlesThread.nil?
    rescue
    end
  end

  # build hash of uuid and the number of different sources in bundle cache and check whether bundle can be distuished by their infoMD5
  $numberOfBundleSources = { }
  $bundleSources = { }
  $bundleCache['bundles'].each do |b|
    if $numberOfBundleSources.has_key?(b['uuid'])
      $numberOfBundleSources[b['uuid']] += 1
    else
      $numberOfBundleSources[b['uuid']] = 1
    end
    if $bundleSources.has_key?(b['uuid'])
      $bundleSources[b['uuid']] << {'infoMD5' => b['infoMD5'], 'sources' => b['source']}
    else
      $bundleSources[b['uuid']] = [ ]
      $bundleSources[b['uuid']] << {'infoMD5' => b['infoMD5'], 'sources' => b['source']}
    end
  end

  checkSources

  # build $dataarray for NIB
  index = 0
  colorCnt = 0
  colorFlag = false
  lastColorFlag = false
  $bundleCache['bundles'].each do |bundle|

    break if $close

    author = (bundle['contact'].empty?) ? "" : " (by #{bundle['contact']})"
    nameColor = '#000000'
    if (index+1) < $bundleCache['bundles'].size
      colorFlag = ($bundleCache['bundles'][(index+1)]['uuid'] == bundle['uuid']) ? true : false
      if lastColorFlag || colorFlag
        nameColor = $bundleColors[(colorCnt%2)]
        colorCnt += 1 unless colorFlag
      else
        nameColor =  '#000000'
      end
      lastColorFlag = colorFlag
    end


    # show only first part of description if description is subdivided by <hr>
    desc = strip_html(bundle['description'].gsub(/(?m)<hr[^>]*?\/>.*/,'').gsub(/\n/, ' ') + author)

    repo = getRepoAbbrev(bundle)
    
    updatedStr,status,deleteButton,deleteButtonEnabled,locCom,canBeOpened,deleteButtonLabel,nameBold = getLocalStatus(bundle)
    if nameColor != '#000000'
      locCom += "  date: " + Time.parse(bundle['revision']).getutc.strftime("%y-%m-%d %H:%M")
    end
    # set searchpattern
    updatedStr = (status.empty?) ? "" : (status =~ /^O/) ? "=i" : "=i=u"

    $dataarray << {
      'name'              => bundle['name'],
      'path'              => index.to_s,        # index of $dataarray to identify
      'bundleDescription' => desc,
      'searchpattern'     => "#{bundle['name']} #{desc} r=#{repo} #{updatedStr}",
      'source'            => repo,
      'uuid'              => bundle['uuid'],
      'status'            => status,
      'locCom'            => locCom.strip.gsub(/ {2,}/,' ┋ '),
      'deleteButtonEnabled'      => deleteButtonEnabled,
      'deleteButtonLabel' => deleteButtonLabel,
      'deleteButton'      => deleteButton,
      'category'          => "",
      'nameColor'         => nameColor,
      'nameBold'          => nameBold,
      'canBeOpened'       => canBeOpened,
      'deleteButtonTooltip' => "#{deleteButtonLabel} “#{bundle['name']}”"

    }
    $deleteBundleOrgStatus[bundle['uuid']] = deleteButton
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

def initGetBundlePlist
  
  # each update of getBundles.rb deletes the old pref file
  if File.exist?($gbPlistPath) && File.new($gbPlistPath).ctime.getutc <= File.new(__FILE__).ctime.getutc
      begin
        FileUtils.rm_f($gbPlistPath)
        p "GetBundles was updated. The preference file will be re-initialized."
      rescue
        askDIALOG("Attention","The preference file ‘#{$gbPlistPath}’ couldn't be deleted. Please do it manually because “GetBundles” was updated.","OK","","critical")
      end
  end
  
  $gbPlist = nil
  if !File.exist?($gbPlistPath)
    open($gbPlistPath, "w") {|io| io << { 'bundleSources' => { } }.to_plist }
    $gbPlist = { 'bundleSources' => { } }
  else
    begin
      $gbPlist = OSX::PropertyList::load(File.open($gbPlistPath,"r"))
    rescue
      writeToLogFile("Can't open GetBundles' plist ‘#{$gbPlistPath}’")
      $gbPlist = { 'bundleSources' => { } }
    end
  end
end

def buildLocalBundleList

  unless $firstrun
    $params['isBusy'] = true
    $params['progressText'] = "Parsing local bundles…"
    updateDIALOG
  end

  $localBundles = { }
  
  # get deleted/disabled bundles from TM's plist
  $delCoreDisBundles = { }
  $delCoreDisBundles['deleted'] = [ ]
  $delCoreDisBundles['disabled'] = [ ]
  $localBundlesChanges = { }
  $localBundlesChangesPaths = { }

  unless ENV['TM_GETBUNDLES_AVOID_READING_TMPLIST']
    begin
      tmPlist = OSX::PropertyList::load(File.open("#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist","r"))
      $delCoreDisBundles['deleted'] = tmPlist['OakBundleManagerDeletedBundles'] if tmPlist.has_key?('OakBundleManagerDeletedBundles')
      $delCoreDisBundles['disabled'] = tmPlist['OakBundleManagerDisabledBundles'] if tmPlist.has_key?('OakBundleManagerDisabledBundles')
    rescue
      writeToLogFile("Could not read TextMate's plist.\n#{$!}")
      $delCoreDisBundles['disabled'] = [ ]
      $delCoreDisBundles['deleted']  = [ ]
    end
  end

  # get the creation date of TextMate's binary to set it to each default bundle
  theCtimeOfDefaultBundle = File.new(TextMate::app_path).mtime.getutc

  # loop through all locally installed bundles
  local_bundle_paths.each do |name, path|
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
            url = %x{head -n5 '#{b}/.svn/entries' | tail -n1}.chop
            $gbPlist['bundleSources'][plist['uuid']] = url unless url.blank?
          elsif scm =~ /git/
            begin
              theCtime = Time.parse(File.read("|cd '#{b}'; git show | head -n3 | tail -n 1 | perl -pe 's/Date: +//;s/(.*?) (.*?) (.*?) (.*?) (.*?) (.*)/\1 \2 \3 \4\6 \5/'").chomp).getutc
            rescue
              writeToLogFile("git error for “#{b}”: #{$!}")
              scm += " probably not working"
              theCtime = File.new(b).ctime.getutc
            end
          end

          begin
            infoMD5 = %x{cat "#{b}/info.plist" | openssl dgst -md5 -hex}.chop
          rescue
            infoMD5 = ""
          end

          # check deleted/disabled status
          disabled = ""
          deleted  = ""
          unless $justUndeletedCoreAndEnabledBundles.include?(plist['uuid']) # it was just installed? then don't ask TM's plist
            disabled = " bundle disabled" if $delCoreDisBundles['disabled'].include?(plist['uuid'])
            deleted  = " default bundle deleted" if $delCoreDisBundles['deleted'].include?(plist['uuid'])
          end
          $localBundles[plist['uuid']] = {'path' => b, 'name' => plist['name'], 'scm' => scm, 'rev' => theCtime.to_s, 'deleted' => deleted, 'disabled' => disabled, 'location' => name.to_s, 'infoMD5' => infoMD5 }
        else
          $localBundlesChanges[plist['uuid']] = true
          if $localBundlesChangesPaths.has_key?(plist['uuid'])
            $localBundlesChangesPaths[plist['uuid']] << b
          else
            $localBundlesChangesPaths[plist['uuid']] = [ ]
            $localBundlesChangesPaths[plist['uuid']] << b
          end
        end
      rescue
        writeToLogFile("Error while parsing “#{b}”:\n#{$!}")
      end
    end
  end

  # clean array of just installed bundles
  $justUndeletedCoreAndEnabledBundles = [ ]
  
  unless $firstrun
    $params['isBusy'] = false
    updateDIALOG
  else
    checkSources
  end
  
end

def getLocalStatus(aBundle)
  updatedStr = "" # for searching
  status = ""
  deleteBtn = "0"
  deleteBtnEnabled = false
  canBeOpened = 0
  locCom = ""
  deleteButtonLabel = ""
  nameBold = false
  if $localBundles.has_key?(aBundle['uuid'])
    deleteBtn = "1"
    canBeOpened = 1
    if $localBundles[aBundle['uuid']]['scm'].empty? && $localBundles[aBundle['uuid']]['deleted'].empty? && $localBundles[aBundle['uuid']]['location'] =~ /Pristine/
      deleteBtnEnabled = true
      deleteButtonLabel = "Delete"
    end
    if ! $localBundles[aBundle['uuid']]['deleted'].empty? || ! $localBundles[aBundle['uuid']]['disabled'].empty?
      deleteBtn = "0"
      deleteBtnEnabled = true
      deleteButtonLabel = ($localBundles[aBundle['uuid']]['deleted'].empty?) ? "Enable" : "Undelete"
    end
    
    # verify the bundle source
    if $gbPlist['bundleSources'].has_key?(aBundle['uuid'])
      unless aBundle['source'].join(' ').index($gbPlist['bundleSources'][aBundle['uuid']]).nil?
        if Time.parse(aBundle['revision']).getutc > Time.parse($localBundles[aBundle['uuid']]['rev']).getutc
          status = secToStr(Time.parse(aBundle['revision']), Time.parse($localBundles[aBundle['uuid']]['rev']))
          nameBold = true
        else
          status = "Ok"
        end
        locCom = " #{$localBundles[aBundle['uuid']]['location']}"
        locCom += " #{$localBundles[aBundle['uuid']]['scm']} #{$localBundles[aBundle['uuid']]['deleted']} #{$localBundles[aBundle['uuid']]['disabled']}"
        locCom += " [local changes]" if $localBundlesChanges[aBundle['uuid']]
        $localBundles[aBundle['uuid']]['seen'] = true
      end
    else
      if $numberOfBundleSources[aBundle['uuid']] == 1 || $localBundles[aBundle['uuid']]['location'] == 'default' && aBundle['status'] == 'Official'
        if Time.parse(aBundle['revision']).getutc > Time.parse($localBundles[aBundle['uuid']]['rev']).getutc
          status = secToStr(Time.parse(aBundle['revision']), Time.parse($localBundles[aBundle['uuid']]['rev']))
          nameBold = true
        else
          status = "Ok"
        end
        locCom = " #{$localBundles[aBundle['uuid']]['location']}"
        locCom += " #{$localBundles[aBundle['uuid']]['scm']} #{$localBundles[aBundle['uuid']]['deleted']} #{$localBundles[aBundle['uuid']]['disabled']}"
        locCom += " [local changes]" if $localBundlesChanges[aBundle['uuid']]
        $localBundles[aBundle['uuid']]['seen'] = true
      end
    end
    unless $localBundles[aBundle['uuid']]['seen'] || $gbPlist['bundleSources'].has_key?(aBundle['uuid'])
        status = "installed (source unknown)"
        locCom = " #{$localBundles[aBundle['uuid']]['location']}"
        locCom += " #{$localBundles[aBundle['uuid']]['scm']} #{$localBundles[aBundle['uuid']]['deleted']} #{$localBundles[aBundle['uuid']]['disabled']}"
        locCom += " [local changes]" if $localBundlesChanges[aBundle['uuid']]
    end
  end
  [updatedStr,status,deleteBtn,deleteBtnEnabled,locCom.strip,canBeOpened,deleteButtonLabel,nameBold]
end

def refreshUpdatedStatus

  $params['isBusy'] = true
  $params['progressText'] = "Parsing local bundles…"
  updateDIALOG

  buildLocalBundleList

  $params['nocancel'] = true
  updateDIALOG

  
  # loop through all shown bundles
  cnt = 0  # counter to link $dataaray and $bundleCache['bundles']
  $dataarray.each do |r|

    break if $close
    bundle = $bundleCache['bundles'][cnt]
    updatedStr,status,deleteButton,deleteButtonEnabled,locCom,canBeOpened,deleteButtonLabel,nameBold = getLocalStatus(bundle)

    if r['nameColor'] != '#000000'
      locCom += "  date: " + Time.parse(bundle['revision']).getutc.strftime("%y-%m-%d %H:%M")
    end


    # set the bundle status and the search patterns
    r['searchpattern'].gsub!(/=[^ ]*$/, (status.empty?) ? "" : (status =~ /^O/) ? "=i" : "=i=u")

    r['status'] = status
    r['deleteButtonEnabled'] = deleteButtonEnabled
    r['deleteButton'] = deleteButton
    r['locCom'] = locCom.strip.gsub(/ {2,}/,' ┋ ')
    r['canBeOpened'] = canBeOpened
    r['deleteButtonLabel'] = deleteButtonLabel
    r['deleteButtonTooltip'] = "#{deleteButtonLabel} “#{r['name']}”"
    r['nameBold'] = nameBold
    cnt += 1

  end

  # reset to current host filter
  filterDataarrayForParams
  $params['isBusy'] = false
  $params['nocancel'] = false
  updateDIALOG

  # suppress the updating of the table to preserve the selection
  $params.delete('dataarray')

end

def killThreads
  begin
    $initThread.kill        unless $initThread.nil?
    $installThread.kill     unless $installThread.nil?
    $infoThread.kill        unless $infoThread.nil?
    $refreshThread.kill     unless $refreshThread.nil?
    $reloadThread.kill      unless $reloadThread.nil?
    $svnlogThread.kill      unless $svnlogThread.nil?
    $svndataThread.kill     unless $svndataThread.nil?
    $svnInfoHostThread.kill unless $svnInfoHostThread.nil?
    $locBundlesThread.kill  unless $locBundlesThread.nil?
  rescue
  end
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
  puts Time.now.strftime("\n%m/%d/%Y %H:%M:%S") + "\tTextMate[GetBundles]" if printTime
  puts text
  puts
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

def checkForSupportFolderUpdate

  $updateSupportFolder = true

  if File.directory?($supportFolder)
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
    unless $bundleCache
      $errorcnt += 1
      writeToLogFile("No url found for “Support Folder”")
      return
    end
    begin
      GBTimeout::timeout($timeout) do
        doc = REXML::Document.new(File.read("|'#{$SVN}' info --xml '#{$bundleCache['SupportFolder']['url']}'"))
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
  
  $params['progressText'] = "Checking “Support Folder”…"
  updateDIALOG
  checkForSupportFolderUpdate
  
  $params['supportFolderCheck'] = 0
  $params['isBusy'] = false
  $params['nocancel'] = false
  $params['progressText'] = ""
  updateDIALOG
  
end

def filterDataarrayForParams
  b = case $params['bundleSelection']
    when "Review":      $dataarray.select {|v| v['source'] =~ /^R/}
    when "Official":    $dataarray.select {|v| v['source'] =~ /^O/}
    when "3rd Party":   $dataarray.select {|v| v['source'] !~ /^[OR]/}
    else $dataarray
  end
  $params['dataarray'] = b
  return b.size
end

def filterBundleList
  
  $params['isBusy']           = true
  $params['bundleSelection']  = $dialogResult['bundleSelection']
  $params['progressText']     = "Filtering bundle list…"
  updateDIALOG
  
  $lastBundleFilterSelection = $dialogResult['bundleSelection']
  
  $params['numberOfBundles']          = "#{filterDataarrayForParams} in total found"
  $params['progressIsIndeterminate']  = true
  $params['isBusy']                   = false
  updateDIALOG
  
end

# def checkUniversalAccess
#   unless ENV['TM_GETBUNDLES_SKIP_UI_CHECK']
#     ui = %x{osascript -e 'tell app "System Events" to set isUIScriptingEnabled to UI elements enabled'}
#     if ui =~ /^false/
#       if askDIALOG("AppleScript's “UI scripting” is not enabled. It is needed to activate GetBundles if it is already running. You can omit this check by setting the shell variable ‘TM_GETBUNDLES_SKIP_UI_CHECK’ in TextMate’s preferences.", "Do you want to open “System Preferences” to enable “Enable access for assistive devices”?", "Yes", "No") == 0
#         %x{osascript -e 'tell app "System Preferences" ' -e 'activate' -e 'set current pane to pane "com.apple.preference.universalaccess"' -e 'end tell'}
#       end
#     end
#   end
# end

def moveFileToTrash(aPath)
  # it's safer to use AS; no need for checking if aPath already exists in trash
  begin
    %x{osascript -e 'tell app "Finder" to delete POSIX file ("#{aPath}")'}
  rescue
    writeToLogFile("Error while moving “#{aPath}” to trash.\n#{$!}")
  end
end

def deleteBundle(uuid)
  
  items = nil

  begin
    items = Dir.glob("#{$localBundles[uuid]['path']}/**/*.tm*").size
    items2 = Dir.glob("#{$localBundles[uuid]['path']}/**/*.plist").size
    items += (items2>1) ? (items2-1) : 0
  rescue
    writeToLogFile("Error while reading ‘#{$localBundles[uuid]['path']}’\n#{$!}")
    items = nil
  end

  mes = (items.nil?) ? "“#{$localBundles[uuid]['name']}”" : "with #{items.to_s} item#{(items>1) ? 's' : ''}"
  
  localChangeMes = ($localBundlesChanges.has_key?(uuid)) ? "together with your local changes " : ""
  alertStyle = (localChangeMes.empty?) ? "informational" : "critical"
  if File.directory?($localBundles[uuid]['path'])
    if askDIALOG("Delete bundle #{mes}?", "The “#{$localBundles[uuid]['name']}” bundle will be moved #{localChangeMes}to Trash. Do you want to continue?", "Delete", "Cancel",alertStyle) == 0
      moveFileToTrash($localBundles[uuid]['path'])
      if $localBundlesChangesPaths.has_key?(uuid)
        $localBundlesChangesPaths[uuid].each { |b| moveFileToTrash(b) }
      end
      reloadBundles
      $gbPlist['bundleSources'].delete(uuid)
      writeGbPlist
      refreshUpdatedStatus
    end
  else
    refreshUpdatedStatus
    writeTimedMessage("", "It seems that the bundle has already been deleted.")
  end
end

def writeGbPlist
  open($gbPlistPath, "w") {|io| io << $gbPlist.to_plist }
end

def enableBundle(aBundle,path)
  begin
    %x{mate '#{aBundle['path']}'}
  rescue
    writeToLogFile("Error while enabling bundle.\n#{$!}")
  end
  #TM refreshes its plist not immediately
  b = $dataarray[path.to_i]
  b['deleteButtonEnabled'] = ($localBundles[b['uuid']]['scm'].empty? && $localBundles[b['uuid']]['location'] =~ /Pristine/) ? "1" : "0"
  b['deleteButton'] = "1"
  b['deleteButtonLabel'] = "Delete" if b['deleteButtonEnabled']
  b['locCom'].gsub!($localBundles[b['uuid']]['disabled'],"")
  b['locCom'].gsub!(/ ┋ *$/,'')
  $localBundles[b['uuid']]['disabled'] = ""
  $params['dataarray'] = $dataarray
  updateDIALOG
  $params.delete('dataarray')
end

def unDeleteBundle(aBundle,path)
  begin
    %x{mate '#{aBundle['path']}'}
  rescue
    writeToLogFile("Error while undeleting bundle.\n#{$!}")
  end
  #TM refreshes its plist not immediately
  b = $dataarray[path.to_i]
  b['deleteButtonEnabled'] = ($localBundles[b['uuid']]['scm'].empty? && $localBundles[b['uuid']]['location'] =~ /Pristine/) ? "1" : "0"
  b['deleteButton'] = "1"
  b['deleteButtonLabel'] = "Delete" if b['deleteButtonEnabled']
  b['locCom'].gsub!($localBundles[b['uuid']]['deleted'],"")
  b['locCom'].gsub!(/ ┋ *$/,'')
  $localBundles[b['uuid']]['deleted'] = ""
  $params['dataarray'] = $dataarray
  updateDIALOG
  $params.delete('dataarray')

end

def reloadBundles
  begin
    %x{osascript -e 'tell app "TextMate" to reload bundles'}
  rescue
    writeToLogFile("Error while reloading bundles.\n#{$!}")
  end
end

def closeMe
  $close = true
  unless $listsLoaded  # while fetching something from the net wait for aborting of threads
    $params['isBusy'] = true
    $params['progressText'] = 'Closing…'
    $params['progressIsIndeterminate'] = true
    updateDIALOG
    begin
      killThreads
    rescue
    end
  end
end


# =========================================
# =                 main                  =
# =========================================

# init DIALOG's parameters hash
$params = {
  'isBusy'                  => true,
  'progressIsIndeterminate' => true,
  'updateTMlibBtn'          => 'updateTMlibButtonIsPressed',
  'showHelpBtn'             => 'helpButtonIsPressed',
  'infoBtn'                 => 'infoButtonIsPressed',
  'cancelBtn'               => 'cancelButtonIsPressed',
  'closeBtn'                => 'closeButtonIsPressed',
  'revealInFinderBtn'       => 'revealInFinderIsPressed',
  'openAsProjectBtn'        => 'openAsProjectIsPressed',
  'deleteBtn'               => 'deleteButtonIsPressed',
  'nocancel'                => false,
  'instAllUpdates'          => 'installAllUpdates',
  'bundleSelection'         => 'All',
  'openBundleEditor'        => 0,
  'supportFolderCheck'      => 0,
  'progressText'            => "Connecting Bundle Server…",
}

$firstrun = true

# set svn client
$SVN = ENV['TM_SVN'] || ((%x{type -p svn}.strip!.nil?) ? "" : "svn")

STDOUT.sync = true
STDERR.sync = true

initGetBundlePlist
orderOutDIALOG
# checkUniversalAccess

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

# main loop
while $run do

  getResultFromDIALOG
  # writeToLogFile($dialogResult.inspect())

  if $dialogResult.has_key?('returnArgument')
    case $dialogResult['returnArgument']
      when 'installAllUpdates': $installThread = Thread.new { installAllUpdates }
      when 'helpButtonIsPressed':   helpDIALOG
      when 'cancelButtonIsPressed': 
        $close = true
        $params['isBusy'] = false
        $firstrun = false
        updateDIALOG
      when 'infoButtonIsPressed':   $infoThread = Thread.new { infoDIALOG($dialogResult) }
      when 'revealInFinderIsPressed':
        $finder_app = ENV['TM_GETBUNDLES_REVEAL_BUNDLE_IN'] || "Finder"
        %x{osascript -e 'tell app "#{$finder_app}" to reveal POSIX file("#{$localBundles[$dialogResult['uuid']]['path']}")'}
      when 'openAsProjectIsPressed': %x{mate '#{$localBundles[$dialogResult['uuid']]['path']}'}
      when 'deleteButtonIsPressed':
        case $dialogResult['action']
          when "Enable": enableBundle($localBundles[$dialogResult['uuid']], $dialogResult['path'])
          when "Undelete": unDeleteBundle($localBundles[$dialogResult['uuid']], $dialogResult['path'])
          else
            deleteBundle($dialogResult['uuid'])
        end
      when 'closeButtonIsPressed':
        closeMe
        break
      else # install bundle(s)
        if $params['isBusy'] == false
          if $dialogResult['returnArgument'].first =~ /-/
            begin
              %x{mate '#{local_bundle_paths[$localBundles[$dialogResult['returnArgument'].first]['location']]}/#{$localBundles[$dialogResult['returnArgument'].first]['name']}.tmbundle'} if $localBundles.has_key?($dialogResult['returnArgument'].first)
            rescue
            end
          else
            if $dialogResult['returnArgument'].size > 10
              if askDIALOG("Do you really want to install %d bundles?" % $dialogResult['returnArgument'].size ,"") == 1
                $installThread = Thread.new { installBundles($dialogResult) }
              end
            else
              $installThread = Thread.new { installBundles($dialogResult) }
            end
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
    reloadBundles
    $refreshThread = Thread.new do
      refreshUpdatedStatus
      $params['refreshBundleList'] = 0 # hide checkmark in menu
      updateDIALOG
    end

  elsif $dialogResult['rescanBundleList'] == 1
    reloadBundles
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
    closeMe
    break
  end

  $dialogResult = { }

end

closeDIALOG
