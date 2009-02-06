#!/usr/bin/perl -X
#
# written by Hans-Jörg Bibiko - bibiko@eva.mpg.de

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';

while(<>){
	if(m/<key>/){
		chomp;
		s/.*<key>(.*?)<\/key>/$1/;
		$val = <>;
		$val =~ s/.*<.*?>(.*?)<\/.*?>/$1/;
		$val =~ s/&lt;/</g;
		$val =~ s/&gt;/>/g;
		$val =~ s/&amp;/&/g;
		#$val =~ s/\\n.*/\\n/g;
		$val =~ s/\x09/\\t/g;
		$val =~ s/\t/\\\t/g;
		print "$_\t$val";
	}
}
