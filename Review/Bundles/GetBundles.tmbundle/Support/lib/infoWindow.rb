def infoDIALOG(dlg)

  return unless dlg.has_key?('path')

  removeTempDir
  FileUtils.mkdir_p $tempDir

  bundle = $bundleCache['bundles'][dlg['path'].to_i]

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
    gitInfo(bundle)
  elsif mode == 'svn'
    svnInfo(bundle)
  elsif bundle.has_key?('url')
    privateInfo(bundle)
  else
    writeToLogFile("No method found to fetch information")
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
    $infoToken = %x{"$DIALOG" nib --load help --model "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"  }
  else
    $infoToken = %x{"$DIALOG" -a help -p "{title='GetBundles — Info';path='#{$tempDir}/info.html';}"}
  end

  # close old info window if it exists
  # unless $infoTokenOld.nil?
  #   if $isDIALOG2
  #     %x{"$DIALOG" nib close #{$infoTokenOld}}
  #   else
  #     %x{"$DIALOG" -x#{$infoTokenOld}}
  #   end
  # end
  
  removeTempDir
  
end

def gitInfo(bundle)
  
  info = { }
  plist = { }
  readme = ""
  css = ""
  data = ""
  url = bundle['url']
  namehasdot = false
  url =~ /.*?com\/(.*?)\/(.*)/
  owner = $1
  projectName = url.gsub(/.*?com\/(.*?)\/(.*)/, '\2')

  begin
    GBTimeout::timeout($timeout) do
      d = YAML.load(%x{curl -sSL "http://github.com/api/v2/yaml/repos/show/#{owner}/#{projectName}"})
      if d.has_key?('repository')
        info = d['repository']
      else
        info = {}
        info[:description] = "<font color=silver><small>no data available</small></font>"
        info[:watchers] = "<font color=silver><small>no data available</small></font>"
        info[:private] = "<font color=silver><small>no data available</small></font>"
        info[:forks] = "<font color=silver><small>no data available</small></font>"
        info[:fork] = "<font color=silver><small>no data available</small></font>"
        info[:owner] = url.gsub(/.*?com\/(.*?)\/.*/,'\1')
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

  commits = nil
  lastCommit = nil

  begin
    GBTimeout::timeout(10) do
      loop do
        begin
          commits = YAML.load(%x{curl -sSL "http://github.com/api/v1/yaml/#{info[:owner]}/#{projectName}/commits/master"})['commits'].first
          lastCommit = commits['committed_date']
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
      data = %x{curl -sSL "#{url}/tree/master"}
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
        plist = OSX::PropertyList::load(%x{curl -sSL "#{url}/tree/master/info.plist?raw=true"}.gsub(/.*?(<plist.*?<\/plist>)/m,'\1'))
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
  # css = data.gsub( /.*?(<link href=".*?\/stylesheets\/.*?\/>).*/m, '\1')
  data = ""

  return if $close

  gitbugreport = (namehasdot) ? "&nbsp;&nbsp;&nbsp;<i><small>incomplete caused by the dot in project name (known GitHub bug)</small></i><br>" : ""

  updateinfo = ""
  if !lastCommit.nil? && Time.parse(lastCommit).getutc > Time.parse(bundle['revision']).getutc
    t = "This bundle was updated meanwhile."
    updateinfo = "<p align='right'><small><font color='#darkgreen'>#{t}</font></small></p>"
  end

  File.open("#{$tempDir}/info.html", "w") do |io|
    io << <<-HTML
      <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
      <base href='http://github.com'>
      <head>
      <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
      <link href="http://assets0.github.com/stylesheets/bundle.css" media="screen" rel="stylesheet" type="text/css" />
      </head>
      <body><div id='main'><div class='site'>
      <font color='blue' size=12pt>#{plist['name']}</font><br /><br />
      #{updateinfo}
      <h3><u>git Information:</u></h3>#{gitbugreport}
      <b>Description:</b><br />&nbsp;#{info[:description]}<br />
      <b>URL:</b><br />&nbsp;<a href='#{url}'>#{url}</a><br />
      <b>Username:</b><br />&nbsp;<a href='http://github.com/#{info[:owner]}'>#{info[:owner]}</a><br />
      HTML
      
      if ! commits.nil?
        if ! commits["author"]["name"].nil? and ! commits["author"]["name"].empty?
          io << <<-HTML
          <b>Author:</b><br />&nbsp;#{commits["author"]["name"]}<br />
          HTML
        end
        if ! commits["author"]["email"].nil? and ! commits["author"]["email"].empty?
          io << <<-HTML
          <b>Email:</b><br />&nbsp;<a href='mailto:#{commits["author"]["email"]}'>#{commits["author"]["email"]}</a><br />        
          HTML
        end
      end
      
      io << <<-HTML
      <b>Forks:</b><br />&nbsp;#{info[:forks]}<br />
      <b>Forked:</b><br />&nbsp;#{info[:fork]}<br />
      <b>Last Modified:</b><br />&nbsp;#{Time.parse(lastCommit).getutc.to_s}<br />
      HTML

      io << <<-HTML
      <br /><b>zip archive:</b><br />&nbsp;<a href='#{zipsource}'>#{zipsource}</a><br />
      <b>tar archive:</b><br />&nbsp;<a href='#{tarsource}'>#{tarsource}</a><br />        
      HTML

      if $localBundles.has_key?(bundle['uuid'])
        io << "<br /><b>Locally installed at:</b><br />&nbsp;<a href='file://#{$localBundles[bundle['uuid']]['path']}'>#{$localBundles[bundle['uuid']]['path']}</a><br />"
        io << "&nbsp;<b>from:</b> #{$gbPlist['bundleSources'][bundle['uuid']]}<br /><br />"
      end

      if $localBundlesChangesPaths.has_key?(bundle['uuid'])
        io << "<b>Local changes at:</b><br />"
        $localBundlesChangesPaths[bundle['uuid']].each do |path|
          io << "&nbsp;<a href='file://#{path}'>#{path}</a><br />"
          begin
            Dir.glob("#{path}/**/*.tm*") do |item|
              io << "&nbsp;• #{File.basename(item, '.*')}<br />"
            end
            Dir.glob("#{path}/**/*.plist") do |item|
              io << "&nbsp;• #{File.basename(item, '.*')}<br />" unless File.basename(item) == "info.plist"
            end
          rescue
          end
        end
      end


      if ENV.has_key?('TM_GETBUNDLES_SHOW_SVNGIT_COMMANDS')
        io << <<-HTML
      <b>git clone:</b><br /><pre><small><small>export LC_CTYPE=en_US.UTF-8
mkdir -p ~/Library/Application\\ Support/TextMate/Bundles
cd ~/Library/Application\\ Support/TextMate/Bundles
git clone #{gitsource} '#{plist['name']}.tmbundle'
osascript -e 'tell app "TextMate" to reload bundles'</small></small></pre>
      HTML
      end

    if ENV.has_key?('TM_GETBUNDLES_SHOW_SVNGIT_COMMANDS') && $localBundles.has_key?(bundle['uuid']) && ! $localBundles[bundle['uuid']]['scm'].empty?
      io << <<-HTML
      <b>git pull:</b><br /><pre><small><small>export LC_CTYPE=en_US.UTF-8
cd '#{$localBundles[bundle['uuid']]['path']}'
git pull
osascript -e 'tell app "TextMate" to reload bundles'</small></small></pre>
    HTML
    end

    io << "<br /><br /><h3><u>Bundle Information (info.plist):</u></h3>"

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
      io << <<-HTML
      <br /><br />
      <h3><u>README:</u></h3><br />
      #{readme}</div></div>
      </body></html>
      HTML
    end
  end
  
end

def svnInfo(bundle)
  if $SVN.empty?
    $errorcnt += 1
    writeToLogFile("Could not install “#{name}”.")
    noSVNclientFound
    return
  end
  info = { }
  plist = { }

  data = nil
  svnlogs = nil
  svnsource = bundle['source'].find { |m| m['method'] == "svn" }['url']

  $svnlogThread = Thread.new($SVN, bundle['source'].first['url']) { %x{'#{$SVN}' log --limit 5 "#{bundle['source'].first['url']}"} }
  $svndataThread = Thread.new($SVN, bundle['source'].first['url']) { %x{#{$SVN} info "#{bundle['source'].first['url']}"} }
  $svnInfoHostThread = Thread.new(svnsource) do
    # get info.plist data
    begin
      plist = OSX::PropertyList::load(%x{curl -sSL "#{svnsource}/info.plist"})
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

  if data.blank? || plist.blank?
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
    io << <<-HTML
      <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
      <head>
      <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
      </head>
      <body style='font-family:Lucida Grande'>
    HTML

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

    io << <<-HTML
      <span style="background-color:#EEEEEE">
      <b>URL:</b><br />&nbsp;<a href='#{info['URL']}'>#{info['URL']}</a><br />
      <b>Contact Name:</b><br />&nbsp;#{contact}<br />
      <b>Last Changed Date:</b><br />&nbsp;#{Time.parse(info['Last Changed Date']).getutc.to_s}<br />
      <b>Last Changed Author:</b><br />&nbsp;#{info['Last Changed Author']}<br />
      <b>Last Changed Rev:</b><br />&nbsp;#{info['Last Changed Rev']}<br />
      <b>Revision:</b><br />&nbsp;#{info['Revision']}<br />
      <b>UUID:</b><br />&nbsp;#{plist['uuid']}<br />
      HTML

      if ENV.has_key?('TM_GETBUNDLES_SHOW_SVNGIT_COMMANDS')
        io << <<-HTML
      <b>svn checkout</b><br /><pre>export LC_CTYPE=en_US.UTF-8
mkdir -p ~/Library/Application\\ Support/TextMate/Bundles
cd ~/Library/Application\\ Support/TextMate/Bundles
svn co #{svnsource}
osascript -e 'tell app "TextMate" to reload bundles'
</pre>
        HTML
      end

    if ENV.has_key?('TM_GETBUNDLES_SHOW_SVNGIT_COMMANDS') && $localBundles.has_key?(bundle['uuid']) && ! $localBundles[bundle['uuid']]['scm'].empty?
      io << <<-HTML
      <b>svn update</b><br /><pre>export LC_CTYPE=en_US.UTF-8
cd '#{$localBundles[bundle['uuid']]['path']}'
svn up
osascript -e 'tell app "TextMate" to reload bundles'
</pre>
      HTML
    end

    if $localBundles.has_key?(bundle['uuid'])
      io << "<br /><b>Locally installed at:</b><br />&nbsp;<a href='file://#{$localBundles[bundle['uuid']]['path']}'>#{$localBundles[bundle['uuid']]['path']}</a><br />"
      io << "&nbsp;<b>from:</b> #{$gbPlist['bundleSources'][bundle['uuid']]}<br /><br />"
    end

    if $localBundlesChangesPaths.has_key?(bundle['uuid'])
      io << "<b>Local changes at:</b><br />"
      $localBundlesChangesPaths[bundle['uuid']].each do |path|
        io << "&nbsp;<a href='file://#{path}'>#{path}</a><br />"
        begin
          Dir.glob("#{path}/**/*.tm*") do |item|
            io << "&nbsp;• #{File.basename(item, '.*')}<br />"
          end
          Dir.glob("#{path}/**/*.plist") do |item|
            io << "&nbsp;• #{File.basename(item, '.*')}<br />" unless File.basename(item) == "info.plist"
          end
        rescue
        end
      end
    end

    io << "<br /></span>"
    unless relocateHint.empty?
      io << <<-HTML
      <br /><b><span style="color:red">Hint</span></b> The svn URL points to an old repository. To relocate it please use the following command:<br />
      #{relocateHint}
      HTML
    end

    io << "<br /><br /><b>Last svn log entries:</b><br /><pre>#{svnlogs}</pre>" unless svnlogs.nil?
    io <<  "</body></html>"
  end

end

def privateInfo(bundle)
  File.open("#{$tempDir}/info.html", "w") do |io|
    io << <<-HTML
      <html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
      <head>
      <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
      </head>
      <body style='font-family:Lucida Grande'>
      <font color='blue' size=12pt>#{bundle['name']}</font><br /><br />
      #{bundle['description']}<br /><br />
      <b>Info URL:</b><br />&nbsp;<a href='#{bundle['url']}'>#{bundle['url']}</a><br />
      <b>Archive URL:</b><br />&nbsp;<a href='#{bundle['source'].first['url']}'>#{bundle['source'].first['url']}</a><br />
      <b>Author:</b><br />&nbsp;#{bundle['contact']}<br />
      <b>Last Modified:</b><br />&nbsp;#{bundle['revision']}<br />
      <b>UUID:</b><br />&nbsp;#{bundle['uuid']}<br />
      HTML
      
      if $localBundles.has_key?(bundle['uuid'])
        io << "<br /><b>Locally installed at:</b><br />&nbsp;<a href='file://#{$localBundles[bundle['uuid']]['path']}'>#{$localBundles[bundle['uuid']]['path']}</a><br />"
        io << "&nbsp;<b>from:</b> #{$gbPlist['bundleSources'][bundle['uuid']]}<br /><br />"
      end

      if $localBundlesChangesPaths.has_key?(bundle['uuid'])
        io << "<b>Local changes at:</b><br />"
        $localBundlesChangesPaths[bundle['uuid']].each do |path|
          io << "&nbsp;<a href='file://#{path}'>#{path}</a><br />"
          begin
            Dir.glob("#{path}/**/*.tm*") do |item|
              io << "&nbsp;• #{File.basename(item, '.*')}<br />"
            end
            Dir.glob("#{path}/**/*.plist") do |item|
              io << "&nbsp;• #{File.basename(item, '.*')}<br />" unless File.basename(item) == "info.plist"
            end
          rescue
          end
        end
      end
      io << "</body></html>"
  end      
end
