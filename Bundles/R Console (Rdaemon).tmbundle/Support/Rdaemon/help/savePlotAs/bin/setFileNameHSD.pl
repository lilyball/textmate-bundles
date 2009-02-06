#!/usr/bin/perl -X
#
# written by Hans-Jörg Bibiko - bibiko@eva.mpg.de

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

$out_temp = $ENV{'HOME'}."/Rdaemon/help/savePlotAs/bin/icf.plist";

open(DIALOG,"<$out_temp");
binmode DIALOG, ':utf8';

$out="";
$selText = "";
while(<>){ $selText.= $_};

while(<DIALOG>){
	chomp;
	if(m/<key>filename<\/key>/){
		$out .= "$_\n";
		$val = <DIALOG>;
		$val =~ m/(.*?<string>)(.*?)(<\/string>)/g;
		$out .= "$1$ENV$selText$3\n";
	} else {
		$out .= "\t<key>filename</key>\n\t<string>$selText</string>\n" if(m/<\/dict>/);
		$out .= "$_\n";
	}
}

close(DIALOG);
open(OUT,">$out_temp");
binmode OUT, ':utf8';
print OUT $out;
close(OUT);