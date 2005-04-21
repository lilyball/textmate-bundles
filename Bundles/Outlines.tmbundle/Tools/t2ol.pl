#!/usr/bin/perl

# (c) 2005 Eric Hsu <textmate@betterfilecabinet.com>

# Produce ordered HTML lists from Tab-indented standard input
# Just a hack.

# Based on t2h.pl

my $FIRST_LINE = 1;
my $html     = "";
my @type = (1,a,i,A,I,1,a,i,A,I,1,a,i,A,I,1,a,i,A,I); # first level uses type=1, second uses type=1, etc.

while (<>) {

    ( $tablead, $text ) = /^(\t*)(.*?)$/;
    $tabs = length($tablead);

    if ($FIRST_LINE) {
	    $FIRST_LINE_TABS=$tabs;
        $FIRST_LINE = 0;
        $html     = "<ol type=" . $type[$tabs-$FIRST_LINE_TABS] . ">\n"; 
		# first time through, start the list.
		$FIRST_LIST_ITEM=1;
    }
    elsif ( $tabs < $lasttab ) {
        foreach ( 1 .. ( $lasttab - $tabs ) ) {
            $html .= "</li>\n" . "\t" x ($lasttab-$_). "</ol>\n"; 
			# if the indent is less than the last, 
			# then close up one list level for each tab less
			# by closing the last element, then closing the ul list.
			# That leaves the last <li> containing the ul unclosed,
			# but that's okay. The next pass will close it.
        }
    }
    elsif ( $tabs > $lasttab ) {
        $html .= "\n" . "\t" x $lasttab . "<ol type=" 
				. $type[$tabs-$FIRST_LINE_TABS] . ">\n";
		$FIRST_LIST_ITEM=1;
		
		# if the indent is more, then start a new list.
		# To validate, don't close up the last </li>; we do that in the
		# previous clause when the tabs end. 
    }

	unless ($FIRST_LIST_ITEM) {
		$html .= "</li>\n"; # close the last one unless it's the first in the list
	} else {
		$FIRST_LIST_ITEM=0;
	}
	$html .= "$tablead<li>$text";
    $lasttab = $tabs;

}
# close up all the remaining tabs.

foreach ( 1 .. ( $lasttab - $FIRST_LINE_TABS ) ) {
	$html .= "</li>\n" . "\t" x ($lasttab-$_). "</ol>\n"; 
	# if the indent is less than the last, 
	# then close up one list level for each tab less
}

$html .= "</li>\n</ol>\n";  

print $html;

