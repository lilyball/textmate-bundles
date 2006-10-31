Balance Jr is basically just a really useful regular expression search. Activate the macro and it'll move your selection forward or backward through your document.

It comes in the form of two macros.  
**Balance Jr Back** &  
**Balance Jr Forward**

I would advise you set them to set their key equivilents to the home and end keys. I also have it mapped to the tiltwheel on my mouse.

	(?x)
	<(\w+)[^>]*>[^<]*</\1>                         # HTML tags that don't contain text
	|(<%@\s|<%\#\s|<%=\s)[^%]*%>                   # The contents of various other forms of Embedded source
	|(?<=(<%@\s|<%\#\s|<%=\s))[^%]*(?=\s%>)        # The contents of various other forms of Embedded source
	|(?<=<%\s)[^%]*(?=\s%>)                        # The contents of Embedded source
	|(?<=<!--\s)[^->]*(?=\s-->)                    # HTML Comments
	|\b[\w-]+\b(?=\s*=)                            # HTML Attribute name
	|\s\b[\w-]+\b=\"[^\"]*\"                       # HTML Attribute name value pair
	|(?<=\")[^\"\n<>]*(?=\")                       # HTML Compatible String Double
	|(?<=\')[^\'\n]*(?=\')                         # 'String Single'
	|(?<=\[)[^\[\]]*(?=\])                         # [Square Brackets]
	|(?<={)[^{}]*(?=})                             # {Curly Brackets}
	|(?<=[^/]>)[^><]*(?=</)                        # >Text Inside HTML Tag</
	|\#[0-9a-fA-F]{6}                              # Hex Colors #AABBCC
	|\#[0-9a-fA-F]{3}                              # Hex Colors #ABC
	|(?<![\d])-?\d+(?:\.\d+)?(?!=\d)               # Number 123 123.123 -123
	|[@$!]\w+\b                                    # @variables $variables !etc
	|(?<=/\*).*(?=\*/)                             # /* Contents of Comment Blocks */
	|/\*.*\*/                                      # /* Comment Blocks */
	|(?<=[\(,:])[^\(\),\n]*(?=[\),;])              # Comma Delimitated
	|(?<=\")(?=(>|/>| />))                         # Placer for adding HTML Attribute Values
	|<[^>\n]*/?>                                   # HTML Tags
	|(?<=\")[^\"\n]*(?=\")                         # String Double
	# Thomas Aylott <oblivious@subtleGradient.com> #
	# Balance Jr. Regular Expression version 2.7   #

