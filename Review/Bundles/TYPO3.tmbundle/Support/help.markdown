# TYPO3

TYPO3 [www.typo3.org](http://www.typo3.org) is a content management system, written in PHP. It is widely used and very extensible.

The bundle is still in early development and we are very open to suggestions for improvement.

# Bundle Help

The bundle menu is split into several sections:

## TypoScript

TypoScript is a configuration language used for configuring the various parts of TYPO3.  The bundle contains snippets to quickly create many of the more common objects and configure parts of TYPO3 such as the Rich Text Editor.  We are working on implmenting completions to make the generation of TypoScript a lot quicker and easier -- and much less frustrating!

## T3 Data Structures

The more recent versions of TYPO3 introduced XML data structures which are   used for storing data for various aspects of TYPO3, e.g. creating backend forms, flexible content elements and storing language translations. The menu has snippets to assist in quick generation of the correct tags.  The language grammar is currently very rudimentary (essentially just a slightly modified xml language grammar) and we are looking to improve this massively in the future to enable better manipulations.

## Extension Development

Sundry snippets useful during the development of extensions.  Of note are the template marker commands which convert the selection or word into a marker of the form:

e.g.
	
	title
	
becomes

	###TITLE###
	
Spaces are removed from the selection and all letters are capitalised.	
	
The macro version is useful for quickly turning a list of words into markers,whilst the begin/end version is used to turn the word or selection into section markers:

e.g.

	template archive
	
would become
	
	<!--      ###TEMPLATEARCHIVE###      begin -->
	  |
	<!--      ###TEMPLATEARCHIVE###      end   -->
	

with the cursor ending up in the position denoted by |

## Credits

The bundle is developed and maintained by Andy Henson and Sudara Williams.