# Review Comments

## Infininight - 10/26/07

* Grammar should not have xml in the fileTypes, it's too broad.
* Help command shouldn't have a shortcut [1].
* Have to have allan comment here on where the ant.dtd file should be kept, but inside the bundle isn't the place. Except for "~/Library/AppSup/TextMate/Bundles/" Textmate is not supposed to write to bundles, and it's not checking if the bundle is located there.
* Not quite understanding the manual command, by (my) default it opens an unused new document then opens the manual in Safari even though my preferred browser is Camino? Not sure why it doesn't use the TM html window, but if there is a reason to use an external browser it should use the default. (try: `open http://foo.com`)
* Manual command shouldn't have a shortcut either.
* Validate should really not override ⌘S, users aren't going to be expecting validation to run on save. I would make this the standard validation shortcut (⌃⇧V) and then suggest in the help file the alternative.
* `Open Ant.dtd` has a typo, refers to Generate Ant.dtd instead of Create Ant.dtd.

[1]: http://macromates.com/wiki/Bundles/StyleGuide

## Simon - 10/26/07

* File types in the grammar files removed. With the exception of the users selecting the Ant Language Grammar via ctrl-alt-shift-A is there an elegant way that Ant build files may be detected?
* Help and Manual now have no shortcut.
* The Manual command will only open the manual in the TextMate window, and is now commented - please sanity check. Opening a new document was an obvious mistake.
* Validation has been switched to (⌃⇧V)
* I have doubts about the usefulness of validating against the Ant.dtd (as it rarely works in practice for me - build files can be too dynamic ) so it may be simpler to ditch the functionality directly and just suggest it in a comment in the validation command. Leaving "Create Ant.dtd" to open in a new document.

## Infininight - 10/26/07

* The 'ant.xml' fileTypes was a good method, it's the best current way to do things. So you'd name your ant files "foo.ant.xml" for instance.
* Validation should give a success message perhaps? I get nothing if the file is determined valid.
* Now that validation doesn't override ⌘S you can stop saving the current file before running the command.

Other than that it's looking good to me, poked allan about providing some feedback about the ant.dtd file.

## Simon - 10/27/07

* 'ant.xml' fileTypes re-introduced. Would a first line match with <\!\-\-ant\-\-\> anywhere on the line be possible? This would be less intrusive for existing projects.
* Validation now shows a tooltip on success. 
* Saving the current file on validation has been removed.

Thank you for the feedback.

## Allan -- 2007-10-27 (hey guys, there is an `isoD⇥` tab trigger!)
<!-- My comments are best read with Markdown → Preview :) -->

* The *Build File* template specifies encoding as `ISO-8859-1`, wtf!?!

* No [Contact / Description][2] in `info.plist`.

* As for `TM_ANT_DTD_VALIDATION`, might be better to simply check if it is set (to anything but the empty string), that way the user won’t have to check if it has to be `1`, `YES`, `TRUE`, and/or if `TRUE` works in addition to `true`.

* The documentation for `TM_ANT_DTD_VALIDATION` could be changed from:
  > When set to “true” the Validate Build File command will check that the document is valid against the ant.dtd (if available).

  Into something like (the idea being to make it clear that the command does more than check against the DTD):
  > When set (to anything but the empty string) the _Validate Build File_ command will, in addition to verify that the XML is well-formed, check that the document conforms to `ant.dtd` (if available).

* As for the `TM_ANT_MANUAL_PATH` manual entry, I think it could be made better by asking *“What does this mean for the user?”* rather than *“How is this implemented?”*.

  The current text is:
  > The local location of your Ant manual’s `index.html` file. If this is not specified the bundle checks the default manual location when Apple Developer Tools are installed, if this is unsuccessful then ant.apache.org/manual is opened.

  Here is what I suggest:
  > If you have installed your own version of Ant, you can set this variable to the location of its manual.  
  > For example if you installed it via MacPorts then set it to `/opt/local/share/java/apache-ant/docs/manual`.  
  > The default is to use the manual included with Apple’s developer tools with the online version as a fallback.

* In the manual, generally wrap file names in `` `…` ``. I.e. `index.html`, `ant.dtd`, etc. I also use *emphasis* for command names like *Validate Build File*.

* Specify `ant.xml` as the extension in the *Build File* template (then New From Template → Ant → Build File will open with proper language grammar and saving the build file uses the double extension).

* I don’t fully understand the purpose of `ant.dtd` -- is this so that the user can customize the DTD for his particular build environment? If so, it would seem that optionally reading the file from `TM_PROJECT_DIRECTORY` is the way to go (and if the user wants to edit it, ask if it should copy it to that location first, if he says no, probably not allow editing the DTD).

* The `firstLineMatch` for an ant comment sounds fine.

[2]: http://macromates.com/wiki/Bundles/StyleGuide

## Simon -- 2008-01-12

* I've address all of the issues and suggestions made. ( ISO-8859-1, wtf?! indeed, erm.. :$ )

* Regarding the `ant.dtd` - Ant doesn't have an official / static dtd as it's so extendable. It does however provide a *task* to create a basic dtd for users to extend if appropriate. As I mentioned before I have doubts about it's usefulness so I've removed the associated *Create Ant.dtd* command and will leave it up to users to override the default behaviour of the validiation command.

