
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

    # wait for "Update Bundle" dialog if needed; 'updateDIALOG' has to wait for a modal TM dialog
    sleep(0.5)
    updateDIALOG
    sleep(0.2)
    if File.exist?("#{$pristineCopyFolder}/Bundles/#{bundleData['name']}.tmbundle/installed")
      %x{rm '#{$pristineCopyFolder}/Bundles/#{bundleData['name']}.tmbundle/installed'}
      $gbPlist['bundleSources'][bundleData['uuid']] = path
      writeGbPlist
    else
       p "Installation of the bundle “#{bundleData['name']}” was canceled by the ‘Bundle Editor’"
    end
  end
  
  $params['isBusy'] = false
  $params['progressText'] = ""
  updateDIALOG

  removeTempDir
  refreshUpdatedStatus if cnt > 0

  $listsLoaded = true
  
end

def installAllUpdates
  writeToLogFile("Installing all updates…")
  counter = 0
  items = [ ]
  $dataarray.each do |b|
    items << counter if b['nameBold'] && b['locCom'] !~ /(svn|git)/
    p "The bundle “#{b['name']}” cannot be updated. It is under versioning control." if b['nameBold'] && b['locCom'] =~ /(svn|git)/
    counter += 1
  end
  dlg = {'returnArgument' => items}
  installBundles(dlg)
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
  %x{touch '#{$tempDir}/#{name}.tmbundle/installed'}
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0

end

def installTAR(name, path, zip_path)

  removeTempDir
  FileUtils.mkdir_p $tempDir

  begin
    GBTimeout::timeout($timeout) do
      begin

        if path =~ /^http:\/\/github\.com/  # hosted on github ?
          # usr, nm = path.split('/')[3..4]
          # ghid = YAML.load(open("http://github.com/api/v1/json/#{usr}/#{nm}/commits/master"))['commits'].first['id']
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

  return if $close || $errorcnt>0
  %x{touch '#{$tempDir}/#{name}.tmbundle/installed'}
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
  %x{touch '#{$tempDir}/#{name}.tmbundle/installed'}
  # install bundle if everything went fine
  executeShell("open '#{$tempDir}/#{name}.tmbundle'", false, true) if $errorcnt == 0

end
