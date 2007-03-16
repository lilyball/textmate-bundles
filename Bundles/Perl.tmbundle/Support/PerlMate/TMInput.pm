package TMInput;
$VERSION = "0.01";

sub TIEHANDLE { my $class = shift; bless \$class; }

sub READLINE {
	my ($button, $input) = split /\n/, `CocoaDialog inputbox --title "STDIN" \\
										--informative-text "Script is requesting input…" \\
										--button1 "Send"`;
	return "$input\n";
}

tie *STDIN, 'TMInput';