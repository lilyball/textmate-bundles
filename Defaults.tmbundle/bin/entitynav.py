#!/usr/bin/env python
# @author Kumar McMillan, Brad Miller

"""Entitynav: Outputs a parsable list of functional entities for the given code file

Usage:  entitynav -f <filename> [ -m $TM_MODE ]
        entitynav -f - -m $TM_MODE
        entitynav -f - -e <mode as extension>
        entitynav -f - -E <mode as extension of filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -m, --mode <mode>              : set mode to <mode>
 -e, --ext <extension>          : set mode to <extension>
 -E, --ext-from-file <filename> : set mode to extension of <filename>
 -s, --sort                     : sort output by function/method/class name
 -S, --sort-silently            : sort only if the mode supports it, otherwise output unsorted
 -h, --help                     : print usage

"""

import sys, getopt
from special_items.exceptions import *
from special_items import EntityNav
        
def usage(reason=''):
    """print usage"""
    sys.stdout.flush()
    reason = reason.__str__()
    if reason: sys.stderr.write('ERROR: %s\n' % reason)
    usageMsg = __doc__
    sys.stderr.write(usageMsg)
    return 1
        
def main(argv):
    """runs entity nav from command line
    
    returns exit status
    """
    try:
        opts, args = getopt.getopt(argv, "hsSf:e:E:m:", ["help", "sort", "sort-silently", "file=", "ext=", "ext-from-file=", "mode="])
        entityNav = EntityNav(opts, args)
        return entityNav.outputParsable()
    except getopt.GetoptError, err:
        return usage(err)
    except UsageException, err:
        return usage(err)
    except HandlerException, err:
        return usage(err)
    except SortException, err:
        return usage(err)
    except ParseException, err:
        return usage(err)

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]) or 0)