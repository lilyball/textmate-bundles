#!perl -T

use Test::More tests => 3;
use HTML::Template;
use Scalar::Util qw(tainted);

my $text = qq{ <TMPL_VAR NAME="a"> };

my $template = HTML::Template->new(
	debug => 0,
	scalarref => \$text,
	force_untaint => 1,
);

# We can't manually taint a variable, can we?
# OK, let's use ENV{PATH} - it is usually set and tainted [sn]
ok(tainted($ENV{PATH}), "PATH environment variable must be set and tainted for these tests");

$template->param(a => $ENV{PATH} );
eval {
	$template->output();
};

like($@, qr/tainted value with 'force_untaint' option/, 
     "set tainted value despite option force_untaint");

sub tainter { # coderef that returns a tainted value
	return $ENV{PATH};
}

$template->param(a => \&tainter );
eval {
	$template->output();
};

like($@, qr/'force_untaint' option but coderef returns tainted value/, 
     "coderef returns tainted value despite option force_untaint");
