class Browser  
  def Browser.load_url(url)
    unless omniweb_did_load(url) or safari_did_load(url) or camino_did_load(url) then
      %x{open '#{url}'}
    end
  end

  def Browser.omniweb_did_load(url)
    res = %x{ps -xc|grep -sq OmniWeb && osascript <<'APPLESCRIPT'
    	tell app "OmniWeb"
      	if browsers is not { }
      		set the_url to address of first browser
      		if the_url is "#{url}" then
      			activate
      			tell app "System Events" to keystroke "r" using {command down}
      			return true
      		end if
      	end if
      end tell
APPLESCRIPT}
    res =~ /true/
  end

  def Browser.safari_did_load(url)
    res = %x{ps -xc|grep -sq Safari && osascript <<'APPLESCRIPT'
    	tell app "Safari"
    		if documents is not { }
    			set the_url to URL of first document
    			if the_url is "#{url}" then
    				activate
    				do JavaScript "window.location.reload();" in first document
    				return true
    			end if
    		end if
    	end tell
APPLESCRIPT}
    res =~ /true/
  end
  def Browser.camino_did_load(url)
    res = %x{ps -xc|grep -sq Camino && osascript <<'APPLESCRIPT'
    	tell app "Camino"
    		if windows is not { }
    			set the_url to URL of first window
    			if the_url is "#{url}" then
    				activate
    				do javascript "window.location.reload();"
    				return true
    			end if
    		end if
    	end tell
APPLESCRIPT}
    res =~ /true/
  end
end
