#!/usr/bin/env ruby 

SUPPORT = ENV['TM_SUPPORT_PATH']
require SUPPORT + '/lib/escape.rb'
require SUPPORT + '/lib/osx/plist'
require SUPPORT + '/lib/textmate.rb'
require 'rexml/document'
require 'erb'
require "fileutils"
require "open-uri"
require "yaml"
require 'net/http'
require 'uri'
require 'cgi'
require "timeout"
require "open3"

include ERB::Util

$DIALOG           = e_sh ENV['DIALOG']
$NIB              = 'BundlesTree'
$isDIALOG2        = ! $DIALOG.match(/2$/).nil?
# cache file for the svn descriptions
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
$ts
# does the installation folder exist
$installFolderExists = false
# error counter
$errorcnt         = 0
# temp dir for installation
$tempDir          = "/tmp/TM_GetBundlesTEMP"
# global timeout in seconds
$timeout          = 30

CAPITALIZATION_EXCEPTIONS = %w[tmbundle on as]

def remote_bundle_locations
  [ {:display => :'Macromates Bundles', :scm => :svn, :name => 'B',
      :url => 'http://macromates.com/svn/Bundles/trunk/Bundles/'},
    {:display => :'Macromates Review', :scm => :svn, :name => 'R',
      :url => 'http://macromates.com/svn/Bundles/trunk/Review/Bundles/'},
    {:display => :'GitHub', :scm => :git, :name => 'G',
      :url => 'http://github.com/api/v1/yaml/search/tmbundle'} ]
end

def targetPaths
  {
    'Users Lib Pristine'  => "#{ENV["HOME"]}/Library/Application Support/TextMate/Pristine Copy/Bundles",
    'Users Lib Bundles'   => "#{ENV["HOME"]}/Library/Application Support/TextMate/Bundles",
    'Lib Bundles'         => "/Library/Application Support/TextMate/Bundles",
    'App Bundles'         => "/Applications/TextMate.app/Contents/SharedSupport/Bundles",
    'Users Desktop'       => "#{ENV["HOME"]}/Desktop",
    'Users Downloads'     => "#{ENV["HOME"]}/Downloads",
  }
end

def getInstallPathFor(abbr)
  # update params
  $params['targetSelection'] = abbr
  updateDIALOG
  if targetPaths.has_key?(abbr)
    return targetPaths[abbr]
  else
    return "#{ENV["HOME"]}/Desktop"
    # return %x{osascript -e 'tell application "TextMate"' -e 'activate' -e 'POSIX path of (choose folder with prompt "as installation target")' -e 'end tell' 2>/dev/null}.strip().gsub(/\/$/,'')
  end
end

def normalize_github_repo_name(name)
  # Convert a GitHub repo name into a "normal" TM bundle name
  # e.g. ruby-on-rails-tmbundle => Ruby on Rails.tmbundle
  name = name.gsub("-", " ").split.each{|part|
    part.capitalize! unless CAPITALIZATION_EXCEPTIONS.include? part}.join(" ")
  name[-9] = ?. if name =~ / tmbundle$/
  name
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
  if $isDIALOG2
    $token = %x{#{$DIALOG} window create -p #{e_sh $params.to_plist} #{e_sh $NIB} }
  else
    $token = %x{#{$DIALOG} -a #{e_sh $NIB} -p #{e_sh $params.to_plist}}
  end
end

def closeDIALOG
  if $isDIALOG2
    %x{#{$DIALOG} window close #{$token}}
  else
    %x{#{$DIALOG} -x#{$token}}
  end
  %x{open 'txmt://open?'}
end

def updateDIALOG
  if $isDIALOG2
    %x{#{$DIALOG} window update #{$token} -p #{e_sh $params.to_plist}}
  else
    open("|#{$DIALOG} -t#{$token}", "w") { |io| io.write $params.to_plist }
  end
end

def helpDIALOG
  %x{'#{ENV['TM_BUNDLE_SUPPORT']}/bin/showHelp.sh'}
end

def infoDIALOG
  return if ! $dialogResult.has_key?('path')
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  path = $dialogResult['path'].split('|').last
  mode = $dialogResult['path'].split('|').first
  searchPath = path.gsub(/.*?com\/(.*?)\/(.*?)\/.*/, '\1-\2')
  url = path.gsub(/zipball\/master/, '')
  info = { }
  readme = ""
  css = ""
  data = ""
  $params['isBusy'] = true
  $params['progressIsIndeterminate'] = true
  $params['progressText'] = "Fetching information…"
  updateDIALOG
  if mode == 'git'
    begin
      Timeout::timeout($timeout) do
        info = YAML.load(open("http://github.com/api/v1/yaml/search/#{searchPath}"))['repositories'].first
      end
    rescue Timeout::Error
      $params['isBusy'] = false
      updateDIALOG
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while fetching information")
      return
    end
    begin
      Timeout::timeout($timeout) do
        data = Net::HTTP.get( URI.parse("#{url}tree/master") )
      end
    rescue Timeout::Error
      $params['isBusy'] = false
      updateDIALOG
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while fetching information")
      return
    end
    readme = data.gsub( /.*?(<div id="readme">.*?)<div class="push">.*/m, '\1').gsub(/<span class="name">README.*?<\/span>/, '')
    readme = "<br /><i>No README found</i><br />" if ! readme.match(/readme/i)
    css = data.gsub( /.*?(<link href="\/stylesheets\/.*?\/>).*/m, '\1')
    data = ""
    f = File.open("#{$tempDir}/info.html", "w")
    f.puts "<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>"
    f.puts "<base href='http://github.com'>"
    f.puts "<head>"
    f.puts "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"
    f.puts "#{css}"
    f.puts "</head>"
    f.puts "<body><div id='main'><div class='site'>"
    f.puts "<font color='blue' size=12pt>#{info['name']}</font><br /><br />"
    f.puts "<table>"
    f.puts "<tr><td width='150px'>Name:</td><td>#{info['name']}</td></tr>"
    f.puts "<tr><td>URL:</td><td><a href='#{url}'>#{url}</a></td></tr>"
    f.puts "<tr><td>Description:</td><td>#{info['description']}</td></tr>"
    f.puts "<tr><td>Owner:</td><td><a href='http://github.com/#{info['owner']}'>#{info['owner']}</a></td></tr>"
    f.puts "<tr><td>Watchers:</td><td>#{info['watchers']}</td></tr>"
    f.puts "<tr><td>Private:</td><td>#{info['private']}</td></tr>"
    f.puts "<tr><td>Forks:</td><td>#{info['forks']}</td></tr>"
    f.puts "</table>"
    f.puts "<br /><br />"
    f.puts "#{readme}</div></div>"
    f.puts "</body></html>"
    f.flush
    f.close
  elsif mode == 'svn'
    if $SVN.length > 0
      begin
        Timeout::timeout($timeout) do
          data = executeShell("export LC_CTYPE=en_US.UTF-8;'#{$SVN}' info '#{path}'")
          if $errorcnt > 0
            %x{rm -r #{$tempDir}}
            $params['isBusy'] = false
            updateDIALOG
            return
          end
        end
      rescue Timeout::Error
        %x{rm -rf #{$tempDir}}
        writeToLogFile("Timeout error while fetching information")
        return
      end
      data.each_line do |l|
        info[l.split(': ').first] = l.split(': ').last
      end
      f = File.open("#{$tempDir}/info.html", "w")
      f.puts "<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>"
      f.puts "<head>"
      f.puts "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"
      f.puts "</head>"
      f.puts "<body style='font-family:Lucida Grande'>"
      f.puts "<font color='blue' size=12pt>#{info['Path']}</font><br /><br />"
      f.puts "<table>"
      f.puts "<tr><td width='150px'>Path:</td><td>#{info['Path']}</td></tr>"
      f.puts "<tr><td>URL:</td><td><a href='#{info['URL']}'>#{info['URL']}</a></td></tr>"
      f.puts "<tr><td>Revision:</td><td>#{info['Revision']}</td></tr>"
      f.puts "<tr><td>Last Changed Author:</td><td>#{info['Last Changed Author']}</td></tr>"
      f.puts "<tr><td>Last Changed Rev:</td><td>#{info['Last Changed Rev']}</td></tr>"
      f.puts "<tr><td>Last Changed Date:</td><td>#{info['Last Changed Date']}</td></tr>"
      f.puts "</table>"
      f.puts "</body></html>"
      f.flush
      f.close
    else          #### no svn client found
      writeToLogFile("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
      $params['progressText'] = 'No svn client found! Please check the Activity Log.'
      updateDIALOG
      sleep(3)
    end
  else
    return
  end
  # %x{textutil -convert rtfd '#{$tempDir}/info.html'}
  $params['isBusy'] = false
  updateDIALOG
  $infoTokenOld = $infoToken
  if $isDIALOG2
    $infoToken = %x{#{$DIALOG} window create -p "{title='GetBundle — Info';path='#{$tempDir}/info.html';}" help }
  else
    $infoToken = %x{#{$DIALOG} -a help -p "{title='GetBundle — Info';path='#{$tempDir}/info.html';}"}
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

def askDIALOG(msg, text)
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
  begin
    $dialogResult = OSX::PropertyList.load(resStr)
  rescue
  end
end

def getBundleLists
  begin
    $listsLoaded = false
    $dataarray  = [ ]
    remote_bundle_locations.each do |r|
      break if $close
      # init DIALOG's parameters hash
      $params = {
        'isBusy'                  => true,
        'progressText'            => 'Fetching List for %s…' % r[:display].to_s,
        'progressIsIndeterminate' => true,
        'updateTMlibBtn'          => 'updateTMlibButtonIsPressed',
        'showHelpBtn'             => 'helpButtonIsPressed',
        'infoBtn'                 => 'infoButtonIsPressed',
        'targets'                 => [ 
          'Users Lib Pristine', 'Users Lib Bundles', 'Lib Bundles', 'App Bundles', 'Users Desktop', 'Users Downloads'
          ],
        'targetSelection'         => 'Users Lib Pristine',
        'nocancel'                => false,
        'repoColor'               => '#0000FF',
        'logPath'                 => %x{cat '#{$logFile}'},
        'bundleSelection'         => 'All',
        'usingGitZip'             => false,
      }
      updateDIALOG
      bundlearray = [ ]
      if r[:scm] == :svn
        list = [ ]
        begin
          Timeout::timeout($timeout) do
            list = Net::HTTP.get( URI.parse(r[:url]) ).gsub( /<[^>]+?>/, '').gsub( /(?m)^.*?\.\.\n/, '').gsub( /(?m)\/[^\/]*$/, '').strip().split(/\n/)
          end
        rescue Timeout::Error
          writeToLogFile("Timout for fetching %s list" % r[:display].to_s)
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
        begin
          Timeout::timeout($timeout) do
            list = YAML.load(open(r[:url]))['repositories'].
                find_all{|result| result['name'].match("")}.
                sort{|a,b| a['name'] <=> b['name']}
          end
        rescue Timeout::Error
          writeToLogFile("Timout for fetching %s list" % r[:display].to_s)
          $params['progressText'] = 'Timeout'
          $params['isBusy'] = false
          updateDIALOG
        end
        list.each do |result|
          break if $close
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
    updateDIALOG
    $listsLoaded = true
  rescue
    $params['progressText'] = 'Unknown error occured!'
    $params['isBusy'] = false
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
            bundle['bundleDescription'] = strip_html plist['description'].to_s.gsub(/\n/, ' ')
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
  executeShell("cp -r '#{aFolder}' '#{aFolder}TEMP' 1> /dev/null")
  executeShell("rm -rf '#{aFolder}' 1> /dev/null")
  executeShell("cp -r '#{aFolder}#{$ts}' '#{aFolder}' 1> /dev/null")
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
  executeShell("cp -r '#{aFolder}' '#{aFolder}#{$ts}' 1> /dev/null")
  executeShell("rm -r '#{aFolder}' 1> /dev/null")
  if $errorcnt > 0
    writeToLogFile("Cannot rename “#{aFolder}” into “#{aFolder}#{$ts}”")
  end
end

def executeShell(cmd, cmdToLog = false, outToLog = false)
  writeToLogFile(cmd) if cmdToLog
  stdin, stdout, stderr = Open3.popen3(cmd)
  out = stdout.read
  err = stderr.read
  stdin.close
  stdout.close
  stderr.close
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
  writeToLogFile("Install:\t%s\ninto:\t%s/%s\nusing:\t/usr/bin/unzip\ntemp folder:\t%s" \
    % [path, installPath, name, $tempDir])
  %x{rm -rf #{$tempDir} 1> /dev/null}
  FileUtils.mkdir_p $tempDir
  begin
    Timeout::timeout($timeout) do
      begin
        File.open(download_file, 'w') { |f| f.write(open(path).read)}
      rescue
        $errorcnt += 1
        writeToLogFile("No access to “#{path}”")
        return
      end
    end
  rescue Timeout::Error
    $errorcnt += 1
    %x{rm -rf #{$tempDir}}
    writeToLogFile("Timeout error while installing %s" % name)
    return
  end
  return if $close
  if $errorcnt == 0
    # try to unzip the zipball
    executeShell("/usr/bin/unzip '#{download_file}' -d '#{$tempDir}' 1> /dev/null")
    if $errorcnt > 0
      %x{rm -rf #{$tempDir}}
      return
    end
    return if $close
    # get the zip id from the downloaded zipball
    id = executeShell("/usr/bin/unzip -z '#{download_file}' | head -n2 | tail -n1")
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
    renameOldBundleFolder("#{installPath}/#{name}") if $installFolderExists
    executeShell("cp -r '#{$tempDir}/#{name}' #{e_sh installPath}")
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
    Timeout::timeout($timeout) do
      d = executeShell("#{git} clone #{e_sh thePath} '#{$tempDir}/#{theName}' 2>&1", true, false)
      if d.match(/(fatal|error)/)
        writeToLogFile(d)
        %x{rm -r #{$tempDir}}
        return
      end
      # avoid outputting all xx% stuff, only for 100% or error
      writeToLogFile(d.gsub(/[\r|\n]/,"§").split('§').select{|v| v =~ /(fatal|error|done|100)/}.join("\n"))
    end
  rescue Timeout::Error
    $errorcnt += 1
    %x{rm -rf #{$tempDir}}
    writeToLogFile("Timeout error while installing %s" % theName)
    return
  end
  return if $close
  if $errorcnt == 0
    renameOldBundleFolder("#{installPath}/#{theName}") if $installFolderExists
    executeShell("cp -r '#{$tempDir}/#{theName}' '#{installPath}/#{theName}'")
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
      Timeout::timeout($timeout) do
        executeShell("export LC_CTYPE=en_US.UTF-8;cd '#{$tempDir}';'#{$SVN}' co --no-auth-cache --non-interactive '#{path}'",true,true)
        if $errorcnt > 0
          %x{rm -r #{$tempDir}}
          return
        end
      end
    rescue Timeout::Error
      $errorcnt += 1
      %x{rm -rf #{$tempDir}}
      writeToLogFile("Timeout error while installing %s" % name)
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
      renameOldBundleFolder("#{installPath}/#{realname}") if $installFolderExists
      executeShell("cp -r '#{$tempDir}/#{realname}' '#{installPath}/#{realname}'")
      if $errorcnt > 0
        %x{rm -r #{$tempDir}}
        writeToLogFile("Cannot copy “#{$tempDir}#{realname}” to “#{installPath}/#{realname}”")
        resetOldBundleFolder("#{installPath}/#{realname}") if $installFolderExists
        return
      end
    end
    %x{rm -r #{$tempDir}}
  else          #### no svn client found
    writeToLogFile("No svn client found!\nIf there is a svn client available but not found by 'GetBundles' set 'TM_SVN' accordingly.\nOtherwise you can install svn from http://www.collab.net/downloads/community/.")
    $params['progressText'] = 'No svn client found! Please check the Activity Log.'
    updateDIALOG
    sleep(3)
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
      mode += $GITMODE if mode == 'git' and ! dlg['usingGitZip']
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
      writeToLogFile("Installation of “%s” done." % name)
    end
    $params['progressText'] = "Reload Bundles…"
    updateDIALOG
    %x{osascript -e 'tell app "TextMate" to reload bundles'}
    if $errorcnt > 0
      $params['progressText'] = 'General error while installing! Please check the Activity Log.'
      updateDIALOG
      sleep(3)
    end
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
  return if askDIALOG("Do you really want to install TextMate's lastest Support folder?","") == 0
  path = "http://macromates.com/svn/Bundles/trunk/Support/lib/"
  $params['isBusy'] = true
  $params['progressText'] = "Installing TextMate's Support folder…"
  updateDIALOG
  begin
    installPath = TextMate::app_path.gsub('(.*?)/MacOS/TextMate','\1') + "/Contents/SharedSupport/Support"
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
  $params['progressText'] = 'Installing Support/lib'
  updateDIALOG
  renameOldBundleFolder("#{installPath}/lib")
  return if $errorcnt > 0
  begin
    Timeout::timeout($timeout) do
      executeShell("export LC_CTYPE=en_US.UTF-8;cd '#{e_sh installPath}';'#{$SVN}' co --no-auth-cache --non-interactive '#{path}'", true, true)
      if $errorcnt > 0
        resetOldBundleFolder("#{installPath}/lib")
        return
      end
    end
  rescue Timeout::Error
    $errorcnt += 1
    resetOldBundleFolder("#{installPath}/lib")
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

##------- main -------##

initSVNDescriptionCache
initLogFile

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

$params['nocancel'] = true
orderOutDIALOG
writeToLogFile("Get Bundles DIALOG runs at token #{$token}")
$params['nocancel'] = false
$params['updateBtnLabel'] = 'Update Descriptions'
updateDIALOG

$x1 = Thread.new do
  begin
    getBundleLists
  rescue
    writeToLogFile("Fatal Error")
    $run = false
    exit 0
  end
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
    elsif $dialogResult['returnArgument'] == 'infoButtonIsPressed'
      infoDIALOG
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
