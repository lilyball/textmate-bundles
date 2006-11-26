# Build With MTASC Help

The "Build With MTASC" command will compile your ActionScript project without the need of the Adobe Flash IDE. It uses [MTASC](http://www.mtasc.org/), an Open Source AS2.0 compiler that is faster than Adobe's own.

## Setup

In order to build an ActionScript project, you'll need two things:

* A TextMate project (if you run the command from a single .as file you'll get an error).
* A 'mtasc.yaml' file in your project root, where you tell MTASC how it should compile your project.

The **"Install MTASC Support Files"** command will create a generic 'mtasc.yaml' in your project and open it for you to edit. The file is self-commented, so setting up your environment should be too hard.

An MTASC Universal Binary is included with the bundle, but you can use your own version (HAMTASC, for example) by editing the 'mtasc.yaml' file.

## Compiling with MTASC

Compilation with MTASC is pretty straightforward. You just tell it which of your .as files is the 'main' file, and it will compile your project (including imported classes) into the .swf you specified on the 'mtasc.yaml' file.

The project is compiled with the <code>- main</code> option in MTASC. This means that your .as class should have a <code>main()</code> that will be called to launch the application (pretty much like Java or C).

If you already have an existing SWF file, the code will be injected into it and library assets will be left intact.

If you don't have a SWF file, MTASC will create a new one for you.

# Where to go for help

The maintainer of the ActionScript bundle (Ale Muñoz) follows the [TextMate List](http://lists.macromates.com/mailman/listinfo/textmate), and will be happy to help you out with anything ActionScript-related.

Another good place to ask is the [MTASC Mailing List](http://lists.motion-twin.com/mailman/listinfo/mtasc), where the maintainer of MTASC is pretty active.