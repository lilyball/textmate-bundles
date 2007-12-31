
use Test::More tests => 1;
use HTML::Template;

my $text = qq{foo};

eval {
	my $template = HTML::Template->new(
		debug => 0,
		scalarref => \$text,
		force_untaint => 1,
	);
};

like($@, qr/perl does not run in taint mode/, 
     "force_untaint does not work without taint mode");
