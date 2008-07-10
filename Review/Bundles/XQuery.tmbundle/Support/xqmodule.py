"""prints the module nameof a xquery file"""

import sys, re
lines=file(sys.argv[1]).read()
m=re.findall("^(?:\s*)module(?:\s+)namespace(?:\s+)(\w+)", lines, re.MULTILINE)
if m:
	sys.stdout.write(m[0])
else:
	sys.stdout.write("local")
