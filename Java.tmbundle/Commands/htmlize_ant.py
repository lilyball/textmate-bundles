#!/usr/bin/python

import sys, os.path, re, os

matcher = re.compile(
r'(/.*?):(\d+):\s*(.*)$'
)

## read all data from stdin
data = sys.stdin.read().split("\n")

## find the buildfile, and from that, the project directory
buildfile = data[1][(data[1].find(":") + 2):]
proj_dir = os.path.dirname(buildfile) + "/"

print """
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="file://%s/Commands/ant.css" />
    </head>
    
    <body>
        <pre>
""" % (os.environ['TM_BUNDLE_PATH'])

for line in data:
    match = matcher.search(line)
    
    if not match:
        print line
    else:
        fn = match.group(1)
        
        if fn.startswith(proj_dir):
            short_name = fn[len(proj_dir):]
        else:
            short_name = fn
        
        print line[:match.start()].rstrip(),
        print '<a href="txmt://open?url=file://%s&line=%s">%s:%s: %s</a>' % (
            fn, match.group(2), short_name, match.group(2), match.group(3)
        )
        print line[match.end():]

print """
        </pre>
    </body>
</html>
"""