Balance Jr is basically just a really useful regular expression search. Activate the macro and it'll move your selection forward or backward through your document.

It comes in the form of two macros.  
**Balance Jr Back** &  
**Balance Jr Forward**

I would advise you set them to set their key equivilents to the home and end keys. I also have it mapped to the tiltwheel on my mouse.

	(?xm)
	<(\w+)[^>]*>(?>[^<]*?</\1>)                    # HTML Tags Balanced
	|(?<=[^/]>)[^><]*(?=</)                        # HTML >Contents</
	|(?<=<!--\s).*?(?=\s-->)                       # HTML Comments
	|\b[\w-]+\b(?=\s*=)                            # HTML Attribute name
	|\s\b[\w-]+\b=\"[^\"]*\"                       # HTML Attribute name value pair
	|(?<=\")[^\"\n<>]*(?=\")                       # HTML Compatible String Double
	|<[^>\n]*/?>                                   # HTML Tags
	
	|<%.*?%>                                       # Embedded Source
	|(?<=<%[-@#=]\s).*?(?=\s-?%>)                  # The contents of various other forms of Embedded Source
	|(?<=<%\s).*?(?=\s-?%>)                        # The contents of Embedded Source
	
	|(?<=/\*).*?(?=\*/)                            # /* Contents of Comment Blocks */
	|/\*.*?\*/                                     # /* Comment Blocks */
	
	|(?<=\')[^\'\n]*?(?=\')                         # 'String Single'
	|(?<=\")[^\"\n]*(?=\")                         # String Double
	|(?<=\[)[^\[\]\n]*?(?=\])                       # [Square Brackets]
	|(?<=\{)[^\{\}\n]*?(?=\})                       # {Curly Brackets}
	
	|\#[0-9a-fA-F]{3,6}                            # Hex Colors
	|(?<![\d])-?\d+(?:\.\d+)?(?!=\d)               # Number 123 123.123 -123
	|[@$!]\w+\b                                    # @variables $variables !etc
	
	|(?<=[\(,:])[^\(\),\n]*(?=[\),;])              # Comma Delimitated
	# Thomas Aylott <oblivious@subtleGradient.com> #
	# Balance Jr. Regular Expression version 2.8   #