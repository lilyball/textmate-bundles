#!/usr/bin/perl

# (c) 2005 Eric Hsu <textmate@betterfilecabinet.com>

# Produce HTML lists from Tab-indented standard input
# Just a hack.

# read in line by line.
# Count the number of leading tabs.
#	Start with <ul>. Every line gets wrapped in <li> ... </li>.
#	If there are more leading tabs than last line, then it's a child.
# 		So preface the line with a <ul>. No </ul> (it will get closed up when the tab number decreases).
#	if the tabs are fewer, then it's a new aunt, so end previous line with one </ul> for each tab fewer.

my $FIRST_LINE = 1;
my $html     = "";

while (<>) {

    ( $tablead, $text ) = /^(\t*)(.*?)$/;
    $tabs = length($tablead);

    if ($FIRST_LINE) {
        $FIRST_LINE = 0;
        $html     = "<ul>\n"; # first time through, start the list.
		$FIRST_LINE_TABS=$tabs;
		$FIRST_LIST_ITEM=1;
    }
    elsif ( $tabs < $lasttab ) {
        foreach ( 1 .. ( $lasttab - $tabs ) ) {
            $html .= "</li>\n" . "\t" x ($lasttab-$_). "</ul>\n"; 
			# if the indent is less than the last, 
			# then close up one list level for each tab less
			# by closing the last element, then closing the ul list.
			# That leaves the last <li> containing the ul unclosed,
			# but that's okay. The next pass will close it.
        }
    }
    elsif ( $tabs > $lasttab ) {
        $html .= "\n" . "\t" x $lasttab . "<ul>\n";
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
	$html .= "</li>\n" . "\t" x ($lasttab-$_). "</ul>\n"; 
	# if the indent is less than the last, 
	# then close up one list level for each tab less
}

$html .= "</li>\n</ul>\n";  

print $html;
