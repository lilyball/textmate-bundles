use strict;
use warnings;
use Test::More 
# qw(no_plan);
tests => 7;

use_ok('HTML::Template');
use_ok('File::Copy');

my ($output, $template);
# test cache - non automated, requires turning on debug watching STDERR!
$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                blind_cache => 1,
                                #cache_debug => 1,
                                debug => 0,
                               );
$template->param(ADJECTIVE => sub { return 'v' . '1e' . '2r' . '3y'; });
$output =  $template->output;

sleep 1;

ok( copy('templates/simple.tmpl', 'templates/notsosimple.tmpl'),
	"stored simple.tmpl for later restoration");

ok( copy('templates/simplemod.tmpl', 'templates/simple.tmpl'),
	"poured new content into simple.tmpl to test blind_cache");

$template = HTML::Template->new(
                                path => ['templates/'],
                                filename => 'simple.tmpl',
                                blind_cache => 1,
                                #cache_debug => 1,
                                debug => 0,
                               );
ok($output =~ /v1e2r3y/, "output unchanged as expected");

ok( copy('templates/notsosimple.tmpl', 'templates/simple.tmpl'),
	"able to restore original content of simple.tmpl");
ok( unlink('templates/notsosimple.tmpl'),
	"able to unlink temporary file");

=head1 NAME

t/05-blind-cache.t

=head1 OBJECTIVE

Test the previously untested C<blind_cache> option to constructor 
C<HTML::Template::new()>.

    $template = HTML::Template->new(
        path => ['templates/'],
        filename => 'simple.tmpl',
        blind_cache => 1,
    );

=cut

