#!/usr/bin/env python

"""
==========================================================================================

TextMate PDB Bundle constants file

This is the constants file used by most python PDB editing functions.
You can change these constants to fit your needs.

PDB bundle version 1.0   Copyright (C) 2009, Marc van Dijk.

==========================================================================================
"""

# Position of ATOM and HETATM data in a PDB line. Start count from 0. Start/End line 
# positions as python list
label_loc		=	[0,6]
atnum_loc		=	[6,12]
atname_loc		=	[12,16]
atalt_loc		=	[16,17]
resname_loc		=	[17,21]
chain_loc		=	[21]
resnum_loc		=	[22,26]
resext_loc		=	[27]
xcoor_loc		=	[30,38]
ycoor_loc		=	[38,46]
zcoor_loc		=	[46,54]
occ_loc			=	[54,60]
b_loc			=	[60,66]
segid_loc		=	[72,75]
elem_loc		=	[76,78]

# Lists of residue names used for renaming nucleic acid one-letter to nucleic acid three
# letter code and vice versa.
NAres3 			= 	['CYT','THY','GUA','ADE','URI','CYT','THY','GUA','ADE','URI','CYT','GUA','ADE']
NAres1 			= 	['C','T','G','A','U','DC','DT','DG','DA','RU','RC','RG','RA']

# Dictionary of amino-acid three-letter to one-letter key/value pairs
AMres3_1		= 	{'ALA':'A','ARG':'R','ASN':'N','ASP':'D','ASX':'B','CYS':'C','GLU':'E','GLN':'Q',
					 'GLX':'Z','GLY':'G','HIS':'H','ILE':'I','LEU':'L','LYS':'K','MET':'M','PHE':'F',
					 'PRO':'P','SER':'S','THR':'T','TRP':'W','TYR':'Y','VAL':'V'}

# Dictionary of average element masses
Mass_table={'H':1.0079,'HE':4.0026,'LI':6.9410,'BE':9.0122,'B':10.8110,'C':12.0110,'N':14.0067,
  			'O':15.9994,'F':18.9984,'NE':20.1797,'NA':22.9898,'MG':24.3050,'AL':26.9815,'SI':28.0855,
  			'P':30.9738,'S':32.0660,'CL':35.4527,'AR':39.9480,'K':39.0983,'CA':40.0780,'SC':44.9559,
  			'TI':47.8800,'V':50.9415,'CR':51.9961,'MN':54.9380,'FE':55.8470,'CO':58.9332,'NI':58.6934,
  			'CU':63.5460,'ZN':65.3900,'GA':69.7230,'GE':72.6100,'AS':74.9216,'SE':78.9600,'BR':79.9040,
  			'KR':83.8000,'RB':85.4678,'SR':87.6200,'Y':88.9059,'ZR':91.2240,'NB':92.9064,'MO':95.9400,
  			'TC':97.9072,'RU':101.0700,'RH':102.9055,'PD':106.4200,'AG':107.8682,'CD':112.4110,
  			'IN':114.8180,'SN':118.7100,'SB':121.7600,'TE':127.6000,'I':126.9045,'XE':131.2900,
  			'CS':132.9054,'BA':137.3270,'LA':138.9055,'CE':140.1150,'PR':140.9076,'ND':144.2400,
  			'PM':144.9127,'SM':150.3600,'EU':151.9650,'GD':157.2500,'TB':158.9253,'DY':162.5000,
			'HO':164.9303,'ER':167.2600,'TM':168.9342,'YB':173.0400,'LU':174.9670,'HF':178.4900,
  			'TA':180.9479,'W':183.8400,'RE':186.2070,'OS':190.2300,'IR':192.2200,'PT':195.0800,			
			'AU':196.9665,'HG':200.5900,'TL':204.3833,'PB':207.2000,'BI':208.9804,'PO':208.9824,
  			'AT':209.9871,'RN':222.0176,'FR':223.0197,'RA':226.0254,'AC':227.0278,'TH':232.0381,
  			'PA':231.0359,'U':238.0289,'NP':237.0480,'PU':244.0642,'AM':243.0614,'CM':247.0703,
  			'BK':247.0703,'CF':251.0796,'ES':252.0830,'FM':257.0951,'MD':258.1000,'NO':259.1009,
  			'LR':262.1100,}
