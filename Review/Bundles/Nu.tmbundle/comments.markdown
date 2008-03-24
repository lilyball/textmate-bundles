# Nu Comments

## msheets - Feb 2

#### Grammar Notes

Note that I'm not actually familiar with the syntax, just noting things that appear missing or wrong.

* constant.character match does not catch four character integers ('psLt' 'psA4').
* Escapes in double-quoted strings don't match octal, hexadecimal or unicode escapes, ditto in <<+ here-strings.
* The -/+ prefixing double-quoted strings should be matched as part of the string punctuation.
* With the previous added they could actually be split into two rules with one not supporting escapes and #{} matching.

---

