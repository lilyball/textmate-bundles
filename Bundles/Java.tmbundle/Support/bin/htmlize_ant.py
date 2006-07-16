#!/usr/bin/python

import sys, os.path, re, os

matcher = re.compile(
    r'(/.*?):(\d+):\s*(.*)$'
)

buildfile = None
proj_dir = None

print """
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="file://%s/ant.css" />
    </head>

    <body>
        <pre>
""" % (os.environ['TM_BUNDLE_SUPPORT'])

sys.stdout.flush()

## read all data from stdin
line = sys.stdin.readline()
while line:
    line = line.rstrip()
    
    ## find the buildfile, and from that, the project directory
    if line.startswith("Buildfile"):
        buildfile = line[(line.find(":") + 2):]
        proj_dir = os.path.dirname(buildfile) + "/"

    match = matcher.search(line)

    if not match:
        print line
    else:
        fn = match.group(1)

        if proj_dir and fn.startswith(proj_dir):
            short_name = fn[len(proj_dir):]
        else:
            short_name = fn

        print line[:match.start()].rstrip(),
        print '<a href="txmt://open?url=file://%s&line=%s">%s:%s: %s</a>' % (
            fn, match.group(2), short_name, match.group(2), match.group(3)
        )
        print line[match.end():]

    sys.stdout.flush()
    
    ## read next line
    line = sys.stdin.readline()

print """
        </pre>
    </body>
</html>
"""
