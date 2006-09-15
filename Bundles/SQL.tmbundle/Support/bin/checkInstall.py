#!/usr/bin/env python
# encoding: utf-8

import sys
import os
import getopt
import re

# import the right driver based on the command line args. (default to postgres)
if '--server=postgresql' in sys.argv:
    try:
        import pgdb
    except:
        print 'pgdb not found'
        sys.exit(-1)

if '--server=mysql' in sys.argv:
    try:    
        import MySQLdb
    except:
        print 'mysqldb not found'
        sys.exit(-1)
        
sys.exit(0)