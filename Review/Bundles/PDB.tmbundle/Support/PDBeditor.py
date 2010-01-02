#!/usr/bin/env python

import os, sys, re, copy
from optparse 		import *
from PDBconstants 	import *

def PluginCore(paramdict):
	
	#Joining and splitting
	if paramdict['joinPDB']:
		models = 1; joinstring = ''
		for p in paramdict['joinPDB']:
			pdb = PDBeditor()
			pdb.ReadPDB(fromfile=p.strip("'"))
			joinstring += ("MODEL	%i\n" % models)
			pdb.composePdbString(header=False,footer=True)
			joinstring += pdb.pdbString
			joinstring += ("ENDMDL\n")
			models += 1
		
		joinstring += ("END\n")
		sys.stdout.write(joinstring.strip())
		
	elif paramdict['splitPDB'] and paramdict['filepath']: 
		pdb = PDBeditor()
		pdb.splitPDB(paramdict['splitPDB'],paramdict['filepath'])
	else:
		pdb = PDBeditor()
		pdb.ReadPDB()
		#Calculations
		if paramdict['mass']:pdb.getMass()
		
		#Residue modifications
		if paramdict['NA1to3']: pdb.NAresid1to3()
		if paramdict['NA3to1']: pdb.NAresid3to1()
		if paramdict['reres']: pdb.Reres(paramdict['reres'])
	
		#Segment and chain modifications
		if paramdict['setchainID']: pdb.setChainID(paramdict['setchainID'])
		if paramdict['setsegidID']: pdb.setSegidID(paramdict['setsegidID'])
		if paramdict['xsegchain']: pdb.segToChain()
		if paramdict['chainxseg']: pdb.chainToSeg()
		if paramdict['showSeq']: pdb.showSequence()
	
		if paramdict['reatom']:
			pdb.Reatom(paramdict['reatom'])
			pdb.CorrectConect(paramdict['reatom'])
		
		pdb.composePdbString()
		pdb.writePdbString()

class CommandlineOptionParser:

	def __init__(self):
		
		self.option_dict = {}
		self.CommandlineOptionParser()
	
	def __call__(self):
		
		return self.option_dict	
	
	def CommandlineOptionParser(self):
	
		parser = OptionParser()

		parser.add_option( "-a", "--na1to3", action="store_true", dest="NA1to3", default=False, help="Convert nucleic-acid residues from one-letter to three-letter code")
		parser.add_option( "-b", "--na3to1", action="store_true", dest="NA3to1", default=False, help="Convert nucleic-acid residues from three-letter to one-letter code")
		parser.add_option( "-c", "--setchainid", action="store", dest="setchainID", type="string", help="Convert chain ID")
		parser.add_option( "-s", "--setsegid", action="store", dest="setsegidID", type="string", help="Convert segment ID")
		parser.add_option( "-r", "--reres", action="store", dest="reres", type="int", help="Renumber residues. Options: starting from (number)")
		parser.add_option( "-p", "--reatom", action="store", dest="reatom", type="int", help="Renumber atoms. Options: starting from (number)")
		parser.add_option( "-x", "--xsegchain", action="store_true", dest="xsegchain", default=False, help="Places chain ID to seg ID")
		parser.add_option( "-w", "--chainxseg", action="store_true", dest="chainxseg", default=False, help="Places seg ID to chain ID")
		parser.add_option( "-f", "--showSeq", action="store_true", dest="showSeq", default=False, help="Show sequence")
		parser.add_option( "-j", "--joinPDB", action="callback", callback=self.varargs, dest="joinPDB", help="Join PDBs as ensemble")
		parser.add_option( "-i", "--splitPDB", action="store", dest="splitPDB", help="Split PDB into seperatefiles based on split argument")
		parser.add_option( "-q", "--filepath", action="store", dest="filepath", help="filepath")
		parser.add_option( "-m", "--mass", action="store_true", dest="mass", default=False, help="Calculate molecular mass of structure")
		
		(options, args) = parser.parse_args()
		
		self.option_dict['NA1to3'] = options.NA1to3
		self.option_dict['NA3to1'] = options.NA3to1	
		self.option_dict['setchainID'] = options.setchainID
		self.option_dict['setsegidID'] = options.setsegidID
		self.option_dict['reres'] = options.reres
		self.option_dict['reatom'] = options.reatom
		self.option_dict['xsegchain'] = options.xsegchain
		self.option_dict['chainxseg'] = options.chainxseg
		self.option_dict['showSeq'] = options.showSeq
		self.option_dict['joinPDB'] = options.joinPDB
		self.option_dict['splitPDB'] = options.splitPDB
		self.option_dict['filepath'] = options.filepath
		self.option_dict['mass'] = options.mass
		
		return self.option_dict

	def varargs(self, option, opt_str, value, parser):

		"""Deals with variable list of command line arguments"""

		value = []
		rargs = parser.rargs
		while rargs:
		    arg = rargs[0]

		    if ((arg[:2] == "--" and len(arg) > 2) or
        		(arg[:1] == "-" and len(arg) > 1 and arg[1] != "-")):
        		break
		    else:
        		value.append(arg)
        		del rargs[0]

		setattr(parser.values, option.dest, value)	

class PDBeditor:
	
	def __init__(self, inputfile=None):
		
		self.linecount = 1; self.firstatnr = 1; self.modelcount = 0
		self.header = []; self.footer = []
		
		self.label = []
		self.atnum = []
		self.elem = []
		self.atname = []
		self.atalt = []
		self.resname = []
		self.chain = []
		self.resnum = []
		self.resext = []
		self.xcoor = []
		self.ycoor = []
		self.zcoor = []
		self.occ = []
		self.b = []
		self.segid = []
		
		self.pdbString = ''
		self.endstring = False	
	
	def ReadPDB(self,fromfile=None):
	
		head = re.compile('^(HEADER|COMPND|REMARK|SEQRES|CRYST1|SCALE|ORIG|TITLE|FORMUL|HELIX|SHEET|DBREF|SEQADV|SOURCE|KEYWDS|EXPDTA|AUTHOR|REVDAT|JRNL)')
  		atom = re.compile('(ATOM|HETATM)')
		ter = re.compile('TER')
		end = re.compile('END')
  		foot = re.compile('(CONECT|MASTER)')
  		model = re.compile('(MODEL|ENDMDL)')

		if fromfile:
			pdbfile = file(fromfile,'r')
			lines = pdbfile.readlines()
			pdbfile.close()
		else:
			lines = sys.stdin.readlines()	

  		for line in lines:
			line = line.strip()
			if head.match(line):
				self.header.append(line)
  			elif atom.match(line):
				self.label.append(self.__processatomline(line,label_loc,name="label"))
				self.atnum.append(self.__processatomline(line,atnum_loc,vtype='int',name='atnum'))
				self.atname.append(self.__processatomline(line,atname_loc,name='atname'))
				self.atalt.append(self.__processatomline(line,atalt_loc,name='atalt'))
				self.resname.append(self.__processatomline(line,resname_loc,name='resname'))
				self.chain.append(self.__processatomline(line,chain_loc,name='chain'))
				self.resnum.append(self.__processatomline(line,resnum_loc,vtype='int',name='resnum'))
				self.resext.append(self.__processatomline(line,resext_loc,name='resext'))	
				self.xcoor.append(self.__processatomline(line,xcoor_loc,vtype='float',name='xcoor'))
				self.ycoor.append(self.__processatomline(line,ycoor_loc,vtype='float',name='ycoor'))
				self.zcoor.append(self.__processatomline(line,zcoor_loc,vtype='float',name='zcoor'))
				self.occ.append(self.__processatomline(line,occ_loc,vtype='float',name='occ'))
				self.b.append(self.__processatomline(line,b_loc,vtype='float',name='b-factor'))
				self.segid.append(self.__processatomline(line,segid_loc,name='segid'))
				self.elem.append(self.__processatomline(line,elem_loc,name='elem'))
				self.linecount += 1	
			elif ter.match(line):
				self.label.append('TER')
				self.__fillWithBlanks()
				self.linecount += 1	
			elif model.match(line):
				self.label.append(self.__processatomline(line,label_loc,name="label"))
				if self.label[self.linecount-1] == 'MODEL': self.modelcount += 1
				self.__fillWithBlanks()
				self.linecount += 1	
  		  	elif foot.match(line):
 				self.footer.append(line)
			elif end.match(line): self.endstring = True	
		
		self.firstatnr = self.atnum[0]	#Need to know original number of first atom for possible CONECT statement correction when renumbering atoms	
  	
	def __fillWithBlanks(self):
		
		self.atnum.append(0); self.atname.append(" "); self.atalt.append(" "); self.resname.append(" "); self.chain.append(" ")
		self.resnum.append(0); self.resext.append(" "); self.xcoor.append(0.00); self.ycoor.append(0.00); self.zcoor.append(0.00)
		self.occ.append(0.00); self.b.append(0.00); self.segid.append(" "); self.elem.append(" ")
		
	def __processatomline(self,line,location,vtype='string',name=None,debug=None):
		
		if len(location) == 1:
			if len(line) < location[0] or len(line[location[0]].strip()) == 0: 
				if debug: print("Line %i: No %s found in line location %i" % (self.linecount,name,location[0]))
				return " "
			else:
				if vtype == 'int': return int(line[location[0]])	
				elif vtype == 'float': return float(line[location[0]])
				else: return line[location[0]].upper()
		else:
			if len(line) < location[0]:
				if debug: print("Line %i: No %s found in line location %i-%i" % (self.linecount,name,location[0],location[1]))
				return " " * (location[1]-location[0])
			elif len(line[location[0]:location[1]].strip()) == 0: 
				if debug: print("Line %i: No %s found in line location %i-%i" % (self.linecount,name,location[0],location[1]))
				return " " * (location[1]-location[0])
			else:
				if vtype == 'int': return int(line[location[0]:location[1]])
				elif vtype == 'float': return float(line[location[0]:location[1]])
				else: return (line[location[0]:location[1]].strip()).upper()	

	def __getResidueElement(self,elem_list):
		
		"""See if element is stored in elem list, if not than use the first character of the residue as element"""			
		
		newlist = []
		for elem in range(len(elem_list)):
			if len(elem_list[elem].strip()): newlist.append(elem_list[elem])
			else: newlist.append(self.resname[elem][0])
		
		return newlist	

	def composePdbString(self,header=True,footer=True):
		
		models = 1
		
		if header == True:
			for line in self.header: self.pdbString += ('%s\n' % line)
		
		for line in range(len(self.label)):
			if self.label[line] == 'MODEL': 
				self.pdbString += ("MODEL	%i\n" % models)
				models += 1
			elif self.label[line] == 'ENDMDL': self.pdbString += ('ENDMDL\n')
			elif self.label[line] == 'TER': self.pdbString += ('TER\n')
			else: self.__writePDBline(line)
			
		if footer == True:
			for line in self.footer: self.pdbString += ('%s\n' % line)
	
	def __writePDBline(self,i):
   
		atname   = '%-3s' % self.atname[i]

		pdbstring = '%-6.6s%5d %4.4s%s%3s %s%4.1d%s   %8.3f%8.3f%8.3f%6.2f%6.2f%7s%5s' % (self.label[i],
					self.atnum[i],atname,self.atalt[i],self.resname[i],self.chain[i],self.resnum[i],self.resext[i],
					self.xcoor[i],self.ycoor[i],self.zcoor[i],self.occ[i],self.b[i],self.segid[i],self.elem[i])   

		self.pdbString += ('%-80.80s\n' % pdbstring)

	def writePdbString(self):
		
		"""Write the newly formed pdb string to standard output. Strip the last newline character from the
		   string to not print a blank line between selection and follow-up lines.
		"""
		
		if self.endstring: self.pdbString += 'END\n'
		sys.stdout.write(self.pdbString.strip())	

	def splitPDB(self,mode,filepath):
		
		"""
		Split ensemble PDB files in seperate PDB files based on MODEL or TER tag
		"""
		lines = sys.stdin.readlines()
		mode = mode.upper()
		
		modelcount = 0
		models = {}
		
		for line in lines:
			line = line.strip()
			if mode in line[0:len(mode)]:
				modelcount += 1
				models[modelcount] = []
			elif modelcount > 0:
				models[modelcount].append(line)	
			else: 
				pass
		
		if not len(models) == 1:
			end = re.compile('ENDMDL')
			for model in models:
				pathsplit = os.path.splitext(filepath)
				outfile  = pathsplit[0]+'_'+str(model)+pathsplit[1]
				out = file(outfile,'w')
				for line in models[model]:
					if end.search(line): 
						out.write('END\n')
						break
					else:
						out.write('%s\n' % line)
				out.close()

	def NAresid1to3(self,debug=None):
		
		"""Rename the nucleic acid one letter code to a three letter code according to the renaming
		   convention in the NAres3 list in PDBconstants.py file.
		"""
		new_resname = []
		
		for resid in self.resname:
			if resid in NAres1: new_resname.append(NAres3[NAres1.index(resid)])
			else: new_resname.append(resid) 
				
		self.resname = new_resname
			
	def NAresid3to1(self):
		
		new_resname = []; RNA = False; DNA = False
	
		if "O2'" in self.atname: RNA = True
		else: DNA = True
		
  		for resid in self.resname:
			if RNA == True and resid in NAres3: new_resname.append("R%s" % (NAres1[NAres3.index(resid)]))
			elif DNA == True and resid in NAres3: new_resname.append("D%s" % (NAres1[NAres3.index(resid)]))
			else: new_resname.append(resid)
	
		if len(new_resname) == len(self.resname): self.resname = new_resname
		else: pass
	
	def AMresid3to1(self,resid):
		
		"""Helper function to convert amino-acid one-letter code to three letter code using the dictionary in
		   the PDBconstants.py file. If no entry in the dictionary return the residue
		"""
		if AMres3_1.has_key(resid): return AMres3_1[resid]
		else: return resid
		
	def setChainID(self,new):
	
		"""Change the chain ID in the current selection to the new value. Only the first character in the new
		   value is used as the chain ID can only be composed out of one character. Numbers are ignored. Letters
		   are converted to upper-case. One white space is treated as blank character.
		"""
		ch = re.compile('[a-z]+', re.IGNORECASE)
		
		if not len(new[0].strip()) or new == '1': self.chain = ([' ']*len(self.chain))
		elif ch.match(new[0]): self.chain = ([new[0].upper()]*len(self.chain))
		
	def setSegidID(self,new):

		"""Change the segid ID in the current selection to the new value. Segment indentifiers can be composed
		   out of more than one character in contrast to the chain indentifier.
		"""
		self.segid = ([new]*len(self.segid))	
		
	def segToChain(self):

		"""Set the chain ID equal to the segment ID. Only use the first character of the segment Id as the
		   chain ID can only be composed outof one character but the segment ID of more than one
		"""
		ch = re.compile('[a-z]+', re.IGNORECASE)
		
		newchain = []
		for segid in self.segid:
			if ch.match(segid[0]): newchain.append(segid[0].upper())
			else: newchain.append(' ')
		
		self.chain = newchain
	
	def chainToSeg(self):

		"""Set the segment ID equal to the chain ID"""
		
		self.segid = self.chain
	
	def getMass(self):
		
		"""Calculate the molecular mass of the selection by summation of the average molecular mass (u) of all elements.
		   Determine elements by looking in the element character location in the PDB. If this is empty set the element
		   by extracting the first element of the atom name
		"""
		mass = 0.0
		
		elems = self.__getResidueElement(self.elem)
		
		for i in elems:
			if Mass_table.has_key(i): mass += Mass_table[i]
		
		print("Number of atoms:%i" % len(elems))
		print("Molecular mass: %1.3f g/mol" % mass)	
		sys.exit()
	
	def Reres(self, start):
		
		"""Renumber residues starting from the user defined start number. Residues will be renumbered with every 
		   encounter of a new residue name, residue number or chain ID. If more models are encountered the renumbering
		   process will be repeated for every model.
		"""
		rescount = 0
		nextres = copy.copy(start)
		
		for i in range(len(self.label)):
			if self.label[i] == 'ATOM' and rescount == 0:
				rescount += 1 						      
				lastchain = self.chain[i]       		     
				lastresname = self.resname[i]   		     
				lastresnum = self.resnum[i]
				self.resnum[i] = nextres
			elif self.label[i] == 'ATOM' and rescount > 0:
				if (self.chain[i] != lastchain or lastresnum != self.resnum[i] or lastresname != self.resname[i]):						      
					rescount += 1; nextres += 1
					lastchain = self.chain[i] 				      
					lastresname = self.resname[i]				      
					lastresnum = self.resnum[i]				      
					self.resnum[i] = nextres				      
				else:
					self.resnum[i] = nextres
			elif self.label[i] == 'MODEL' or self.label[i] == 'ENDMDL':
				nextres = copy.copy(start)
				rescount = 0
			else: pass							      

	def Reatom(self, start):
	
		"""Renumber atom and hetro-atom numbers starting from the user defined start number. If more models are 
		   encountered the renumbering process will be repeated for every model.
		"""
		nextatnum = copy.copy(start)
		
		for i in range(len(self.label)):
			if self.label[i] == 'ATOM' or self.label[i] == 'HETATM':
				self.atnum[i] = nextatnum
				nextatnum += 1
			elif self.label[i] == 'MODEL' or self.label[i] == 'ENDMDL':
				nextatnum = copy.copy(start)
			else: pass
	
	def CorrectConect(self,number):
		
		"""
		Correct the CONECT statement when renumbering atoms.
		"""
		
		diff = number-self.firstatnr
		correctconect = []
	
		for line in self.footer:
			p = line.split()
			if p[0] == 'CONECT':	
				for atomnr in xrange(1,len(p)):
					p[atomnr] = int(p[atomnr])+diff
				correct = "CONECT"
				for n in p[1:]:
					correct = correct+("%5i" % n)
				correctconect.append(correct)
			else:
				correctconect.append(line)	
			
		self.footer = correctconect
	
	def showSequence(self):
		
		"""Export the protein and/or nucleic acid sequence. In case of protein the residues are converted to
		   one-letter code. The code cyles through all residue names, numbers and chains and pulls out unique
		   residues based on the residue number. It groups them in lists of 20 long for every chain. 
		   Finally it prints for every chain a series of 20 residues per line. Each line starts and ends with
		   the residue number belonging to the first and last residue of that line.
		"""
		chainresname = {}; chainresnum = {}
		resnamelist = []; resnumlist = []
		
		curchain = self.chain[0]; curresnam = self.resname[0]; curresnr = self.resnum[0]
		resnamelist.append(self.AMresid3to1(curresnam)); resnumlist.append(curresnr)
		
		for n in range(len(self.resnum)):
			chain = self.chain[n].strip(); resnum = self.resnum[n]; resname = self.resname[n].strip()
			if len(chain) and resnum and len(resname):
				if not chainresname.has_key(chain): 
					chainresname[chain] = []; chainresnum[chain] = []
				if len(resnamelist) == 20:
					chainresname[curchain].append(resnamelist); chainresnum[curchain].append(resnumlist) 
					resnamelist = []; resnumlist = []
					if not resnum == curresnr: 
						resnamelist.append(self.AMresid3to1(resname)); resnumlist.append(resnum)
						curchain = chain; curresname = resname; curresnr = resnum
				else:
					if not chain == curchain and not resnum == curresnr:
						if len(resnumlist): chainresname[curchain].append(resnamelist); chainresnum[curchain].append(resnumlist) 
						resnamelist = []; resnumlist = []
						resnamelist.append(self.AMresid3to1(resname)); resnumlist.append(resnum)
						curchain = chain; curresname = resname; curresnr = resnum
					elif not resnum == curresnr: 
						resnamelist.append(self.AMresid3to1(resname)); resnumlist.append(resnum)
						curchain = chain; curresname = resname; curresnr = resnum
								
		if len(resnumlist): chainresname[curchain].append(resnamelist); chainresnum[curchain].append(resnumlist)
		
		for chain in chainresname:
			print("\nChain %s" % chain)
			for res in range(len(chainresname[chain])):
				print("%5i  %s  %i" % (chainresnum[chain][res][0]," ".join(chainresname[chain][res]),chainresnum[chain][res][-1]))		
		
		sys.exit()
						
if __name__ == '__main__':
	
	option_dict = CommandlineOptionParser()
	PluginCore(option_dict())
	sys.exit(0)
