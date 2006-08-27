#!/usr/bin/perl

# (c) 2005, Eric Hsu
# Take a regular expression from the clipboard (no / brackets). Show the matches in the current document and perhaps show a unified diff of the result.
# Quick hack would be always do a replace with nothing, and then to diff the result. This would only catch line changes, unfortunately.

#Instead, let's just do a simple find of all the $1, $2, ... $9, and record their start/end positions. Then we'll insert special fixed-length codes everything. Then we'll go through and insert <div class="m1"> and </div> all around. We'll then make the class CSS cascades so you can see overlap, e.g. ((t{2})(s{3})).


my $bundle = $ENV{'TM_BUNDLE_SUPPORT'};
my $css= $bundle . "/css";

my $regexp = `pbpaste`;
chomp($regexp);
my @text=<DATA>;
$_=join("",@text);

my $results;
my $textpieces;

while (/$regexp/g) {

	# The @- (@LAST_MATCH_START) array holds the offsets of the beginnings of any submatches, 
	#  and @+ (@LAST_MATCH_END) holds the offsets of the ends.
	#  @-[0] is the whole regexp match start.

	my @match_start=@-;
	my @match_end=@+;
	my @match_edges=sort (@match_start, @match_end);

	my $start=0;
	my $piece;
	my $match_no;
	my $end;

# blow up into escaped little pieces between the match edges.
	foreach $end (@match_edges) {
		$piece=substr($_, $start, ($end-$start));
		$piece =~ s/&/&amp;/g; # silly; make sure this comes before the next two.
		$piece =~ s/</&lt;/g;
		$piece =~ s/>/&gt;/g;

		$textpieces{$start}=$piece;
		$start=$end;
	}

	# as a hack, we'll insert a header before line N by making a hash entry at N-2^{$match_no+1} and a footer at N+2^{$match_no+1}; this way, later matches will be nested within earlier matches. 

	foreach $match_no (0..($#match_start)) {
		$start= shift @match_start;
		$end= shift @match_end;
		$textpieces{$start-(2^($match_no))}= "<div class=\"m$match_no\">";		
		$textpieces{$end+(2^($match_no))}= "</div>";		
	}
}

foreach (sort {$a <=> $b} keys %textpieces) {
	$results .= $textpieces{$_};
}

$regexp =~  s/&/&amp;/g; 
$regexp =~  s/</&lt;/g;
$regexp =~  s/>/&gt;/g;

print <<END;
<html><head>
<link rel="stylesheet" type="text/css" href="file://$css/regexp.css" />
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"></head><body>
<h3>Results for $regexp</h3>
<tt>$results</tt>
</head><body>
END

__DATA__
# BibTeX files have a default view of citation with raw bibtex appended.
# You can just ask for the citation. 


