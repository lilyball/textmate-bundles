
<center><font color=red>Both this bundle and the Objective-J framework are still under constructions.

Any feedback about bugs or improvements is highly welcomed!</font></center>

# Introduction

Cappuccino <a href="http://cappuccino.org">cappuccino.org</a>  is an open source framework that makes it easy to build desktop-caliber applications that run in a web browser or in TextMate's HTML output window.

# Installation

In order to use that bundle you have to download the cappuccino framework <a href="http://cappuccino.org/tools">cappuccino.org/tools</a> and follow the installation instructions. After the installation you have to set the global shell variable `OBJJ_HOME`. One way would be to insert 

`export OBJJ_HOME=/path/to/the/framework` in `~/.profile`.

Please make sure that the documentation folder `Documentation` will also be found in `OBJJ_HOME`.

# Commands

## Run
<button>&#x2318;R&nbsp;</button>
Run the current cappuccino web application in TextMate's HTML output window.

If you are inside of an Objective-J file (file extension .j) this command will look for a file `index.html` starting at the current folder and upwards within the file hierarchy or if you are working with a project it will look for it at the project's root path.

If the start HTML site differs you can set the shell variable `TM_OBJJ_MASTER_FILE` within a project.

## Run in Browser
<button>&#x21E7;&#x2318;R&nbsp;</button>
Run the current cappuccino web application in the default web browser.

If you are inside of an Objective-J file (file extension .j) this command will look for a file `index.html` starting at the current folder and upwards within the file hierarchy or if you are working with a project it will look for it at the project's root path.

If the start HTML site differs you can set the shell variable `TM_OBJJ_MASTER_FILE` within a project.

# Shell Variables #

## OBJJ_HOME ##

This variable must be set to the root path of the Objective-J framework (not to the subfolder `framework`) in order to work with this bundle properly. See more under [Installation…](#sect_2).

## TM&#95;OBJJ&#95;MASTER&#95;FILE ##

This variable contains the path to the application's start HTML site. If not set 


# Main Bundle Maintainer

***Date: Sep 23 2008***

<pre>
-  Tom Robinson&nbsp;<a href="mailto:tom@280north.com">tom@280north.com</a>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>

