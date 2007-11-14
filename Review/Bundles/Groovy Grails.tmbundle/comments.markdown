# Groovy Grails Comments

## Infininight

* Grammar could use a less obscure name. HTML (Groovy Grails) perhaps?
* Shouldn't more of the template tags (g:textField, etc) be marked up? (We are going to start marking up template tags with a unique scope so it would help coloring.)
* Many of the snippets seem to have tab stops in the middle of the blocks (for instance g:each), perhaps this is a bad idea since it would mean you can't use any other snippets inside that block?
* For the two simple tag creation snippets you could use the ⌃> shortcut, my ultimate goal is to make that the default shortcut for "insert embedded tag here". Take a look at how it works for erb, hit it once for a tag, and again to cycle through the tag types.
* New short tag has $4 at the end of the snippet, which means until you tab your still in the snippet.
* Many of the <g:foo> snippets are inconsistent on wether they insert a newline after the closing tag or not, should be standardized.
* Not sure about using the ⌃⇧G shortcut for all java/xml files. But allan is the expert there so I'll let him comment.

## daleyl 2007-10-12

> Grammar could use a less obscure name. HTML (Groovy Grails) perhaps?

Not sure what you mean about the grammar name, GSP (Groovy Server Page) is the view technology in grails. Anybody working with Grails will know what it is immediately.

> Shouldn't more of the template tags (g:textField, etc) be marked up? (We are going to start marking up template tags with a unique scope so it would help coloring.)

Not sure here either, can you give an example please.

> * Many of the snippets seem to have tab stops in the middle of the blocks (for instance g:each), perhaps this is a bad idea since it would mean you can't use any other snippets inside that block?

Fixed.

> For the two simple tag creation snippets you could use the ⌃> shortcut, my ultimate goal is to make that the default shortcut for "insert embedded tag here". Take a look at how it works for erb, hit it once for a tag, and again to cycle through the tag types.

Fixed.

> New short tag has $4 at the end of the snippet, which means until you tab your still in the snippet.

Fixed.

> Many of the <g:foo> snippets are inconsistent on wether they insert a newline after the closing tag or not, should be standardized.

Fixed.

> Not sure about using the ⌃⇧G shortcut for all java/xml files. But allan is the expert there so I'll let him comment.

Grails projects are made up of a lot of java and xml files. It's annoying to make a change, go to launch the app with ⌃⇧G and have it not work because you aren't in a groovy or GSP page.


## Infininight - Followup 2007-10-14

> Not sure what you mean about the grammar name, GSP (Groovy Server Page) is the view technology in
grails. Anybody working with Grails will know what it is immediately.

The issue isn't people that know Grails it's people that don't. ;) However just hold on this for the moment, I'm going to get with allan to get together a style guide for grammar names like we have for the bundle names. Will try and get everything all standardized.

>> Shouldn't more of the template tags (g:textField, etc) be marked up? (We are going to start marking up template tags with a unique scope so it would help coloring.)

> Not sure here either, can you give an example please.

I should have explained this better, I've recently defined new meta.tag sections to differentiate different kinds of tags for the purposes of coloring them with themes. They are:

meta.tag.(metadata|structural|content|object|template)

All the groovy tags would be meta.tag.template. Was just pointing out that you let the standard grammar pick up most of the tags, so you won't get the benefit of that. A simple match for `<g:\w+>` would work.

>> Not sure about using the ⌃⇧G shortcut for all java/xml files. But allan is the expert there so I'll let him comment.

> Grails projects are made up of a lot of java and xml files. It's annoying to make a change, go to launch the app with ⌃⇧G and have it not work because you aren't in a groovy or GSP page.

Allan will be commenting here… ::pokes allan with a stick::

## daleyl - 2007-11-14

* Renamed grammar to GSP

* Sanitised menu layout



