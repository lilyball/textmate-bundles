#!/usr/bin/perl

# Universal Un/Comment for TextMate. By Eric Hsu <textmate@betterfilecabinet.com>
# v9, December 23rd, 2004

# This is a TextMate command to toggle comment status of selected text
# for arbitrary languages. This is released as Niceware, which is like the Perl Artistic License, except you have to be nice to me when you criticize the code. 

# See README for details

# $markers->{} is a hash of file endings mapped to pairs of begin/end markers. 
$markers = {
	"pl,pm,rb" => ["#",""], 
	"plist,c,css,m+h,cp,cpp,h,p,pas,js,htc,c++,h++" => ["/*","*/","//",""], 
	"java,cc,mm"=>["//","","/*","*/"],
	"html,htm,xml" => ["<!--","-->"], 
	"bib,ltx,tex,ps,eps" => ["%",""],
	"php" => ["#","","/*","*/","<!--","-->","//",""],
	"mli,ml,mll,mly" => ["(*","*)"], 
	"script,adb,ads,sql,ddl,dml" => ["--",""], 
	"f,f77" => ["C ",""], 
	"inf,f90" => ["!",""], 
}; 
$tab=4;
# unroll $markers hash  
while (($k,$v)=each(%$markers)){
	foreach (split(/\s*,\s*/, $k)) { 
		$c{"$_"}=$v; 
	} 
}

$_ = shift @ARGV; 
($type)=/\.([^.]*)$/;
foreach $option (@ARGV) {
	if ($option =~ /^\.(.*)$/) {
		$type= $1;
	}
	$opt->{$option}++;
}

unless ($c{"$type"}) { 
	$type="pl"; 
} 
($start, $finish, @etc)=@{$c{$type}}; 
$isntfirst=0; 

# while (<DATA>) { # for TESTING only
while (<STDIN>) { 
	# slurp in data, and identify the minimal indent 
	push @in, $_; 
	($indent)=/^([ \t]*)/; 
	# $indentmin is our shortest indent so far 
	$indentl=0; 
	foreach $j (1..(length($indent))) { 
		$ch = substr($indent,$j-1,1); 
		
		if ($ch eq " ") { 
			$indentl++; 
		} else { 
			unless ($indentl % $tab) { 
				$indentl += $tab; 
			} else { 
				$indentl += $indentl % $tab; #tab rounds to the next multiple of $ta. 
			} 
		} 
	} 
	unless ($isntfirst) { 
		$indentmin=$indent; 
 		$indentminl=$indentl; 
 		$isntfirst++; 
	} else { 
		if ($indentl < $indentminl || $indent eq "") { 
			$indentmin=$indent; 
			$indentminl=$indentl; 
		} 
	} 
} 
$isntfirst=0; 
foreach (@in) { 
	$lineend="";
	if ($opt->{"toggle"}) {
		$iscomment=$isfirstofpair=$isntfirst=0; 
		# toggle means every line is processed as a first line.
	}
	if (chomp) {
		$lineend="\n";
	}; 
	# passthrough a line if it's all whitespace
	unless (/\S/) {
		unless ($opt->{"comment-whitespace"}) {
			$out .= $_ . "\n"; 
			next; 
		}
	}; 
	# Process the first line; is it a comment or not
    unless ($isntfirst) {
		$isntfirst=1;
		 # is the first line a comment? $iscomment is boolean answer.
		foreach $delimiter (@{$c{"$type"}}) { 
			$isfirstofpair=1-$isfirstofpair; # toggle 'first of pair' flag. 
			
			$delimiterq= quotemeta($delimiter); 
			if ($isfirstofpair) { 
				if (/^\s*$delimiterq/) { 
					$iscomment=1; 
					$start=$delimiter; 
					$startq=$delimiterq; 
				} 
			} elsif ($iscomment) { 
				$finish=$delimiter; 
				$finishq=$delimiterq; 
				# this must be the second delimiter matching the found first delim. 
				last; 
			} 
		} 
	}
	
	if ($opt->{"uncomment"}) {
		$iscomment = 1;
	}
	if ($opt->{"comment"}) {
		$iscomment = 0;
	}
	
	# if it's a comment, uncomment it.
	if ($iscomment) { 
		s/^(\s*)$startq(\ )?/$1/; #strip first comment delimiter 
		s/(\ )?$finishq(\s*)$/$1/; #strip last of comment pair 

	    # Notice we strip the first of the pair we find from the left,  
	    # and the last of the pair we find from the right; no matching testing is done.  
	
		$out .=$_ . $lineend; 
	} else { 
	# if it's not a comment, comment it!
	
		if ($opt->{"first-column"}) {
			$out .=  $start;
			unless ($indentmin) {
				$out .= " ";
			}
			$out .= "$_";
			if ($finish) {
				 $out .= " " . $finish; 
			}
			$out .=   $lineend;  
		} else {
			s/^$indentmin//; # remove the standard indent 
			$out .=  $indentmin . $start . " $_";
			if ($finish) {
				$out .= " " . $finish; # only right pad if there's a right marker
			}
			$out .=   $lineend;  
		}
	} 
} 
 
print $out;
# __DATA__

# Notice we strip the first of the pair we find from the left, 
# and the last of the pair we find from the right; no matching testing is done. 

# $out .=$_ . $lineend; 
