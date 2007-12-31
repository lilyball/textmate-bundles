use Test::More tests => 200;
use HTML::Template;

use strict;

my $text = q{<TMPL_IF foo>YES<TMPL_ELSE>NO</TMPL_IF>};

my $template = HTML::Template->new(
	scalarref => \$text,
);
$template->param(foo => sub { int(rand(2)) });

# make sure HTML::Template never goes both ways down an if, which it
# used to do because it would re-evaluate the conditional at the else.
# Need to test it many times to be sure since it can guess right.
my $good = 1;
for (1..200) {
    my $r = $template->output;
    ok($r eq 'YES' or $r eq 'NO');
};
