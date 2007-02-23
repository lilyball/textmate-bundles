#!/usr/bin/perl

# (c) 2005 Eric Hsu <textmate@betterfilecabinet.com>

# Produce OPML from Tab-indented standard input
# Just a hack.

# read in line by line.
# Count the number of leading tabs.
# 	If the number is equal to the previous line's indent, end last line with </outline>
#	If it's greater, then it's a child. No additional end for last line (it will get closed up when the tab number decreases).
#	if it's less, then it's a new aunt, so end last with one </outline> for each tab less.

my $firsttab = 1;
my $opml     = "";

while (<>) {
	s/>/&gt;/g;
	s/</&lt;/g;
	s/\"/&quot;/g;
    ($tablead, $text) = /^(\t*)(.*?)$/;
    $tabs = length($tablead);

    if ($firsttab) {
        $firsttab = 0;
		foreach (1..($tabs)) {
			$opml .= $tablead . '<outline text="">';			
		}
    }
    else {
        unless ( $tabs > $lasttab ) {
            foreach ( 0 .. ( $lasttab - $tabs ) ) {
                $opml .= "</outline>\n";
            }
        }
    }

    $opml .= "<outline text=\"$text\">";
    $lasttab = $tabs;
}

foreach (0..$lasttab) {
	$opml .= "</outline>\n";
}

print '<?xml version="1.0" encoding="MACINTOSH"?><opml><body>' . $opml . "</body></opml>\n";
