use strict;
use Test::More qw(no_plan);
use HTML::Template;

my ($output, $template, $result);

# test escapes with code-refs
$template = HTML::Template->new(path => 'templates',
                                filename => 'escape.tmpl');
$template->param(STUFF => sub { '<>"\'' } ); 
$output = $template->output;
ok($output !~ /[<>"']/); #"
