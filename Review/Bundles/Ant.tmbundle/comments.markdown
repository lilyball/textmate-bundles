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
