<img align=right src="lib/TMRdaemonLogo.icns" width=60>
# Introduction

The "R Console (Rdaemon)" bundle allows to run the command-line version of R ***inside*** of TextMate using a daemon which runs within an hidden pseudo terminal. In addition it provides some commands which allow to use that bundle as a kind of GUI.

The entire source code is written in scripting languages (Ruby, Perl, HTML (JavaScript), AppleScript, and Bash) hence the user can modify it rather easily in order to adapt it to its own purposes.

***Important*** This bundle is an extension to the "R Bundle" which comes with syntax highlighting, help functionality, etc. Thus it is recommended to install that bundle as well.

<big><font color=blue> ⇢ This bundle requires a R version greater R 2.8.</font></big>

# Installation

In order to work with the Rdaemon it is necessary to install the Rdaemon in `~/Library/Application Support/Rdaemon`.

Simply do execute the command "Install Rdaemon" (Bundle Menu > Rdaemon Tools > Install Rdaemon) or set the language of the current document to `R Console (Rdaemon)`, type "installrd", and press "&#x21E5;".

***Please note that the folder `~/Library/Application Support/Rdaemon` may not yet exist.***

# General Usage

## Start Rdaemon<a name="start">

To start Rdaemon set the language grammar of a document to "R Console (Rdaemon)" or to "R Console (Rdaemon) Plain" (R's output will not be syntax highlighted) and either type `start` and press  <button>&#x21E5;</button> or press <button>&#x2325;&#x2318;C</button> for the command menu "General Control" and choose "Start Rdaemon". The start procedure will take a few seconds.

An other option to start Rdaemon is to press <button>^&#x2325;&#x2318;R</button>. This will start the Rdaemon and it will open the Rsession project.

## Quit Rdaemon

To quit the Rdaemon you can either use the command menu "General Control" <button>&#x2325;&#x2318;C</button> and choose one of the following commands: "Quit and Don't Save", "Quit and Save" or type "q" and press <button>&#x21E5;</button>.

If an exceptional case occurs you can kill the Rdaemon process by executing "Bundle Menu > Rdaemon Tools > Force Kill Rdaemon" or type "kill" and press  <button>&#x21E5;</button>.

Of course, it is also possible to execute the R command "q()" or "quit()" within the console window.

## Execute a R command or a bunch of selected commands

After starting the Rdaemon the document window behaves like a normal R console. If a line starts with "> " or "+ " (the standard prompt and continue prompt which must be unchanged) one can type a R command and press <button>&#x21A9;</button> or <button>&#x2305;</button>. If a line does not start with "> " or "+ " or if one wants to execute a selection of several commands only <button>&#x2305;</button> will work.

In addition there is the key equivalent <button>⇧&#x21A9;</button> which will execute the last command(s) of the current document. It jumps to the end of the current document and it selects by searching from the end everything to "> ".

***Hints:***

-    For inserting "new line" press <button>&#x2318;&#x21A9;</button>

-    If a selection of R commands shall be executed the selection will send line by line.

### The R commands: edit(), fix() 

-   __edit()__ and __fix()__

    These commands can __only__ be executed by using "Execute Line/Selection (Background > r_res)" <button>⇧&#x2305;</button>! These commands call `mate -w`. Otherwise TextMate will freeze and you can only interrupt the command by pressing <button>&#x2318;.</button>.

## History List

If a line starts with "> " one can use <button>&#x2191;</button> or <button>&#x2193;</button> to insert the previous or next command from the history list. This history list is stored persistently, i.e. the entire list is also available after restarting Rdaemon.
In addition while starting a Rdaemon session a time stamp will be inserted into the history list.

<button>&#x2303;&#x2325;&#x2191;</button> shows an inline menu with all commands.

<button>&#x2303;&#x2325;&#x2193;</button> opens a dialog to enter a regular expression to search within the history list.


To clear that history list open the command menu "Tools" <button>&#x2325;&#x2318;T</button> and choose "Clear History".

***Hint: For moving the caret up or down press <button>&#x2318;&#x2191;</button> or <button>&#x2318;&#x2193;</button>.***

## Autostarter TM_Rdaemon.app

`TM_Rdaemon.app` is an AppleScript application which starts TextMate and the Rdaemon automatically. If you invoke "Create TM&#95;Rdaemon.app" (Bundle Menu > Rdaemon Tools > Create TM&#95;Rdaemon.app) this command will create `TM_Rdaemon.app` at your Desktop. It also changes the icon but it could take a bit time for the Finder to realize it (relaunching the Finder will update it at once). That application you could drag'n'drop to the Dock or to Finder's toolbar to start Rdaemon much more faster.

# Commands

***Note*** Almost all commands specified within the "R" bundle can be used.

## Execute Line
<button>&#x21A9;</button>
It sends the current line to the Rdaemon and inserts the result as snippet. As selection will be ignored.

## Execute Last Command(s)
<button>⇧&#x21A9;</button>
It executes the last command(s) of the current document. It jumps to the end of the current document and it selects by searching from the end everything to "> ".

## Execute Selection
<button>&#x2305;</button>
It executes the selection line by line or the current line.

## Execute Line/Selection (Background > r_res)
<button>⇧&#x2305;</button>
It sends the current line or the selection line by line to the Rdaemon and does not wait for the result. The result will be written into `~/Library/Application Support/Rdaemon/r_res`. This is useful if one knows that the task will take some minutes, thus one does not block TextMate.

This command must be executed if you want to use the R commands `fix()` or `edit()`!

## Execute Line/Selection and Copy into Pasteboard
<button>⇧&#x2305;</button>
It executes the selection or the current line and copies the result into the pasteboard. If the result has a dimension like a matrix write.table(sep='\t') will be used.

## Completion… (R.bundle)
<blockquote><small>This command is defined within the R.bundle, but it differs a bit if it will be invoked from the Rdaemon scope.</small></blockquote>

<button>&nbsp;^.&nbsp;</button> Based on all installed packages and local function declarations it shows an inline menu with completion suggestions for the current word or selection as <code style="background-color:lightgrey;color:black">&nbsp;command&nbsp;library&nbsp;</code>. The library `local` refers to functions defined within the current document.

-   <code style="background-color:lightgrey;color:black">&nbsp;command&nbsp;…library…&nbsp;</code>
    `…library…` indicates that the required library is loaded

-   <code style="background-color:lightgrey;color:black">&nbsp;command&nbsp;{library}&nbsp;</code>
    `{library}` indicates that the required library is __not__ yet loaded

As default it also displays an inline menu if there is only one suggestion found in order to give you an hint for the required library. You can force TextMate to complete it without displaying that menu by setting the shell variable `R_AUTOCOMPLETE` to `1`. But the inline menu will be displayed if the suggested command is defined within a package which is not yet loaded.

***Hint*** This command works case-sensitively. E.g. if you type `math` (without selection and there is no command beginning with `math`) and invoke this command it lists all case-insensitive matched commands like `Math.fraction`, etc. as a tooltip caused by the chosen "Insert as Snippet" mechanism.

## Open Rsession
<button>&#x2303;&#x2325;&#x2318;R</button> Opens the Rsession project which is stored as `~/Library/Application Support/Rdaemon/Rsession.tmproj`. If Rdaemon is not running it will start it.
# Command Menus

## General Control
<button>&#x2325;&#x2318;C</button>

-    __Start Rdaemon__

      Starts the Rdaemon. See [General Usage: Start Rdaemon](#sect_3.1)

-    __Quit and Don't Save__

      Quits the Rdaemon session and does not save the workspace.

-    __Quit and Save__

      Quits the Rdaemon session and saves the workspace in the working directory `~/Library/Application Support/Rdaemon`.

-    __History__

      See [General Usage: History List](#sect_3.4)

-    __Set Working Directory__

      <button>&#x2318;D</button> Opens a folder choose menu and sets the chosen folder using `setwd(FOLDER)`.

-    __Edit StartOptions__

      Opens the file `~/Library/Application Support/Rdaemon/startOptions.R`. This file will be execute while starting Rdaemon.

-    __Start X11__

      Starts the X11 server. [not needed on Mac OSX > 10.4.x]

-    __Try to interrupt current task__

      Sends the signal INT to the Rdaemon process. This is not always successful.

## Workspace
<button>&#x2325;&#x2318;W</button>

-    __Show Workspace__

      Shows a window displaying all defined objects in the current session based on the R commands `ls()` and `str()`.

      "edit" will open the chosen object in a new TextMate window using `fix()`.

      "remove" will remove the chosen object from the workspace.

-    __Save/Load Default Workspace__

      Saves the workspace into the current working directory (default: `~/Library/Application Support/Rdaemon`) or loads it.

-    __Clear Workspace__

      Remove all objects from the workspace using `rm(list = ls())`.

## Packages 
<button>&#x2325;&#x2318;P</button>

-    __Package Manager__

      Shows a window with all installed R packages. With the help of the check boxes one can load or detach packages. If one clicks at an item the help page for the chosen package will be displayed.

## Graphics
<button>&#x2325;&#x2318;G</button>

-    __Graphic Manager__

     Opens a window displaying all open grDevices as PDFs. A preview will only be shown if the grDevice is a screen device (like quartz, png, x11, etc.). For opened grDevices like pdf or postscript a dummy PDF will be displayed instead. A red frame indicates the current device. For zooming resize the window.

     Functions:
     - click at an image to set that device to the current one (`dev.set`)
     - press <button>Close Device</button> to close that device (`dev.off`)
     - press <button>Close All Devices</button> to close all device (`graphics.off`)
     - press <button>Refresh</button> to refresh the window.
     - press <button>Open</button> to open it in the default PDF viewer.

     - ***Hint*** To create a transparent PDF, open a `png(bg = "transparent")` device, fill it with the desired data, and open the Graphic Manager.

-    __View Active Graphic Device as PDF__

      Executes `quartz.save()` and opens the created PDF file in the default PDF viewer. You can change the default PDF viewer by setting the shell variable `TM_RdaemonPDFVIEWER` to e.g. "PDFView" or "Safari".

-    __New Quartz Device__

      Opens a new Quartz device using `quartz()`. If you run a R version prior than 2.7.0 it also loads the library "CarbonEL".

-    __Bring All Quartz Windows to Front__

      Shows all Quartz windows.

-    __Close all Graphic Devices__

      Executes `graphics.off()` to close all graphic devices.

## Auxiliaries
<button>&#x2325;&#x2318;A</button>

-    __Reset Output__

      Some internal commands make usage of `sink()`. In an exceptional case it could be necessary to reset the output path. “Reset Output” will execute `sink(file=NULL)` until all redirects are reset.

-    __Show Last Error Message__

      Shows the output of the R command `geterrmessage()` as tooltip.

## Tools
<button>&#x2325;&#x2318;T</button>

-    __Clear History__

      Removes all items from the history list.

-    __Reveal/Open "Rdaemon" in Finder/as TM Project__

      Reveals/Opens the folder `~/Library/Application Support/Rdaemon` in Finder or as a TextMate project.

-    __Show End of r_out__

      Shows the tail of the console logfile "r_out" containing the raw data coming from Rdaemon.

-    __Open Console Logfile r_out__

      Opens the console logfile "r_out" containing the raw data coming from Rdaemon.

-    __Open Result File r_res__

      Opens the file "r_res" containing the result of R code executed in the background.

-    __Show RAM disk usage__

      If the Rdaemon is using a RAM drive it shows the available space. See more under ["Advanced Topics"](sect_6).

-    __Show R CPU coverage__

      Shows the current CPU coverage of the Rdaemon. Only useful if one sent a background task.
 
-    __Show PIDs__

      Shows the process IDs of the daemon (Ruby) and the Rdaemon (R). Only useful if one has to kill these processes manually.

-    __Rescan Open Files__

      Rescans all opened files/folders.

# Advanced Topics

-   __Usage of a RAM drive__

    To store the console output of Rdaemon at a RAM drive (mount point `/tmp/TMRramdisk1`) set a TextMate shell variable named `TM_RdaemonRAMDRIVE` to "1". This will increase the speed of the interaction between TextMate and Rdaemon in certain circumstances enormously and will reduce the hard disk access. If `TM_RdaemonRAMSIZE` is unset the default size is 50MB.

    Rdaemon's console logfile can be found at  `/tmp/TMRramdisk1/r_out`.

    Unfortunately it is up to now not possible to detach the RAM drive after quitting Rdaemon. Thus use it __only__ if enough RAM space is available. Only a restart of the entire Mac will detach that RAM drive called "TMRdaemon".

-   __Internal File Structure__

    All needed files are stored in the folder `~/Library/Application Support/Rdaemon`.

    * console.Rcon [console file used by the Rsession]
    * __daemon__

        * dummy&#95;noimage.pdf_[dummy pdf for the Graphic Maganger]

        * execRStr.sh [bash script executing R code as arg1 and outputs its result; mainly used by JavaScript]

        * myBase.R [contains functions which are overwritten in the base package]

        * myUtils.R [contains functions which are overwritten in the utils package]

        * myStartOptions.R [contains Rdaemon specific start options]

        * Rdaemon.rb [the actual daemon written in Ruby 1.8]

        * start.r [R source file which calls getSig.R and startOptions.R]

        * startR.sh [bash script executing Rdaemon.rb as background process]

        * startScript.sh [bash script starting the entire Rdaemon; used by "Start Rdaemon"]

        * {x11runs} [if existing tells Rdaemon: don't shut down X11]

    * __help__

        * getSig.R [R script containing the code for inserting the command signature on run-time &mdash; obsolete]

        * grMan.sh and grMan2.sh are used by the Graphic Manager to generate the HTML page

        * pkgMan.R [R script for generating the HTML output used by the "Package Manager"]

        * __savePlotAs__ [contains all files to save/convert a chosen PDF within the Graphic Manager]

        * savePlotAs.sh [calls a dialog to save/convert a chosen PDF within the Graphic Manager]

    * __history__

        * Rhistcounter.txt [contains the current line number of the history list used by prev/next history item]

        * Rhistory.txt [contains the actual history list]

   * __plots__ [output path of PDF files]

   * r_in [Rdaemon reads on that named pipe]

   * r&#95;out [if existing contains the raw output data coming from Rdaemon; see also [Usage of a RAM drive](#sect_6) ]

   * r&#95;res [if existing contains the output for R code sent as background task]

   * r&#95;tmp [if existing used as temporary container variable]

   * startOptions.R [R script containing all start options for the Rdaemon]

-   __Rdaemon runs in the background__

    This means that you can quit TextMate (without quitting the Rdaemon) and restart TextMate without loosing the current Rdaemon session. Furthermore you have access to the Rdaemon also from other applications by using the pipe `~/Library/Application Support/Rdaemon/r_in` for sending tasks to the Rdaemon, or you can use the bash script `~/Library/Application Support/Rdaemon/daemon/execRStr.sh TASKS` which will output the result on stdout.

-   __Different TextMate documents are set to "R Console (Rdaemon)"__

    Based on the issue that Rdaemon is a daemon there is no problem to have more than one window open set to "R Console (Rdaemon)". All these windows execute R code within the __same__ Rdaemon session.

# Shell variables

-   __TM_RdaemonPDFVIEWER__

	If set it calls that application for showing the current plot as PDF. Its default is `Preview`.

-   __TM_RdaemonRAMDRIVE__

    To store the console output of Rdaemon at a RAM drive (mount point `/tmp/TMRramdisk1`) set `TM_RdaemonRAMDRIVE` to "1". This will increase the speed of the interaction between TextMate and Rdaemon in certain circumstances enormously and will reduce the hard disk access. If `TM_RdaemonRAMSIZE` is unset the default size is 50MB.

    Unfortunately it is up to now __not__ possible to detach the RAM drive after quitting Rdaemon. Thus use it __only__ if enough RAM space is available. Only a restart of the entire Mac will detach that RAM drive called "TMRdaemon".

-   __TM_RdaemonRAMSIZE__

    `TM_RdaemonRAMSIZE` set as integer in MB specifies the size of the used RAM drive. The default is 50 meaning 50MB.

-   __Locales: TM&#95;RdaemonXXXXX__

    XXXXX specifies the different locales:
    * LC_ALL
    * LC_LANG
    * LC_TIME
    * LC_COLLATE
    * LC_CTYPE
    * LC_MONETARY
    * LC_NUMERIC
    * LC_MESSAGES
    * LC_PAPER
    * LC_MEASUREMENT

    If unset Rdaemon uses the system defaults.

    ***Example:*** `TM_RdaemonLC_ALL = de_DE` will set Rdaemon to output messages in German.

# Troubleshooting &amp; FAQ

-   __How can I cancel a running task?__

    Each command should be canceled by pressing <button>&#x2318;.</button>. If the task was canceled a warning message will be prompted. By pressing <button>&#x2318;Z</button> (undo) the last command will be restored. If you canceled a task which redirected the output to a file (e.g. via sink() ) it could be the case that this redirection is still active. You can test it by executing e.g. `1+1`. If you don't see the result you can reset Rdaemon by executing the command `Reset Output` <button>&#x2325;&#x2318;A</button> one or more times.

-   __How can I change the language, time format, etc. used by the Rdaemon?__

    Set the locales LC&#95;ALL, etc. See [Locales: TM&#95;RdaemonXXXXX](#sect_7)

-   __Error in library(CarbonEL) : there is no package called 'CarbonEL'__

    That error message indicates (showing after a plot command) that the package "CarbonEL" was not yet installed. This package is necessary __only__ for versions of R prior than 2.7.0 to work with the Quartz device properly. You can install it by using `install.packages("CarbonEL")`. With the version 2.7.0 the quartz device has a built-in loop event handler.

-   __Rdaemon freezes after executing a command__

    Did you change `options()$prompt` or `options()$continue`? defaults: "> " and "+ "

    ***Background:*** If a R command is sent to the Rdaemon the used TextMate command will wait for R until R returned something which ends at: "> ", "+ ", or ": ". Otherwise that command runs in an eternal loop. You can cancel it by pressing "&#x2318;.". In some cases you have to switch to an other application and back to TextMate in order to get the focus back.

-   __After calling `locator()` there is no way to get out of a graphic device__

    To finish the `locator()` command please do a CONTROL+click with the mouse.

-   __`edit()` does not return the edited value__

    `> edit(x)` will call TextMate via `mate -w`. For that reason TextMate can't wait for its result. To use `edit(x)` please execute it à la `y <- edit(x)` to assign `y` with the returned value.

-   __How can I save a plot as JPEG, PNG, etc.__

    Open the "Graphic Manager" and press "Save" or open the current plot in "Preview" and choose "Save As". Since R 2.7 you can also use “R Quartz” window's menu to save the content.

-   __Can I run more than one instance of Rdaemon?__

    No.

-   __Can I run Rdaemon, R.app, or R in the terminal at the same time?__

    Yes. Rdaemon should not interfere R.app or R running in the Terminal. The only thing which won't work is the usage of Rdaemon together with the remote bundle "R Console (R.app)" if Rdaemon had plotted something in a Quartz device (It makes usage of an helper application). "R Console (R.app)" is using AppleScript to interact with R.app. Unfortunately this helper application and R.app have the same AppleScript name "R".

-   __…cut… – Warning: more than 50000 lines (see the entire output in the “Console Logfile/r\_out” ⌥⌘T)__

    Due to a TextMate internal the maximum number of inserted lines is set to 50,000. Via ⌥⌘T one can open the “Console File” resp. show the end of r_out to have a look at the entire output.


# Main Bundle Maintainer

***Date: Dec 09 2009***

<pre>
-  Hans-Jörg Bibiko&nbsp;&nbsp;<a href="mailto:bibiko@eva.mpg.de">bibiko@eva.mpg.de</a>
</pre>

## Credits

Many thanks to 
<pre>
- John Purnell
- Balthasar Bickel
</pre>

for all the valuable suggestions and the exhausting tests.