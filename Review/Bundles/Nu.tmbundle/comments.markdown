# Nu Comments

## msheets - Feb 2

**FIXED** * The standard name for beautify commands is 'Reformat Document / Selection', Textmate will pick the appropriate suffix based on if there is a selection or not. Should have a shortcut of ⌃⇧H
**FIXED** * Since this is part of the main repository now Beautify C/ObjC should be submitted to that bundle and removed here.
**FIXED** * Presuming the `TM_COMMENT_START` preference of ';; ' is intentional; the comment/uncomment command needs `TM_COMMENT_START_2` of '; ' and `TM_COMMENT_START_3` of '# ' to be added. (First is always added, 2+ are looked at when removing comments.)
**FIXED** * Paths to executables are hardcoded, should really look at the PATH before falling back on something hardcoded.
**FIXED** * Key equivalent for the grammar should be ⌃⌥⇧N rather than ⌃⌥⌘N
* Here strings need punctuation scopes added.

#### Grammar Notes

Note that I'm not actually familiar with the syntax, just noting things that appear missing or wrong.

**FIXED** * string.regex.nu typo, should be string.regexp.nu
**FIXED** * The \b starting the constant.numeric match is preventing negative numbers from being matched (-0).
* constant.character match does not catch four character integers ('psLt' 'psA4').
* constant.character could be more specific in it's matching to catch errors.
**FIXED** * Appears to be a lot of operators missing from keyword.operator?
**FIXED** * Is constant.language missing YES|NO|ZERO|NULL?
* Second imethod/cmethod incorrectly matched in:
    
    (imethod (void) test-imethod is 1234)
    (cmethod (void) test-cmethod is 1234)
    
* Strings missing #{(+ 1 1 1)} interpolation matching.
* Escapes in double-quoted strings don't match octal, hexadecimal or unicode escapes, ditto in <<+ here-strings.
**FIXED** * The options in the regexp end match should match only [isxlm]*
* The -/+ prefixing double-quoted strings should be matched as part of the string punctuation.
* With the previous added they could actually be split into two rules with one not supporting escapes and #{} matching.

---

