---

<center><font color="red"><big><big>This is a tentative version!<br>This bundle will be rewritten entirely in the near future!</big></big></font></center>

<center><big>"GetBundles" provides an easy to use interface to install available TextMate's bundles which are hosted on macromates' svn repositories and on github.com.</big></center>

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
    cmd += 'echo -n "“ruby”: ";/usr/bin/env ruby -v;echo -n "<br><br>";';
    cmd += 'echo -n "“ping macromates”:<br>";ping -c 1 macromates.com | head -n2;echo -n "<br><br>";';
    cmd += 'echo -n "“ping github”:<br>";ping -c 1 github.com | head -n2;echo -n "<br><br>";';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr2;
  }
  function setStr2 (str) {
    outstr2 += str
    document.getElementById("check").innerHTML = outstr2;
  }
</script>


## svn Repositories
In order to check out bundles hosted on a svn repository the underlying script makes usage of the UNIX command `svn`. On Mac OSX 10.5.x `svn` is pre-installed. On Mac OSX 10.4.x one has to install it in beforehand ([here](http://www.collab.net/downloads/community/)). Furthermore the script recognizes if the user set TextMate's shell variable `TM_SVN`. See also [here](#sect_2.1).

## git Repositories
Bundles hosted as a git repository ([a fast version control system](http://git.or.cz/)) can be also installed by downloading it as a zip archive. Thus it is not necessary to install `git`. If `git` is installed and the user did not check the option "using zip archive" in the Advanced Drawer `git clone` will be used to install the bundle(s). Furthermore the script recognizes if the user set TextMate's shell variable `TM_GIT`. See also [here](#sect_2.2).

For installing a bundle by downloading it as zip archive the script needs `unzip`. This command should be installed as default on any Mac OSX. <button onclick="cfu()" title="Press to execute 'which unzip'">Check for unzip</button> <span id="zip"></span>
<script type="text/javascript" charset="utf-8">
  var outstr1 = "";
  function cfu () {
    var cmd = 'echo -n "found in: ";which unzip';
    myCommand = TextMate.system(cmd, function (task) { });
    myCommand.onreadoutput = setStr1;
  }
  function setStr1 (str) {
    outstr1 += str
    document.getElementById("zip").innerHTML = outstr1;
  }
</script>

### using `git clone` behind a firewall ###

`git clone` uses the port 9148. If you are behind a firewall it could be that this port is denied. To check it run for instance that command in the Terminal:
<pre>
  cd ~/Desktop
  git clone git://github.com/timcharper/git-tmbundle.git
</pre>
If nothing happens after initializing an empty Git repository or if you see an error message like "fatal: unable to connect a socket (Operation timed out)" then it is very likely that a firewall (mostly not your firewall on the Mac) denies that port.

One simple solution is to install that bundle by downloading it as zip archive (zipball) (see "Advanced Drawer" [here](#sect_4.1.2.1)).

But if you need to execute `git clone` then you can try the following:<br>
You can ask your IT department to open that port for you. But in many cases the IT department says "no" for some reasons. Fortunately `git` supports to set up a proxy via the shell variable `GIT_PROXY_COMMAND`.<br>

*  check whether the UNIX command `socket` is installed at your system. If not, download the source code from http://www.bibiko.de/socket-1.1.mac.zip <button onclick="TextMate.system('open http://www.bibiko.de/socket-1.1.mac.zip',null)" title="Click to download it by using the default browser">download it</button>, decompress it, and run `make; sudo make install` in the Terminal.
*  ask your IT department for a Web Proxy (HTTP) PROXY_URL and the port PORT (maybe it is already set in "System Preferences" > "Network" > "Advanced" > "Proxies" <button onclick='TextMate.system("open /System/Library/PreferencePanes/Network.prefPane/",null)'>Click to open that pane</button>)
*  write a shell script e.g. `proxy-git.sh`:
<pre>
  (echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket PROXY_URL PORT | (read a; read a; cat )
</pre>
*  save that shell script to a reachable place like `/usr/local/bin` and make sure that the script is executable
*  add to the file ~/.profile
<pre>
export GIT_PROXY_COMMAND=PATH_TO/proxy-git.sh
</pre>



# General Operating Mode
After invoking "GetBundles" the script scans these repositories:

* [http://macromates.com/svn/Bundles/trunk/Bundles/](http://macromates.com/svn/Bundles/trunk/Bundles/) (Bundles <font color=blue>B</font>)
* [http://macromates.com/svn/Bundles/trunk/Review/Bundles/](http://macromates.com/svn/Bundles/trunk/Review/Bundles/) (Review <font color=blue>R</font>)
* [http://github.com/](http://github.com/) (GitHub <font color=blue>G</font>)

for TextMate bundles.


In order to increase the speed of scanning the svn repositories the descriptions are saved locally. If a new bundle was uploaded to a svn repository and the local copy of the descriptions will not find a matching description the user will be notified by a message to "Update the Descriptions". This can be done by invoking the "Gear Action Menu" command "Update Descriptions". It is recommended to update the locally saved descriptions regularly due to the fact that the script will <b>not</b> recognize if a bundle description was changed meanwhile.


The descriptions of all bundles hosted on github.com will not be cached locally.


The entire scanning process can be cancelled by hitting <button>&#x238B;</button> or by clicking into the spinning wheel. The bundle list can be rescanned by the "Gear Action Menu" command "Rescan Bundle List".


Once you have the list you can select one or more bundles and hit <button>Install Bundles</button> to install it/them. After installing TextMate will be forced to execute "Reload Bundles". The installation of a bundle or bundles can be cancelled by hitting <button>&#x238B;</button> as long as the script will not install that bundle physically (it uses a temporary folder first). If a given bundle has been already installed the script will ask you whether that bundle should really be installed. If the user confirms it the "old" bundle will be renamed into "THEBUNDLENAME.tmbundleTIMESTAMP" for safety reasons.

*Example* Java.tmbundle09022008085943 means a backup of Java.tmbundle done at Feb 9 2008, 08:59:43.


The default installation path is `~/Library/Application Support/TextMate/Pristine Copy/Bundles` (Users Lib Pristine). This path can be changed in the "Advanced Drawer" dialog (more detail [here](#sect_4)). Please note for svn repositories that the script will perform a clean svn checkout. In order to avoid certain conflicts it is recommended if the user wants to work with a given bundle via `svn` afterwards to change the installation to `~/Library/Application Support/TextMate/Bundles` (Users Lib Bundles). The same for installing bundles from github.com using `git clone`.


"GetBundles" also allows you to do a complete svn checkout of TextMate's Support Library from `http://macromates.com/svn/Bundles/trunk/Support/` into `/Library/Application Support/TextMate`. It can be invoked by hitting <button>Update Support Folder</button>" in the "Advanced Drawer" dialog.


In order to close the "GetBundles" dialog simply hit <button>&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;</button> or press <button>&#x2318;W</button>.

<pre>
<small><i>Hint</i> The underlying script is written in Ruby 1.8 attested on Mac OSX 10.4.x and 10.5.x. It can be supposed that the script will not run with Ruby 1.9. If Ruby 1.9 is officially released the script will be updated if needed.
</small>
</pre>

## svn Installation ##

The script will install a bundle by using this command template:
<pre>
  export LC_CTYPE=en_US.UTF-8
  mkdir -p /tmp/TM_GetBundlesTEMP
  cd /tmp/TM_GetBundlesTEMP
  svn co --no-auth-cache --non-interactive URL_TO_A_BUNDLE.tmbundle
  if info.plist is found
    if BUNDLE.tmbundle already exists in INST_FOLDER
      ask for replacing
        if YES
          rename old BUNDLE by appending a time stamp
        else
          exit
    else
      cp -R /tmp/TM_GetBundlesTEMP/BUNDLE.tmbundle INST_FOLDER.BUNDLE.tmbundle
  else
    exit
  rm -f /tmp/TM_GetBundlesTEMP
  Reload Bundles
</pre>

If you want to use an other `svn` client you can set `TM_SVN` as a TextMate shell variable in TextMate's preferences.

## git Installation ##

### git clone ###

If `git` is installed and the checkbox "using zip archive" in the "Advanced Drawer" is unchecked the script will use that command template:

<pre>
  mkdir -p /tmp/TM_GetBundlesTEMP
  git clone URL_TO_A_BUNDLE.git /tmp/TM_GetBundlesTEMP/BUNDLE
  if info.plist is found
    if BUNDLE.tmbundle already exists in INST_FOLDER
      ask for replacing
        if YES
          rename old BUNDLE by appending a time stamp
        else
          exit
    else
      cp -R /tmp/TM_GetBundlesTEMP/BUNDLE.tmbundle INST_FOLDER.BUNDLE.tmbundle
  else
    exit
  rm -f /tmp/TM_GetBundlesTEMP
  Reload Bundles
</pre>

If you want to use an other `git` client you can set `TM_GIT` as a TextMate shell variable in TextMate's preferences.

### git via downloading the zip archive ###

If `git` is not installed or the checkbox "using zip archive" in the "Advanced Drawer" is checked the script will use that command template:

<pre>
  download URLBUNDLE/zipball/master to /tmp/TM_GetBundlesTEMP/github.tmbundle.zip
  unzip /tmp/TM_GetBundlesTEMP/github.tmbundle.zip -d /tmp/TM_GetBundlesTEMP/
  remove ID by using unzip
  if info.plist is found
    if BUNDLE.tmbundle already exists in INST_FOLDER
      ask for replacing
        if YES
          rename old BUNDLE by appending a time stamp
        else
          exit
    else
      cp -R /tmp/TM_GetBundlesTEMP/BUNDLE.tmbundle INST_FOLDER.BUNDLE.tmbundle
  else
    exit
  rm -f /tmp/TM_GetBundlesTEMP
  Reload Bundles
</pre>

# Interface #

## Main Dialog ##

![Main Dialog](images/img_gui.png)

<span style="color:#CCCABA;"><small><i>Dialog on Mac OSX 10.4.x differs slightly</i></small></span>

The core of the dialog is a table listing all found bundles.

The first column gives you the information where the bundle is hosted:

<table style="margin-left:1cm">
    <tr><td><font color=blue>B</font></td><td>Bundles</td><td><a href="http://macromates.com/svn/Bundles/trunk/Bundles/">http://macromates.com/svn/Bundles/trunk/Bundles/</a> </td></tr>
    <tr><td><font color=blue>R</font></td><td>Review</td><td><a href="http://macromates.com/svn/Bundles/trunk/Review/Bundles/">http://macromates.com/svn/Bundles/trunk/Review/Bundles/</a></td></tr>
    <tr><td><font color=blue>G</font></td><td>GitHub</td><td><a href="http://github.com/">http://github.com/</a></td></tr>
</table>

The second column "Name" displays the actual name. Please note that names for bundles hosted on GitHub could differ to the actual installed bundle name in TextMate according to the git project's name given by the author.

The third column "Description" displays the description of bundle taken from the info.plist for svn repositories and the description tag for git repositories.

All three columns can be sorted by clicking into the header.

It is possible to select more than one bundle at the same time to install all of them.

### Filtering/Searching ###

You can use the search field to enter a search term to look for bundles containing the search term (case insensitively). The search only looks for it in the fields "name" and "description" (for GitHub bundles also for "author"). To sub-filter the list you can select one of these buttons

![](images/img_repo_filter.png)


to display only those bundles which are hosted on the selected repository:

<table style="margin-left:1cm">
    <tr><td><font color=blue>B</font></td><td>Bundles</td><td><a href="http://macromates.com/svn/Bundles/trunk/Bundles/">http://macromates.com/svn/Bundles/trunk/Bundles/</a> </td></tr>
    <tr><td><font color=blue>R</font></td><td>Review</td><td><a href="http://macromates.com/svn/Bundles/trunk/Review/Bundles/">http://macromates.com/svn/Bundles/trunk/Review/Bundles/</a></td></tr>
    <tr><td><font color=blue>G</font></td><td>GitHub</td><td><a href="http://github.com/">http://github.com/</a></td></tr>
</table>


### Get Bundle Info ###

<button>&#x2318;I</button> <img valign=middle src="images/img_info.png"> Opens a new window containing available details about the selected bundle. The data will be downloaded from the repository.

### Gear Action Menu ###

<button>&#x2318;&#x238B;</button> <img valign=middle src="images/img_gear.png"><br>
![](images/img_gear_menu.png)

The "Gear Action Menu" provides some additional commands:

#### Update Descriptions / Update (x missing) ####

This command updates the local copy of descriptions for all svn repositories. It is recommended to update this copy regularly in order to be up-to-date. The underlying script will only recognize if a new bundle was added but **not** if the description of an already existing bundle was changed meanwhile.

If some descriptions are not found in the local copy of the descriptions the name of that command will be changed into "Update (x missing)" indicating that x descriptions are missing.

#### Rescan Bundle List ####

This command deletes the current list of bundles and rescans all repositories.

#### Show Activity Log Drawer ####

<button>&#x2325;&#x21E7;&#x2318;A</button> Opens or closes a drawer displaying GetBundles' console log file. The path to the log file is <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. See also [here](#sect_5).

#### Show Advanced Drawer ####

<button>&#x2325;&#x21E7;&#x2318;L</button> Opens or closes a drawer with advanced commands. More details [here](#sect_4).

### Message Field + Cancel current Task ###

![](images/img_message.png)

All activities and warnings will be shown in that message field. To cancelled the current task it is possible to click into the spinning wheel or hit <button>&#x238B;</button>. While installing a bundle it is possible to cancel the process as long as the script does not install the bundle physically.

### Show Help ###

<img valign=middle src="images/img_help.png"> Opens that "Help" window.

# Advanced Drawer #

![](images/img_adv_drawer.png)

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

The default installation folder is **Users Lib Pristine**. The same folder will be chosen if you install a bundle by double-clicking at a downloaded bundle. If you want to use `svn` or `git` afterwards with a bundle it is recommended to choose **Users Lib Bundles** or if these bundles should be available for all users **Lib Bundles**.

*Note:* **App Bundles** as installation folder should only be used in cases of exception!

For testing you can choose **Users Desktop** or **Users Downloads** as installation folder. Bundles which are downloaded here will **not** be installed. 

#### Timeout ####

Each task is wrapped into a timeout block. This means after x seconds (default 30sec) the task will be interrupted and a warning message will be displayed. If you open the "Activity Log Drawer" and you see that the script actually did a `svn checkout` or a `git clone` you can increase the "Timeout". This probably happens if you are using an internet connection with a lower band width or the host's respond is too slow.

If you want to cancel the current task you can press <button>&#x238B;</button> or click into the spinning wheel.

### git Installation ###

#### using zip archive ####

If you check this checkbox you can tell the script to install a bundle hosted on GitHub by downloading the zip archive (zipball) even if `git` is installed. This is especially useful if you have installed `git` but sitting behind a firewall which denies the git port.

### Reveal Target Folder in Finder ###

This opens the selected folder in "Finder".

### Open Bundle Editor ###

This opens TextMate's "Bundle Editor".

### Update Support Folder ###

As default TextMate ships with a support folder located in <span style="color:silver;">PathToTextMate.app</span>`/Contents/SharedSupport/Support`. After downloading and installing TextMate for the first time or after a new release the development of TextMate's bundles and additional scripts etc. will be continued. Due to that fact it could happen that a bundle makes usage of new or changed features in the "Support Folder". For that reason it is sometimes necessary to update that "Support Folder".

An update will be installed into `/Library/Application Support/TextMate/Support`. After this update TextMate's shell variable `TM_SUPPORT_PATH` will be set to that folder.

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
# Activity Log Drawer #

![](images/img_act_log.png)

This drawer shows the current content of the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">~/Library/Logs/TextMateGetBundles.log</a>. The log file will be overwritten each time if you invoke "GetBundles". 

# Additional Keyboard Shortcuts #
<table style="margin-left:1cm">
<tr><td align="center"><button>&#x21A9;</button></td><td>Install selected bundle(s)</td></tr>
<tr><td align="center"><button>&#x2318;I</button></td><td>Get details about selected bundle</td></tr>
<tr><td align="center"><button>&#x238B;</button></td><td>Cancel current task</td></tr>
<tr><td align="center"><button>&#x2318;&#x238B;</button></td><td>Open "Gear Action Menu"</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;L</button></td><td>Open/Close "Activity Log Drawer"</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;A</button></td><td>Open/Close "Advanced Drawer"</td></tr>
<tr><td align="center"><button>&#x2318;W</button></td><td>Close the "GetBundles" dialog</td></tr>
</table>

# Used Shell Variables

<table style="margin-left:1cm">
  <tr><td><strong>TM_SVN</strong></td><td>&nbsp;</td><td>absolute path to the `svn` client</td></tr>
  <tr><td><strong>TM_GIT</strong></td><td>&nbsp;</td><td>absolute path to the `git` client</td></tr>  
</table>

Both variables can be set in TextMate's Preferences Pane under the item "Advanced".

# Troubleshooting & FAQ #

* "GetBundles" said that no `svn` client is found. What can I do?
>  There're two reasons for that: ❶ You haven't yet installed a `svn` client. If so, have a look [here](http://www.collab.net/downloads/community/) and install a client (on Mac OSX 10.5.x it is pre-installed). ❷ TextMate can't find `svn` in `$PATH`. If so, set TextMate's shell variable `TM_SVN` accordingly.

* Why is a known bundle hosted on github.com not listed?
>  There is a convention for naming a TextMate bundle hosted on github.com. The project name should end with "-tmbundle" or ".tmbundle". Due to the fact that not all of these bundles followed that convention the script is using github's search API. The search terms are "tmbundle", "textmate", and "bundle". Only those projects are listed which end with "tmbundle","bundle", "textmate bundle", or "tm bundle". Furthermore if one of these key phrases are found within the description tag: "my own", "my personal", "personal bundle", "obsolete", "deprecated", or "work in progress" the bundle won't be listed. An other convention is that the bundle structure must be at the project's root level, i.e. not hidden in a subfolder of that project. 

* I try to filter one repository, but it is empty. Why?
>  It could happen that one repository is down or not accessible. Then the script will skip it. If the list is empty at all it is very likely that you are not connected to the internet. An other issue is to clear the search field.

* I press the Help button but no "Help" will be shown. Why?
>  Due to an internal issue the script has to call the bundle's "Help" command by using AppleScript. This AppleScript only works properly if you enabled in "System Preferences" > "Universal Access" > "Enable access for assistive devices". <button onclick='TextMate.system("open /System/Library/PreferencePanes/UniversalAccessPref.prefPane/",null)'>Click to open that pane</button>

* The computer beeps if I press the Help button. Why?
>  Due to an internal issue the script has to order out the front most document window. This is done by a command which is misused. This issue will be fixed in the near future. In other words don't care about it.

* I read the message: "Please check the Activity Log". What to do?
>  Press <button>&#x2325;&#x21E7;&#x2318;L</button> or click at the "Gear Action Menu" and chose "Show Activity Log". An other option is to look at the log file <a onclick='TextMate.system("open \"$HOME/Library/Logs/TextMateGetBundles.log\"",null);' style="cursor:pointer">here</a>.

* How can I cancel the current task?
>  Simply press <button>&#x238B;</button> or click into the spinning wheel. Please note that the physical installation of a bundle cannot be cancelled for safety reasons.

* What does it mean: "No info.plist is found"?
>  Each bundle must contain a file called "info.plist". Otherwise TextMate is not able to install it properly. If you encountered that case please mail it to TextMate's mailing list (<a href="mailto:textmate@lists.macromates.com">textmate@lists.macromates.com</a>).

* What does "…not yet downloaded…" mean in the description?
>  This phrase will only be displayed if the local copy of your svn descriptions doesn't contain a description for that bundle. To update the local copy simply go to the "Gear Action Menu" and invoke "Update (x missing)".

* Why does the name of a bundle listed in "GetBundles" differs to the actually installed name?
> This could happen esp. for bundles hosted on GitHub. The actual name shown in TextMate's Bundles list is set in the file "info.plist". Within the dialog's list the name of that project will be shown in the column "name", **not** the name set in "info.plist". 

* While installing a bundle a "timeout" message appears. Why?
>  There're some reasons for that. <br>❶ Something went wrong while the installation, i.e. no e.g. connection to the host. <br>❷ The host's respond is too slow. To fix that you can increase the timeout. See [here](#sect_4.1.1.2). <br>❸ Some commands cannot be executed for some reasons (not found or no permission). <button>&#x2325;&#x21E7;&#x2318;L</button>. <br>❹ If you were installing a bundle by using `git clone` and you are sure that the host is not down then it is very likely that a firewall denies `git`'s port 9148. If so please read more [here](#sect_1.2.1).<br><br>**Thus in any case please check the "Activity Log"**

* The description in the list differs to that one in the Info Window. Why?
> There is a convention to "info.plist"'s description key: In the dialog everything before the HTML tag &lt;hr&gt; will be displayed as short description (without any other HTML tags). If the description contains the HTML tag &lt;hr&gt; everything after that tag will be shown as long description.

* For some reasons I want to reconstruct an overwritten bundle. How can I do this?
>  If you replaced an existing bundle the old bundle will be renamed according to BUNDLENAME.tmbundleTIMESTAMP. Simply delete BUNDLENAME.tmbundle and rename BUNDLENAME.tmbundleTIMESTAMP to BUNDLENAME.tmbundle and perform "Reload Bundles".

# Main Bundle Maintainer

***Date: Oct 10 2008***

<pre>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>
