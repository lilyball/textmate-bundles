#!/usr/bin/env python
# @author kumar.mcmillan/gmail.com

"""
Entitynav: Outputs a parsable list of functional entities for the given code file
Usage:	entitynav -f <filename>
        entitynav -f - -e <extension/type>
        entitynav -f - -E <filename>

 -f, --file <filename>|-        : parse <filename> or stdin if `-'
 -e, --ext <ext>                : set extension/type as <ext> when stdin
 -E, --ext-from-file <filename> : set extension/type to that of <filename>
 -h, --help                     : print usage

"""

import sys, os, re, string, getopt
		
def usage(reason=''):
    """
    print usage
    """
    sys.stdout.flush()
    if reason: sys.stderr.write('ERROR: %s\n' % reason)
    usageMsg = string.lstrip(__doc__)
    sys.stderr.write(usageMsg)
    sys.exit(1)
	
def getHandler(ext):
	"""
	gets an entity-matching handler based on filename extension
	"""
	classSuffix = ext.capitalize()
	
	try:
		handler = globals()["Entities" + classSuffix]
	except KeyError:
		raise HandlerError, "no handler for extension '%s'" % ext
		
	return handler()
		
class EntitiesPhp:
	"""
	entity-matching handler for .php files
	"""
	def __init__(self):
		self.entityMatchLine = re.compile(r'^\s*(final|abstract|public|private|protected|function|class|interface)\s+[&a-zA-Z0-9_]+.*$')
		
class EntitiesInc(EntitiesPhp): pass
		
class EntitiesPy:
	"""
	entity-matching handler for .py files
	"""
	def __init__(self):
		self.entityMatchLine = re.compile(r'^\s*(class|def)\b.*:\s*$')

class EntityNav:
	"""
	Produces a parsable entity-navigation of a code file (designed for TextMate's command window)
	"""
	def __init__(self, opts, args):
		self.parseInput(opts, args)
		self.handler = getHandler(self.ext)
		self.constructFileDict(self.file)
		
	def constructFileDict(self, file):
		fileLines = range(1, len(file) + 1)
		self.fileDict = dict(zip(fileLines, file))
		
	def findEntities(self):
		self.entities = {}
		for lineNum,line in self.fileDict.iteritems():
			if self.handler.entityMatchLine.match(line):
				self.entities[lineNum] = line
			
	def outputParsable(self):
		"""
		outputs a lineNum:line entity list
		"""
		self.findEntities()
		sys.stdout.write( "".join( ["%s:%s" % (k,v) for k,v in self.splice(self.entities)] ))
			
	def parseFile(self, filename):
		if filename == '-':
			return self.parseStdin()
		try:
			self.file = open(filename).readlines()
		except IOError:
			raise ParseError("could not open file '%s' for reading" % filename)
			
		self.setExtFromFilename(filename)
		
	def parseInput(self, opts, args):
		file = None
		for opt, arg in opts:
			if opt in ("-h", "--help"):
				raise UsageError
			elif opt in ('-f', '--file'):
				file = arg
			elif opt in ('-e', '--ext'):
				self.ext = arg
			elif opt in ('-E', '--ext-from-file'):
				self.setExtFromFilename(arg)
		if file == None:
			raise UsageError
		self.parseFile(file)
		
	def parseStdin(self):
		self.file = sys.stdin.readlines()
		try:
			self.ext
		except AttributeError:
			raise UsageError("did not receive filename extension")
			
	def setExtFromFilename(self, filename):
		self.ext = filename.split('.')[-1]
	
	def splice(self, entities):
		"""
		splices together the file dictionary so that every line is prefixed with lineNum:
	
		returns a new dictionary
		"""
		keys = entities.keys()
		keys.sort()
		splicedEntities = zip(keys, map(entities.get, keys))
		return splicedEntities
		
class HandlerError(Exception): pass
class ParseError(Exception): pass
class UsageError(Exception): pass
		
def main(argv):
	try:
		opts, args = getopt.getopt(argv, "hf:e:E:", ["help", "file=", "ext=", "ext-from-file="])
		entityNav = EntityNav(opts, args)
		entityNav.outputParsable()
	except getopt.GetoptError, err:
		usage(err.__str__())
	except UsageError, err:
		usage(err.__str__())
	except HandlerError, err:
		usage(err.__str__())
	except ParseError, err:
		usage(err.__str__())
	return 0

if __name__ == '__main__':
	sys.exit(main(sys.argv[1:]) or 0)