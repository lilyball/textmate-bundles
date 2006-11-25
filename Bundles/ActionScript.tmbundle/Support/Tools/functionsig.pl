#!/usr/bin/perl

my $HELPDIR = $ENV{"TM_FLASH_HELP"};
my $HELPTOC = "help_toc.xml";
my $WORD = $ENV{"TM_CURRENT_WORD"};
my %RESULTS;

$WORD =~ s/[()]//g;

open(IN, '<', "$HELPDIR/$HELPTOC") || die "Please find your Actionscript Dictionary folder in your flash installation\nand set TM_FLASH_HELP in your TextMate preferences to its path. e.g.\n/Applications/Macromedia Flash MX 2004/First Run/HelpPanel/Help/ActionScriptDictionary\n\n";

INDEX: while(<IN>)
{
	if (m#href="([^"]+)"\s+name="([^"]+)"#)
	{
		my $url = $1;
		my $term = $2;
		if ($term =~ /($WORD)/i)
		{
			if ($term)
			{
				open(IN2, '<', "$HELPDIR/$url") || die "read error in $HELPDIR/$url";
				my @lines = <IN2>;
				my $helpcontents = join("",@lines);
				$helpcontents =~ m|Parameters</h4>(.+?)<h4>|s;
				$_ = $1;
				s|[\r\n]||g;
				s|<p>|\n|g;
				s|<.+?>||g;
				print $term . $_;
				close(IN2);
				last INDEX;
			}
		}
	}
}
close IN;