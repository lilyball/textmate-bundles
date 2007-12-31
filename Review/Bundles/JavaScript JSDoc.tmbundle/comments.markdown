# JavaScript JSDoc Bundle Comments

Can we get a general show of hands on how widely used JSDoc is, and if it's the only doc system for JavaScript? If it is we might want to consider just moving this into the main JavaScript bundle?

* Unsure of tab trigger of /* might it be trigger by accident as people align comments? Would /** change that, or is it not an issue?
* The "Comment" snippet seems misnamed, it should be Doc Comment or similar. Or seeing as we have a block comment shortcut (⌘⌥/) we could either make it that a second press of the shortcut would convert the current comment block into a doc comment block, or make a second shortcut.
* Could move away from using CocoaDialog in favor of tm_dialog.
* Could add a new rule to the JavaScript grammar to give doc blocks their own scope to make the snippets more narrowly focused.
