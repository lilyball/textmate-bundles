
---

<center><big>"Get Bundles" provides an easy to use interface to install available TextMate's bundles which are hosted on macromates' svn repositories and on github.com.</big></center>

# Requirements
The computer has to be connected to the internet.

## svn Repositories
In order to check out bundles hosted on a svn repository the underlying script makes usage of the UNIX command `svn`. On Mac OSX 10.5.x `svn` is pre-installed. On Mac OSX 10.4.x one has to install it in beforehand ([here](http://www.collab.net/downloads/community/)). Furthermore the script recognizes if the user set TextMate's shell variable `TM_SVN`.

## git Repositories
Bundles hosted as a git repository ([a fast version control system](http://git.or.cz/)) can be also installed by downloading it as a zip archive. Thus it is not necessary to install `git`. If `git` is installed and the user did not check the option "using zip archive" in the Advanced Drawer `git` will be used to install the bundle(s). Furthermore the script recognizes if the user set TextMate's shell variable `TM_GIT`.

# General Operating Mode
After invoking "Get Bundles" the script scans these repositories:

* [http://macromates.com/svn/Bundles/trunk/Bundles/](http://macromates.com/svn/Bundles/trunk/Bundles/) (Bundles <font color=blue>B</font>)
* [http://macromates.com/svn/Bundles/trunk/Review/Bundles/](http://macromates.com/svn/Bundles/trunk/Review/Bundles/) (Review <font color=blue>R</font>)
* [http://github.com/](http://github.com/) (GitHub <font color=blue>G</font>)

for TextMate bundles.


In order to increase the speed of scanning the svn repositories the descriptions are saved locally. If a new bundle was uploaded to a svn repository and the local copy of the descriptions will not find a matching description the user will be notified by a message to "Update the Descriptions". This can be done by invoking the gear action command "Update Descriptions". It is recommended to update the locally saved descriptions regularly due to the fact that the script will <b>not</b> recognize if a bundle description was changed meanwhile.


The descriptions of all bundles hosted on github.com will be scanned automatically.


The entire scanning process can be cancelled by hitting <button>&#x238B;</button> or by clicking into the spinning wheel. The bundle list can be rescanned by the gear action command "Rescan Bundle List".


Once you have the list you can select one or more bundles and hit the `Install Bundles` button to install it/them. After installing TextMate will be forced to execute "Reload Bundles". The installation of a bundle or bundles can be cancelled by hitting <button>&#x238B;</button> as long as the script will not install that bundle physically. If a given bundle has been already installed the script will ask you whether that bundle should really be installed. If the user commits it the "old" bundle will be renamed into "THEBUNDLENAME.tmbundleTIMESTAMP" for safety reasons.


The default installation path is `~/Library/Application Support/TextMate/Pristine Copy/Bundles` (Users Lib Pristine). This path can be changed in the "Advanced Drawer" dialog (more detail in 3.2). Please note for svn repositories that the script will perform a clean svn checkout. In order to avoid certain conflicts it is recommended if the user wants to work with a given bundle via svn afterwards to change the installation to `~/Library/Application Support/TextMate/Bundles` (Users Lib Bundles). The same for installing bundles from github.com using `git`.


"Get Bundles" also allows you to do a complete svn checkout of TextMate's Support Library from `http://macromates.com/svn/Bundles/trunk/Support/` into `/Library/Application Support/TextMate`. It can be invoked by clicking at the "Update Support Folder" button in the "Advanced Drawer" dialog.


In order to close the "Get Bundles" dialog simply hit the <button>Close</button> button or press<button>&#x2318;W</button>.

# Interface #

## Main Dialog ##

![Main Dialog](images/img_gui.png)

<span style="color:#CCCABA;"><small><i>Dialog on Mac OSX 10.4.x differs slightly</i></small></span>

### Filtering/Searching ###

You can use the search field to enter a search term. The search function will look for that search term as word initial part in "name" or "description" (for GitHub bundles also for "author") as you type. To sub-filter the list you can select one of these buttons

![](images/img_repo_filter.png)


to display only those bundles which are hosted on the selected repository:

*  Bundles <font color=blue>B</font>:
 [http://macromates.com/svn/Bundles/trunk/Bundles/](http://macromates.com/svn/Bundles/trunk/Bundles/)
*  Review <font color=blue>R</font>: [http://macromates.com/svn/Bundles/trunk/Review/Bundles/](http://macromates.com/svn/Bundles/trunk/Review/Bundles/)
*  GitHub <font color=blue>G</font>: [http://github.com/](http://github.com/)


### Get Bundle Info ###

<button>&#x2318;I</button> <img valign=middle src="images/img_info.png"> Opens a new window containing available details about the selected bundle. The data will be downloaded from the repository.

### Gear Action Menu ###

<button>&#x2318;&#x238B;</button> <img valign=middle src="images/img_gear.png"><br>
![](images/img_gear_menu.png)

### Message Field + Cancel current Task ###


![](images/img_message.png)


### Show Help ###

![](images/img_help.png)


# Advanced Drawer #

![](images/img_adv_drawer.png)

# Activity Log Drawer #

![](images/img_act_log.png)

# Keyboard Shortcuts #
<table>
<tr><td align="center"><button>&#x21A9;</button></td><td>Install selected bundle(s)</td></tr>
<tr><td align="center"><button>&#x2318;I</button></td><td>Get details about selected bundle</td></tr>
<tr><td align="center"><button>&#x238B;</button></td><td>Interrupt current task</td></tr>
<tr><td align="center"><button>&#x2318;&#x238B;</button></td><td>Open Gear Action menu</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;L</button></td><td>Open/Close Activity Log Drawer</td></tr>
<tr><td align="center"><button>&#x2325;&#x21E7;&#x2318;A</button></td><td>Open/Close Advanced Drawer</td></tr>
<tr><td align="center"><button>&#x2318;W</button></td><td>Close the "Get Bundles" dialog</td></tr>
</table>


# Main Bundle Maintainer

***Date: Oct 08 2008***

<pre>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>
