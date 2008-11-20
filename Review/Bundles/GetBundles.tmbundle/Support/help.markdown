---

<center><font color=red><big><big>Under Constructions</big></big></font></center>

<center><big>"GetBundles" provides an easy to use interface to install available TextMate bundles which are hosted on textmate.org's svn repositories and on github.com.</big></center>

# Requirements
The computer has to be connected to the internet.

<button onclick="cr()" title="Press to check requirements">Check Requirements</button>
<div id="check" style="margin-left:1cm;"></div>

<script type="text/javascript" charset="utf-8">
  var outstr2 = "";
  function cr () {
    var cmd = 'echo -n "“svn” client found in: ";which svn && svn --version | head -n1;echo -n "<br><br>";';
    cmd += 'echo -n "“TM_SVN” set to: ";echo -n "${TM_SVN:-}";echo -n "<br><br>";';
    cmd += 'echo -n "“git” client found in: ";which git && git --version | head -n1;echo -n "<br><br>";';
    cmd += 'echo -n "“TM_GIT” set to: ";echo -n "${TM_GIT:-}";echo -n "<br><br>";';
    cmd += 'echo -n "“GIT_PROXY_COMMAND” set to: ";echo -n "${GIT_PROXY_COMMAND:-}";echo -n "<br><br>";';
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

Once you have the list of bundles, you can select one or more and hit <button>Install Bundles</button>, <button>&#x21A9;</button>, or double-click at the bundle to install it/them . After a successful installation, TextMate will open the “Bundle Editor” and GetBundles will refresh the installation status in the table. The installation can be cancelled by hitting <button>&#x238B;</button>, as long as TextMate has not already physically installed that bundle (GetBundles uses a temporary folder first). If a given bundle is already installed on your system by using a versioning control system (svn/git), the script will only inform you about it. To install this bundle rename or delete it and install it by using GetBundles or use the versioning control system (see also for commands in the “Info Window”).

"GetBundles" always checks before an installation whether there is an update of TextMate's “Support Folder”. If so it will update it first. This update can also be invoked directly by executing `Update “Support Folder”`in the "Gear Menu". See also [here](#sect_3.1.3.5).

In order to close the "GetBundles" dialog simply hit the <button>&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;</button> or press <button>&#x2318;W</button>.

Each running task, except for Update “Support Folder”, can be cancelled by hitting <button>&#x238B;</button>.

If you hold down the <button>&#x2325;</button> key while installing a bundle the bundle will be opened as **empty** project and will **not** installed.

<pre>
<small><i>Hint</i> The underlying script is written for Ruby 1.8.1 and up and has been tested on Mac OSX 10.4.x and 10.5.x. The script will probably not run under Ruby 1.9. If Ruby 1.9 is officially released the script will be updated as necessary.
</small>
</pre>

# Interface #

## Main Dialog ##

![Main Dialog](images/img_gui.png)

<span style="color:#CCCABA;"><small><i>Dialog on Mac OSX 10.4.x differs slightly</i></small></span>

The core of the dialog is a table listing all discovered bundles.

The first column indicates where the bundle is hosted:

<table style="margin-left:1cm">
    <tr><td><font color=blue>O</font></td><td>Official Bundles</td><td><a href="http:/svn.textmate.org/trunk/Bundles/">http:/svn.textmate.org/trunk/Bundles/</a> </td></tr>
    <tr><td><font color=blue>R</font></td><td>Bundles under review</td><td><a href="http:/svn.textmate.org/trunk/Review/Bundles/">http:/svn.textmate.org/trunk/Review/Bundles/</a></td></tr>
    <tr><td><font color=blue>G</font></td><td>Bundles hosted on GitHub</td><td><a href="http://github.com/"> http://github.com/</a></td></tr>
    <tr><td><font color=blue>P</font></td><td>privately hosted bundles</td><td></td></tr>
</table>

The second column, "Status", displays the status of locally installed bundles.

<table style="margin-left:1cm">
    <tr><td>✓</td><td>the bundle is already installed</td></tr>
    <tr><td>U</td><td>the bundle is already installed and an update is available</td><td></tr>
    <tr><td valign='top'>..</td><td>indicates that there are some more details available; simply resize that column
      <ul>
        <li>(svn) or (git)<br>
        <small>the bundle is under versioning control</small>
        </li>
        <li>bundle disabled<br>
        <small>the bundle is installed but disabled in the “Bundle Editor”</small>
        </li>
        <li>default bundle deleted<br>
        <small>that default bundle (shipped with TextMate's installation) is physically installed but was deleted</small>
        </li>
      </ul>
      
      </td><td></tr>
</table>


The third column, "Name", displays the bundle's name. 

The fourth column, "Description", displays the description of each bundle, taken from the `info.plist` for svn repositories or from the description tag for git repositories and the author's name resp. nickname.

The fifth column, "Last Modified", displays the date of the last modification. This date is taken from the svn/git repository or from the 'last modified' tag of private hosted bundles. Please note that this date mirrors the last modification date when the bundle server gathered the bundle data, i.e. it could be that a bundle was updated meanwhile (to check this open the “Info Window”).

All columns can be sorted by clicking on appropriate part of the header.

It is possible to select more than one bundle at the same time, and to install all of them.

### Filtering/Searching ###

You can use the search field to enter a search term. This will look for bundles containing the search term, and is case insensitive. This process searches the fields "name", "description", and "author". The list can be further filtered using these buttons

![](images/img_repo_filter.png)

which will display only those bundles which are hosted on the selected repository:

<table style="margin-left:1cm">
    <tr><td><font color=blue>O</font></td><td>Official</td><td><a href="http://macromates.com/svn/Bundles/trunk/Bundles/">http://macromates.com/svn/Bundles/trunk/Bundles/</a> </td></tr>
    <tr><td><font color=blue>R</font></td><td>Under Review</td><td><a href="http://macromates.com/svn/Bundles/trunk/Review/Bundles/">http://macromates.com/svn/Bundles/trunk/Review/Bundles/</a></td></tr>
    <tr><td><font color=blue></font></td><td>3rd Party</td><td>hosted on GitHub <a href="http://github.com/">http://github.com/</a> or privately</td></tr>
</table>

Furthermore there are some shortcuts available for the search field:

<table style="margin-left:1cm">
    <tr><td>=o</td><td>lists all bundles marked as O (Official)</td></tr>
    <tr><td>=r</td><td>lists all bundles marked as R (Under Review)</td></tr>
    <tr><td>=g</td><td>lists all bundles marked as G (hosted on github.com)</td></tr>
    <tr><td>=p</td><td>lists all bundles marked as P (hosted privately)</td></tr>
    <tr><td>=i</td><td>lists all bundles which are installed locally</td></tr>
    <tr><td>=u</td><td>lists all bundles for which an update is available</td></tr>
</table>


### Get Bundle Info (“Info Window”)###

<button>&#x2318;I</button> <img valign=middle src="images/img_info.png"> Opens a new window containing available details about the selected bundle. The data will be downloaded from the repository meaning they aren't cached.
In addition the “Info Window” lists shell commands to checkout resp. update bundle using svn resp. git. 

For a private hosted TextMate bundle it opens the site in the default web browser.

### Gear Action Menu ###

<button>&#x2318;&#x238B;</button> <img valign=middle src="images/img_gear.png"><br>
![](images/img_gear_menu.png)

The "Gear Action Menu" provides some additional commands:

#### Update Descriptions / Update (x missing) ####

This command updates the local copy of descriptions for all svn repositories. It is recommended that this is done regularly in order to be up-to-date. The underlying script will recognize if a new bundle was added but **not** if the description of an pre-existing bundle was changed.

If some descriptions are not found in the local copy of the descriptions, the name of that command will be changed into "Update (x missing)" indicating that x descriptions are missing.

#### Reload Bundle List ####

This command deletes the current list of bundles and reload the bundle list coming from TextMate's bundle server.

#### Refresh Local Bundle List ####

<button>&#x2318;R</button> This command refreshes the status of installed bundles. It is usually invoked if the user deleted bundles by using the “Bundle Editor” or updated bundles by using svn/git.

GetBundles will scan these local folders:

<table style="margin-left:1cm">
  <tr><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
  <tr><td>&nbsp;</td><td><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
  <tr><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td>&nbsp;</td><td><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td>&nbsp;</td><td><span style="color:silver;">PATH_TO_TextMate.app</span><a onclick='TextMate.system("open \"`locate TextMate.app/Contents/SharedSupport/Bundle | head -n1`\"",null);' style="cursor:pointer">/Contents/SharedSupport/Bundles</a></td></tr>
</table>



#### Open Bundle Editor ####

This opens TextMate's "Bundle Editor".

#### Update “Support Folder” ####

By default TextMate, ships with a support folder located in <span style="color:silver;">PathToTextMate.app</span>`/Contents/SharedSupport/Support`. After downloading and installing TextMate for the first time or after a new release, the development of TextMate's bundles and additional scripts etc. will be continued. Due to that fact that bundles make use of new or changed features in the "Support Folder", it is sometimes necessary to update it.

An update will be installed physically into `~/Library/Application Support/TextMate/Pristine Copy/Support`. If the folder `/Library/Application Support/TextMate/Support` doesn't exist GetBundles will create a symbolic link  `/Library/Application Support/TextMate/Support` pointing to `~/Library/Application Support/TextMate/Pristine Copy/Support`. This mechanism makes it possible that an user can still use its own “Support Folder” regardless of GetBundles' updates.

If TextMate should always use the latest updates done by GetBundles you can simply delete or rename `/Library/Application Support/TextMate/Support` and execute this command again.

 After this update TextMate's shell variable `TM_SUPPORT_PATH` will be set to `/Library/Application Support/TextMate/Support`.

<button onclick='chtmsp()'>Click to check the current content of `TM_SUPPORT_PATH` and version</button> <div id="out"></div>
<script type="text/javascript" charset="utf-8">
  var outstr = "TM_SUPPORT_PATH:<br>";
  function chtmsp () {
    var cmd = 'echo -en "$TM_SUPPORT_PATH"; echo -en " (version: ";cat "$TM_SUPPORT_PATH/version";echo -en ")<br>"';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr;
  }
  function setStr (str) {
    outstr += str
    document.getElementById("out").innerHTML = outstr;
  }
</script>


#### Show Log ####

<button>&#x2325;&#x21E7;&#x2318;A</button> Opens or closes a drawer displaying GetBundles' console log file. The path to the log file is <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. See also [here](#sect_5).


### Message Field + Cancel current Task ###

![](images/img_message.png)

All activities and warnings will be shown in this message field. To cancel the current task, it is possible to click the spinning wheel or hit <button>&#x238B;</button>. While installing a bundle, it is possible to cancel the process as long as the script has not yet physically installed the bundle.

### Show Help ###

<img valign=middle src="images/img_help.png"> Opens that "Help" window.

### Installation

#### Target Folder ####

By using this pull down menu you can specify the installation folder for all selected bundles.

<table style="margin-left:1cm">
  <tr><td>Users Lib Pristine</td><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Pristine Copy/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Pristine Copy/Bundles</a></td></tr>
  <tr><td>Users Lib Bundles</td><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">~/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td>Lib Bundles</td><td>&nbsp;</td><td><a onclick='TextMate.system("open \"/Library/Application Support/TextMate/Bundles\"",null);' style="cursor:pointer">/Library/Application Support/TextMate/Bundles</a></td></tr>
  <tr><td>App Bundles</td><td>&nbsp;</td><td><span style="color:silver;">PATH_TO_TextMate.app</span><a onclick='TextMate.system("open \"`locate TextMate.app/Contents/SharedSupport/Bundle | head -n1`\"",null);' style="cursor:pointer">/Contents/SharedSupport/Bundles</a></td></tr>
  <tr><td>Users Desktop</td><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Desktop\"",null);' style="cursor:pointer">~/Desktop</a></td></tr>
  <tr><td>Users Downloads</td><td>&nbsp;</td><td><a onclick='TextMate.system("open \"$HOME/Downloads\"",null);' style="cursor:pointer">~/Downloads</a></td></tr>
</table>

The default installation folder is **Users Lib Pristine**. This is the same folder that will be chosen if you install a bundle by double-clicking a downloaded bundle. If you want to use `svn` or `git` afterwards with a bundle, it is recommended that you choose **Users Lib Bundles**. If you want the installed bundles to be available for all users, choose **Lib Bundles**.

*Note:* **App Bundles** as installation folder should only be used in exceptional cases!

For testing purposes, you can choose **Users Desktop** or **Users Downloads** as the installation folder. Bundles which are downloaded here will **not** be installed. 

# Log Drawer #

![](images/img_act_log.png)

This drawer shows the current content of the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. The log file will be overwritten each time if you invoke "GetBundles". 

# Additional Keyboard Shortcuts #
<table style="margin-left:1cm">
<tr><td align="center"><button>&#x21A9;</button></td><td>Install selected bundle(s)</td></tr>
<tr><td align="center"><button>&#x2318;I</button></td><td>Get details about selected bundle</td></tr>
<tr><td align="center"><button>&#x238B;</button></td><td>Cancel current task</td></tr>
<tr><td align="center"><button>&#x2318;&#x238B;</button></td><td>Open "Gear Action Menu"</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;L</button></td><td>Open/Close "Log"</td></tr>
<tr><td align="center"><button>&#x2318;W</button></td><td>Close the "GetBundles" dialog</td></tr>
</table>

# Used Shell Variables

<table style="margin-left:1cm">
  <tr><td><strong>TM_SVN</strong></td><td>&nbsp;</td><td>absolute path to the `svn` client</td></tr>
  <tr><td><strong>TM_GIT</strong></td><td>&nbsp;</td><td>absolute path to the `git` client</td></tr>  
</table>

Both variables can be set in TextMate's Preferences, under the item "Advanced".

# Troubleshooting & FAQ #

* "GetBundles" said that no `svn` client is found. What can I do?
>  There are two possible reasons for that: ❶ You haven't yet installed an `svn` client. If so, have a look [here](http://www.collab.net/downloads/community/) and install a client (on Mac OSX 10.5.x it is pre-installed). ❷ TextMate can't find `svn` in `$PATH`. If so, set TextMate's shell variable `TM_SVN` accordingly.

* Why is a known bundle hosted on github.com not listed?
>  There is a convention for naming TextMate bundles hosted on github.com. The project name should end with either "-tmbundle" or ".tmbundle". Due to the fact that not all of the bundles follow this convention, the script uses github's search API. The search terms are "tmbundle", "textmate", and "bundle". Only those projects which end with "tmbundle", "bundle", "textmate bundle", or "tm bundle" are listed. Furthermore, if one of the following key phrases is found within the description tag: "my own", "my personal", "personal bundle", "obsolete", "deprecated", or "work in progress" then the bundle won't be listed. Another convention is that the bundle structure must be at the project's root level, i.e. not hidden in a subfolder of that project. 

* I try to filter one repository, but it is empty. Why?
>  It could happen that one repository is down or not accessible. In this case, the script will skip it. If the list is completely empty, it is very likely that you are not connected to the internet. Also ensure that you have cleared the search field.

* I press the Help button but no "Help" is shown. Why?
>  Due to an internal issue, the script has to call the bundle's "Help" command by using AppleScript. This AppleScript only works properly if you have enabled access for assistive devices in "System Preferences" > "Universal Access" > "Enable access for assistive devices". <button onclick='TextMate.system("open /System/Library/PreferencePanes/UniversalAccessPref.prefPane/",null)'>Click to open that pane</button>

* The computer beeps if I press the Help button. Why?
>  Due to an internal issue the script has to order out the front most document window. This is done by a command which is misused. This issue will be fixed in the near future. In other words don't worry about it.

* I read the message: "Please check the Log". What should I do?
>  Press <button>&#x2325;&#x21E7;&#x2318;L</button> or open the "Gear Action Menu" and chose "Show Log". Another option is to look at the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">here</a>.

* How can I cancel the current task?
>  Simply press the <button>&#x238B;</button> or click into the spinning wheel. Please note that the physical installation of a bundle cannot be cancelled for safety reasons.

* While installing a bundle a "timeout" message appears. Why?
>  There are several reasons for this. <br>❶ Something went wrong during the installation, i.e. no e.g. connection to the host. <br>❷ The host's response was too slow. You can try it again or look in the “Info Window” for URLs to do it manually. <br>❸ Some commands cannot be executed for some reasons (not found or no permission). <button>&#x2325;&#x21E7;&#x2318;L</button>.<br><br>**In any case, please check the “Log”**

* The description in the list differs to that one in the Info Window. Why?
> There is a convention to "info.plist"'s description key: In the dialog everything before the HTML tag &lt;hr&gt; will be displayed as short description (without any other HTML tags). If the description contains the HTML tag &lt;hr&gt; everything after that tag will be shown as long description.

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

***Date: Nov 20 2008***

<pre>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>
