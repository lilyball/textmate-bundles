# Build With MTASC Help

The "Build With MTASC" command will compile your ActionScript project without the need of the Adobe Flash IDE. It uses [MTASC][], an Open Source AS2.0 compiler that is faster than Adobe's own.


## Setup

In order to build an ActionScript project, you'll need:

* At least one .as file.
* Optionally, a 'mtasc.yaml' file in your project root, where you tell MTASC how it should compile your project (the command is smart enough to use some sane defaults if you don't have it).

The **"Install MTASC Support Files"** command will create a generic 'mtasc.yaml' in your project and open it for you to edit. The file is self-commented, so setting up your environment should be too hard.

An MTASC Universal Binary is included with the bundle, but you can use your own version (HAMTASC, for example) by editing the 'mtasc.yaml' file.


## Compiling with MTASC

Compilation with MTASC is pretty straightforward. You just tell it which of your .as files is the 'main' file, and it will compile your project (including imported classes) into the .swf you specified on the 'mtasc.yaml' file.

The project is compiled with the <code>- main</code> option in MTASC. This means that your .as class should have a <code>main()</code> that will be called to launch the application (pretty much like Java or C).

If you already have an existing SWF file, the code will be injected into it and library assets will be left intact.

If you don't have a SWF file, MTASC will create a new one for you.


## Debugging

Currently, the ActionScript bundle supports the following debugging methods:


### Debugging using XTrace

[XTrace][] is a graphical tool that accepts HTTP connections from any application. The bundle includes an ActionScript library you can use to send debugging information to XTrace.

To enable XTrace, add the line `trace: xtrace` to mtasc.yaml

This will tell MTASC to include the required libraries and use the `com.mab.util.debug.trace()` function for debugging.

You don't need to change your code for XTrace to work. Just use a simple `trace()` and the output will show up in XTrace.

Everytime you compile the movie, TextMate will open XTrace if it's not open. The first time you open XTrace, though, it may not register log messages if the movie starts sending debug information before XTrace is fully loaded. I'm working on fixing this :)

If you want to debug using XTrace, you need to adjust your security settings to allow local scripts to make HTTP connections (check [Adobe TechNote 4c093f20](http://www.adobe.com/go/4c093f20) for more information on why and how to do this).


### Debugging using Console.app
Check <http://bomberstudios.com/2007/03/14/how-to-use-consoleapp-for-flash-debugging/> for information, as the process is quite convoluted :)


### Debugging with Terminal.app
If want to use the `tail` command to debug your Flash movies, you can add this line to your `mtasc.yaml` file:

    trace: terminal

When you compile your movie, TextMate will open Terminal.app and run this command:

    tail -f $HOME/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt

Make sure you read the post on the previous section.


# Where to go for help

The maintainer of the ActionScript bundle (Ale Muñoz) follows the [TextMate List](http://lists.macromates.com/mailman/listinfo/textmate), and will be happy to help you out with anything ActionScript-related.

Feel free to send your suggestions and code patches to ale AT bomberstudios DOT com

Another good place to ask is the [MTASC Mailing List](http://lists.motion-twin.com/mailman/listinfo/mtasc), where the maintainer of MTASC is pretty active.


# Acknowledgments & Credits

* [MTASC][] is released under the GPL License.
* [XTrace][] is released under the GPL License.
* The "Build With MTASC" command is based on work by [Chris Sessions](http://lists.motion-twin.com/pipermail/mtasc/2006-June/029791.html), [Ben Jackson](http://www.unfitforprint.com/) and [Juan Carlos Añorga](http://www.juanzo.com/), and is maintained (along with the ActionScript bundle) by [Ale Muñoz](http://bomberstudios.com). Some code & inspiration lifted from [Monokai](http://www.monokai.nl/blog/2006/07/14/using-textmate-mtasc-and-xtrace-to-build-flash-projects-in-mac-osx/)
* Improvements suggested by
  * [Juan Carlos Añorga](http://www.juanzo.com/)
  * [Helmut Granda](http://helmutgranda.com)
  * [Gaby Vanhegan](http://vanhegan.net)


[XTrace]: http://developer.mabwebdesign.com/xtrace.html
[mtasc]: http://www.mtasc.org