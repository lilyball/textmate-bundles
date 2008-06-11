#! /usr/bin/perl
# extracts related chars from Mac OS X 10.x's character palette
# and dumps them to STDOUT
# script is coming from Dominic Yu : http://tech.groups.yahoo.com/group/chinese-mac/message/6321

use bytes;

open F, '/System/Library/Components/CharacterPalette.component/'
	. 'Contents/SharedSupport/CharPaletteServer.app/'
	. 'Contents/Frameworks/CharacterPaletteFramework.framework/'
	. 'Versions/A/Resources/CharPaletteRelatedChar.charDict'
							or die "couldn't open charDict file";

print "\xFE\xFF";	#print BOM

undef $/;	# whole-file mode
local $\ = "\0\n";	# always end print with UTF16 newline

for (<F>) {	# put contents of file into $_
	my ($i, %seen);
	while (/\x01(.)rel0/gs) { #progressive, single-line match
		my $nbytes = ord $1;
		die "0 length at line $i" unless $nbytes;
		
		/(.{$nbytes})/gs;
		my $chars = $1;
		next if $seen{$chars};
		$seen{$chars} = 1;
		print $chars;
		print STDERR "processing $i..." unless ++$i % 100;
	}
	print STDERR "found $i unique sets of chars.";
}
close F or die "couldn't close charDict file";