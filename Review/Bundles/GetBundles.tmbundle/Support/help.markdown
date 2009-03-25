---

<center><big>"GetBundles" provides an easy to use interface to install available TextMate bundles which are hosted on textmate.org's svn repositories, on github.com, and on private sites.<br>
  It makes usage of the “Bundle Server” running at textmate.org.<br>Additionally it updates TextMate's “Support Folder” automatically if needed.</big></center>

# Requirements
The computer has to be connected to the internet.

<button onclick="cr()" title="Press to check requirements">Check Requirements</button>
<div id="check" style="margin-left:1cm;"></div>

<script type="text/javascript" charset="utf-8">
  var outstr2 = "";
  function cr () {
    var cmd = 'echo -n "“svn” client found in: ";which svn && svn --version | head -n1;echo -n "<br><br>";';
    cmd += 'echo -n "“TM_SVN” set to: ";echo -n "${TM_SVN:-}";echo -n "<br><br>";';
    cmd += 'echo -n "“unzip” found in: ";which unzip;echo -n "<br><br>";';
    cmd += 'echo -n "“tar” found in: ";which tar;echo -n "<br><br>";';
    cmd += 'echo -n "“ruby”: ";/usr/bin/env ruby -v;echo -n "<br><br>";';
    cmd += 'echo -n "“ping textmate.org”:<br>";ping -c 1 textmate.org | head -n2;echo -n "<br><br>";';
    cmd += 'echo -n "“ping github”:<br>";ping -c 1 github.com | head -n2;echo -n "<br><br>";';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr2;
  }
  function setStr2 (str) {
    outstr2 += str
    document.getElementById("check").innerHTML = outstr2;
  }
</script>


## Installation of svn Repositories
In order to check out bundles hosted on svn repositories, the underlying script makes usage of the UNIX command `svn`. On Mac OSX 10.5.x `svn` is pre-installed. On Mac OSX 10.4.x it must be manually installed  ([see here](http://www.collab.net/downloads/community/)). Furthermore the script recognizes if the user has set TextMate's shell variable `TM_SVN`.

The script will install a bundle by using this command template:
<pre>
  export LC_CTYPE=en_US.UTF-8
  mkdir -p /tmp/TM_GetBundlesTEMP
  cd /tmp/TM_GetBundlesTEMP
  svn export URL_TO_A_BUNDLE.tmbundle
  open "THENAME.tmbundle"
</pre>

If you want to use another `svn` client you can set `TM_SVN` as a TextMate shell variable in TextMate's preferences.

## Installation of zip/tar archive (3rd Party)
For installing a bundle by downloading it as zip/tar archive the script needs `unzip` resp. `tar`. These commands should be installed by default on any Mac OSX system. <button onclick="cfu()" title="Press to execute 'which unzip/tar'">Check for unzip/tar</button> <span id="zip"></span>
<script type="text/javascript" charset="utf-8">
  var outstr1 = "<pre>";
  function cfu () {
    var cmd = 'echo -n "unzip found in: ";which unzip;echo;echo -n "tar found in: ";which tar';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr1;
  }
  function setStr1 (str) {
    outstr1 += str
    document.getElementById("zip").innerHTML = outstr1;
  }
</script>

*Notes:*

* Bundles hosted on GitHub will be installed by downloading the tar archive. 
* `unzip` doesn't support the extraction of filenames containing non-ASCII characters. If you have such problems open the “Info Window”, click at the zip URL, and install that bundle manually.


# General Operating Mode
After invoking "GetBundles" the script downloads the current bundle cache file from TextMate's bundle server and checks all locally installed bundles.

Once you have the list of bundles, you can select one or more and hit <button>Install Bundles</button>, <button>&#x21A9;</button>, or double-click at the bundle to install it/them . After a successful installation, TextMate will open the “Bundle Editor” and “GetBundles” will refresh the installation status in the table. The installation can be cancelled by hitting <button>&#x238B;</button>, as long as TextMate has not already physically installed that bundle (GetBundles uses a temporary folder first). If a given bundle has been already installed on your system by using a versioning control system (svn/git), “GetBundles” cannot touch it. To install, delete, or update  this bundle rename or delete it and install it by using GetBundles or use the versioning control system (svn/git).

"GetBundles" always checks before an installation whether there is an update of TextMate's “Support Folder”. If so it will update it first. This update can also be invoked directly by executing `Update “Support Folder”` in the "Gear Menu". See also [here](#sect_3.1.6.5).

In order to close the "GetBundles" dialog simply hit the <button>&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;</button> or press <button>&#x2318;W</button>.

Each running task, except for Update “Support Folder”, can be cancelled by hitting <button>&#x238B;</button>.

If you hold down the <button>&#x2325;</button> key while installing a bundle the bundle will be opened as **empty** project and will **not** installed.

*Remark:* Please note that if you done any modifications to an already existing bundle these modifications are still valid after an update of that bundle. If you encounter a problem please check for user-defined modifications first.

<pre>
<small><i>Hint</i> The underlying script is written for Ruby 1.8.1 to 1.8.6 and has been tested on Mac OSX 10.4.x and 10.5.x. The script will probably not run under Ruby 1.8.7 (an hybrid version between 1.8.6 and 1.9) resp. 1.9. If Ruby 1.9 is officially released the script will be updated as necessary.
</small>
</pre>

## GetBundles' preference file ##

GetBundles makes usage of the preference file <a onclick='TextMate.system("open \"$HOME/Library/Preferences/com.macromates.textmate.getbundles.plist\"",null);' style="cursor:pointer">com.macromates.textmate.getbundles.plist</a> located in `~/Library/Preferences`. Mainly it stores the sources of each installed TextMate bundle. “GetBundles” has to know the source in order to check if there are updates available. If the user installed “GetBundles” after installing other non-default bundles “GetBundles” tries to resolve the source of each installed bundle automatically. If this fails for some reasons the user will be asked to resolve the relevant sources. In case of 'illogical' status messages this file can be removed manually to try to fix it ( <button title="click to remove 'com.macromates.textmate.getbundles.plist'" onclick='TextMate.system("rm \"$HOME/Library/Preferences/com.macromates.textmate.getbundles.plist\"",null);'>remove</button> ).

This preference file will be deleted automatically after updating the GetBundles bundle. 

# Interface #

## Main Dialog ##

![Main Dialog](images/img_gui.png)

<span style="color:#CCCABA;"><small><i>Dialog on Mac OSX 10.4.x differs slightly</i></small></span>

The core of the dialog is a table listing all discovered bundles.

**Name**

It displays the bundle's name. The name appears in bold face if there is an update available. If a bundle identified by its UUID (Universally Unique Identifier) has more then one source the name will be colorized.

**Status**

<table style="margin-left:1cm">
    <tr><td style="font-size:9pt"><span style="color:silver"><em>empty</em></span></td><td style="font-size:9pt">bundle is not installed</td></tr>
    <tr><td style="font-size:9pt">Ok</td><td style="font-size:9pt">bundle is installed and up-to-date</td></tr>
    <tr><td style="font-size:9pt">XX old</td><td style="font-size:9pt">bundle is installed but there is an update available which was uploaded at least XX later</td></tr>
    <tr><td style="font-size:9pt">installed (source unknown)</td><td style="font-size:9pt">bundle is installed but the source couldn't be resolved</td></tr>
</table>

**Source**

It lists where the bundle is hosted:

<table style="margin-left:1cm">
    <tr><td style="font-size:9pt">Official</td><td style="font-size:9pt"><a href="http:/svn.textmate.org/trunk/Bundles/">http:/svn.textmate.org/trunk/Bundles/</a> </td></tr>
    <tr><td style="font-size:9pt">Review</td><td style="font-size:9pt"><a href="http:/svn.textmate.org/trunk/Review/Bundles/">http:/svn.textmate.org/trunk/Review/Bundles/</a></td></tr>
    <tr><td style="font-size:9pt">Github</td><td style="font-size:9pt"><a href="http://github.com/">http://github.com/</a></td></tr>
    <tr><td style="font-size:9pt">Private</td><td style="font-size:9pt">hosted on private sites</td></tr>
</table>

**Location & Comments**

<table style="margin-left:1cm">
<tr><td style="font-size:9pt">default</td><td style="font-size:9pt"><span style="color:silver;">PATH_TO_TextMate.app</span><a onclick='TextMate.system("open \"`locate TextMate.app/Contents/SharedSupport/Bundle | head -n1`\"",null);' style="cursor:pointer">/Contents/SharedSupport/Bundles</a></td></tr>
<tr><td style="font-size:9pt">Users Pristine</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
<tr><td style="font-size:9pt">Users Lib</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Bundles</a></td></tr>
<tr><td style="font-size:9pt">System Pristine</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
<tr><td style="font-size:9pt">System Lib</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Bundles</a></td></tr>
<tr><td style="font-size:9pt">[local changes]</td><td style="font-size:9pt">there are local changes</td></tr>
<tr><td style="font-size:9pt">(svn)</td><td style="font-size:9pt">bundle is under svn control</td></tr>
<tr><td style="font-size:9pt">(git)</td><td style="font-size:9pt">bundle is under git control</td></tr>
<tr><td style="font-size:9pt">bundle disabled</td><td style="font-size:9pt">the bundle is installed but disabled in the "Bundle Editor" (Filter List…)</td></tr>
<tr><td style="font-size:9pt">bundle deleted</td><td style="font-size:9pt">default bundle is deleted but still installed</td></tr>
<tr><td style="font-size:9pt">date: YY-MM-DD HH:MM</td><td style="font-size:9pt">the revision date of each source for a bundle which has more than one source</td></tr>
</table>

All columns can be sorted by clicking on appropriate part of the header.

It is possible to select more than one bundle at the same time to install all of them.

### Repository Filter ###

The bundle list can be further filtered using these buttons

![](images/img_repo_filter.png)

which will display only those bundles which are hosted on the selected repository:

<table style="margin-left:1cm">
    <tr><td style="font-size:9pt">Official</td><td style="font-size:9pt"><a href="http://svn.textmate.org/trunk/Bundles/">http://svn.textmate.org/trunk/Bundles/</a> </td></tr>
    <tr><td style="font-size:9pt">Under Review</td><td style="font-size:9pt"><a href="http://svn.textmate.org/trunk/Review/Bundles/">http://svn.textmate.org/trunk/Review/Bundles/</a></td></tr>
    <tr><td style="font-size:9pt">3rd Party</td><td style="font-size:9pt">hosted on GitHub <a href="http://github.com/">http://github.com/</a> or privately</td></tr>
</table>

### Searching ###

![](images/img_search.png)

<button>&#x2318;F</button> Enter the search term into the search field to display only those bundles which matches against that term. The search field is set to "search while typing" and it looks at a hidden field which is constructed by appending the data for "name", "description", "author", "repository abbreviation", and "local status abbreviation". Please note that the search will only look for those bundles which are set by the repository filter.

-   Search (literally)

    The field contains the search term literally, case in-sensitive, ignoring diacritics.

-   Search (.\*RegExp.\*)

    The **entire** field matches against the search term which is interpreted as case in-sensitive regular expression.
    -   `CSS.*`<br>looks for bundles which begins with "CSS" ( := "name" begins with "CSS")
    -   `.\*CSS.\*bob.\*`<br>looks for bundles which contains "CSS" followed by any characters and the author name "bob"
    -   `.*CSS.*Aylott.*=i.*`<br>looks for bundles which contains "CSS", the author name "Aylott", and are installed
    -   `.*git.*=g.*=i.*`<br>looks for bundles which contains "git", are hosted on "GitHub", and are installed


#### Additional pre-defined search patterns ####

<table style="margin-left:1cm">
    <tr><td style="font-size:9pt">=o</td><td style="font-size:9pt">lists all bundles marked as O (Official)</td></tr>
    <tr><td style="font-size:9pt">=r</td><td style="font-size:9pt">lists all bundles marked as R (Under Review)</td></tr>
    <tr><td style="font-size:9pt">=g</td><td style="font-size:9pt">lists all bundles marked as G (hosted on github.com)</td></tr>
    <tr><td style="font-size:9pt">=p</td><td style="font-size:9pt">lists all bundles marked as P (hosted privately)</td></tr>
    <tr><td style="font-size:9pt">=i</td><td style="font-size:9pt">lists all bundles which are installed locally</td></tr>
    <tr><td style="font-size:9pt">=u</td><td style="font-size:9pt">lists all bundles for which an update is available</td></tr>
</table>

### Get Bundle Info (“Info Window”)###

<img valign=middle src="images/img_info.png"> <button>&#x2318;I</button> Opens a new window containing available details about the selected bundle. The data will be downloaded from the repository meaning they aren't cached.

### Reveal selected bundle in Finder ###

<img valign=middle src="images/img_bundle.png"> <button>&#x21E7;&#x2318;O</button> Reveals the selected bundle in Finder if it is installed.

### Open selected bundle as TextMate project ###

<img valign=middle src="images/img_tmproj.png"> <button>&#x2318;O</button> Opens the selected bundle as TextMate project if it is installed.

### Gear Action Menu ###

<img valign=middle src="images/img_gear.png"> <button>&#x2318;&#x238B;</button><br>
![](images/img_gear_menu.png)

The "Gear Action Menu" provides some additional commands:

#### Reload Bundle List ####

This command deletes the current list of bundles and reload the bundle list coming from TextMate's bundle server.

#### Refresh Local Bundle List ####

<button>&#x2318;R</button> This command refreshes the status of installed bundles. It should be usually invoked if the user changed something on installed bundles by not using “GetBundles”.

GetBundles will scan these local folders:

<table style="margin-left:1cm">
  <tr><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
  <tr><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
  <tr><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt"><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt"><span style="color:silver;">PATH_TO_TextMate.app</span><a onclick='TextMate.system("open \"`locate TextMate.app/Contents/SharedSupport/Bundle | head -n1`\"",null);' style="cursor:pointer">/Contents/SharedSupport/Bundles</a></td></tr>
</table>



#### Open Bundle Editor ####

<button>^&#x2325;&#x2318;B</button> This opens TextMate's "Bundle Editor".

#### Install all Updates ####

<button>&#x2318;U</button> Installs all available updates only for those installed bundles which are **not** under versioning control. If a bundle is under versioning control please update it manually.


#### Update “Support Folder” ####

By default TextMate ships with a support folder located in <span style="color:silver;">PathToTextMate.app</span>`/Contents/SharedSupport/Support`. After downloading and installing TextMate for the first time or after a new release, the development of TextMate's bundles and additional scripts etc. will be continued. Due to that fact that bundles make use of new or changed features in the "Support Folder", it is sometimes necessary to update it.

An update will be installed physically into `~/Library/Application Support/TextMate/Pristine Copy/Support`. If the folder `/Library/Application Support/TextMate/Support` exists TextMate will use that “Support Folder” which is newer. This mechanism makes it possible that an user can still use its own “Support Folder” regardless of GetBundles' updates.

If TextMate should always use the latest updates done by GetBundles you can simply delete or rename `/Library/Application Support/TextMate/Support` and execute this command again.

 After this update TextMate's shell variable `TM_SUPPORT_PATH` will be set to `/Library/Application Support/TextMate/Support`.

<button onclick='chtmsp()'>Click to check the current content of `TM_SUPPORT_PATH` and version</button> <div id="out"></div>
<script type="text/javascript" charset="utf-8">
  var outstr = "TM_SUPPORT_PATH:<br>";
  function chtmsp () {
    var cmd = 'echo -en "$TM_SUPPORT_PATH"; echo -en " ( version: ";cat "$TM_SUPPORT_PATH/version";echo -en ")<br>"';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr;
  }
  function setStr (str) {
    outstr += str
    document.getElementById("out").innerHTML = outstr;
  }
</script>


#### Show Log ####

<button>&#x2325;&#x21E7;&#x2318;L</button> Opens or closes a drawer displaying GetBundles' console log file. The path to the log file is <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. See also [here](#sect_4).


### Message Field + Cancel current Task ###

![](images/img_message.png)

All activities, errors and warnings will be shown in this message field. To cancel the current task, it is possible to click into the spinning wheel or hit <button>&#x238B;</button>. While installing a bundle, it is possible to cancel the process as long as TextMateGetBundles has not yet physically installed the bundle.

# Log Drawer #

![](images/img_act_log.png)

This drawer shows the current content of the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. The log file will be overwritten each time if you invoke "GetBundles". 

# Keyboard Shortcuts #
<table style="margin-left:1cm">
<tr><td align="center"><button>&#x2318;W</button></td><td style="font-size:9pt">Close the "GetBundles" dialog</td></tr>
<tr><td align="center"><button>&#x21A9;</button></td><td style="font-size:9pt">Install selected bundle(s)</td></tr>
<tr><td align="center"><button>&#x238B;</button></td><td style="font-size:9pt">Cancel current task / Clear search field</td></tr>
<tr><td align="center"><button>&#x2318;&#x238B;</button></td><td style="font-size:9pt">Open "Gear Action Menu"</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;L</button></td><td style="font-size:9pt">Open/Close "Log"</td></tr>
<tr><td align="center"><button>&#x2318;I</button></td><td style="font-size:9pt">Get details about selected bundle</td></tr>
<tr><td align="center"><button>&#x2318;O</button></td><td style="font-size:9pt">Open selected bundle as TextMate project if installed</td></tr>
<tr><td align="center"><button>&#x21E7;&#x2318;O</button></td><td style="font-size:9pt">Reveal selected bundle in Finder if installed</td></tr>
<tr><td align="center"><button>&#x2318;F</button></td><td style="font-size:9pt">Activate the search field</td></tr>
<tr><td align="center"><button>&#x2318;R</button></td><td style="font-size:9pt">Refresh status of locally installed bundles</td></tr>
<tr><td align="center"><button>&#x2318;U</button></td><td style="font-size:9pt">Install all available updates (except for bundles under versioning control)</td></tr>
</table>


# Used Shell Variables

<table style="margin-left:1cm">
  <tr><td style="font-size:9pt"><strong>TM_SVN</strong></td><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt">user-defined absolute path to the <code>svn</code> client</td></tr>
  <tr><td style="font-size:9pt"><strong>TM_GETBUNDLES_REVEAL_BUNDLE_IN</strong></td><td style="font-size:9pt">&nbsp;</td><td style="font-size:9pt">set this variable to the name of that application (e.g. "Path Finder") which should be opened if you pressed "Reveal Bundle in Finder" (if unset "Finder" is its default)</td></tr>
</table>

All variables can be set in TextMate's Preferences, under the item "Advanced".

# Troubleshooting & FAQ #

* "GetBundles" said that no `svn` client is found. What can I do?
>  There are two possible reasons for that: ❶ You haven't yet installed an `svn` client. If so, have a look [here](http://www.collab.net/downloads/community/) and install a client (on Mac OSX 10.5.x it is pre-installed). ❷ TextMate can't find `svn` in `$PATH`. If so, set TextMate's shell variable `TM_SVN` accordingly.

* Why is a known bundle hosted on github.com not listed?
>  There is a convention for naming TextMate bundles hosted on github.com. The project name should end with either "-tmbundle" or ".tmbundle". Due to the fact that not all of the bundles follow this convention, the script uses github's search API. The search terms are "tmbundle", "textmate", and "bundle". Only those projects which end with "tmbundle", "bundle", "textmate bundle", or "tm bundle" are listed. Furthermore, if one of the following key phrases is found within the description tag: "my own", "my personal", "personal bundle", "obsolete", "deprecated", or "work in progress" then the bundle won't be listed. Another convention is that the bundle structure must be at the project's root level, i.e. not hidden in a subfolder of that project. 

* I try to filter one repository, but it is empty. Why?
>  It could happen that one repository is down or not accessible. In this case, the script will skip it. If the list is completely empty, it is very likely that you are not connected to the internet. Also ensure that you have cleared the search field.

* I read the message: "Please check the Log". What should I do?
>  Press <button>&#x2325;&#x21E7;&#x2318;L</button> or open the "Gear Action Menu" and chose "Show Log". Another option is to look at the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">here</a>.

* How can I cancel the current task?
>  Simply press the <button>&#x238B;</button> or click into the spinning wheel. Please note that the physical installation of a bundle cannot be cancelled for safety reasons.

* While installing a bundle a "timeout" message appears. Why?
>  There are several reasons for this. <br>❶ Something went wrong during the installation, i.e. no e.g. connection to the host. <br>❷ The host's response was too slow. You can try it again or look in the “Info Window” for URLs to do it manually. <br>❸ Some commands cannot be executed for some reasons (not found or no permission). <button>&#x2325;&#x21E7;&#x2318;L</button>.<br><br>**In any case, please check the “Log”**

* The description in the list differs to that one in the Info Window. Why?
> There is a convention to "info.plist"'s description key: In the dialog everything before the HTML tag &lt;hr&gt; will be displayed as short description (without any other HTML tags). If the description contains the HTML tag &lt;hr&gt; everything after that tag will be shown as long description.

* “GetBundles” updates the “Support Folder” even if it is up-to-date. Why?
> This only could happen if you install a bundle just after the bundle list appeared. The internal routine to check for an update runs as background process.

* The "status" column lists illogical messages. What can I do?
> This can happen if the installation source of a bundle differs from the stored source in GetBundles' preference file. Try to remove that file manually. [see also here](#sect_2.1)

# Appendix #

## using `git clone` behind a firewall ##

`git clone` uses port 9148. If you are behind a firewall this port might be denied. To check run the following command in the Terminal:
<pre>
  cd ~/Desktop
  git clone git://github.com/timcharper/git-tmbundle.git
</pre>
If nothing happens after "initializing an empty Git repository" or if you see an error message like "fatal: unable to connect a socket (Operation timed out)" then it is very likely that a firewall (mostly not your firewall on the Mac) denies that port.

One simple solution is to install the bundle by downloading it as zip archive (zipball) (see "Advanced Drawer" [here](#sect_4.1.2.1)).

However, if you need to execute `git clone` then you can try the following two things:

* Ask your IT department to open that port for you. 
* Set up `git` to use a proxy, via the shell variable `GIT_PROXY_COMMAND`.

To set up proxy support in `git`, do the following: 

*  check whether the UNIX command `socket` is installed on your system. If not, download the source code from http://www.bibiko.de/socket-1.1.mac.zip <button onclick="TextMate.system('open http://www.bibiko.de/socket-1.1.mac.zip',null)" title="Click to download it by using the default browser">download it</button>, decompress it, and run `make; sudo make install` in the Terminal.
*  ask your IT department for the Web Proxy (HTTP) `PROXY_URL` and the port, `PORT` (maybe it is already set in "System Preferences" > "Network" > "Advanced" > "Proxies" <button onclick='TextMate.system("open /System/Library/PreferencePanes/Network.prefPane/",null)'>Open Network pane</button>)
*  write a shell script e.g. `proxy-git.sh`:
    <pre>
      (echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket PROXY_URL PORT | (read a; read a; cat )
    </pre>
*  save the script to somewhere in your path, like `/usr/local/bin` and make sure that the script is executable
*  add this to the file ~/.profile
    <pre>
    export GIT\_PROXY\_COMMAND=PATH\_TO/proxy-git.sh
    </pre>





# Main Bundle Maintainer

***Date: Mar 25 2009***

<pre>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>
