use strict;
use Test::More 
tests => 12;
# qw(no_plan);

use_ok('HTML::Template');
use lib("./t/testlib");
use_ok('IO::Capture::Stderr');
use_ok('_Auxiliary', qw{ 
    capture_template
    get_cache_key 
});

my ($output, $template);
my ($capture, $cache_load, $cache_hit, $template_args_ref);
my (@cache_keys);

## Reformulation of Sam's t/99 (line 422+) '
## with cache_debug => 1 uncommented 
## and STDERR captured and analyzed with IO::Capture::Stderr

$capture = IO::Capture::Stderr->new();
isa_ok($capture, 'IO::Capture::Stderr');

$template_args_ref = {
    path => ['templates/'],
    filename => 'simple.tmpl',
    cache => 1,
    cache_debug => 1,
    debug => 0,
};

($template, $cache_load) = capture_template($capture, $template_args_ref);
like($cache_load,
  qr/### HTML::Template Cache Debug ### CACHE LOAD/,
  "cache_debug CACHE LOAD message printed");
$cache_keys[0] = get_cache_key($cache_load); 

$template->param(ADJECTIVE => sub { return 'v' . '1e' . '2r' . '3y'; });
$output =  $template->output;

($template, $cache_hit) = capture_template($capture, $template_args_ref);
like($cache_hit,
  qr/### HTML::Template Cache Debug ### CACHE HIT/,
  "cache_debug CACHE HIT message printed"); 
$cache_keys[1] = get_cache_key($cache_hit); 
ok($output =~ /v1e2r3y/, "basic test of caching");
is($cache_keys[0], $cache_keys[1], "cache keys match as expected");


## Reformulation of Sam's t/99 (line 532+) '
## with cache_debug => 1 uncommented 
## and STDERR captured and analyzed with IO::Capture::Stderr

$template_args_ref = {
    path => ['templates/'],
    filename => 'simple.tmpl',
    file_cache_dir => './blib/temp_cache_dir',
    file_cache => 1,
    cache_debug => 1,
};

($template, $cache_load) = capture_template($capture, $template_args_ref);
like($cache_load,
  qr/### HTML::Template Cache Debug ### FILE CACHE HIT/,
  "cache_debug FILE CACHE HIT message printed");
$cache_keys[0] = get_cache_key($cache_load); 

$template->param(ADJECTIVE => sub { "3y"; });
$output =  $template->output;

($template, $cache_hit) = capture_template($capture, $template_args_ref);
like($cache_hit,
  qr/### HTML::Template Cache Debug ### FILE CACHE HIT/,
  "cache_debug FILE CACHE HIT message printed");
$cache_keys[1] = get_cache_key($cache_hit); 
ok($output =~ /3y/, "output from file caching is as predicted");
is($cache_keys[0], $cache_keys[1], "cache keys match as expected");

=head1 NAME

t/08-cache-debug.t

=head1 OBJECTIVE

The tests in this file automate testing of the validity of information
printed to STDERR when the C<cache_debug> option to
C<HTML::Template::new()> is turned on.  The versions of these tests in
F<t/99-old-test-pl.t> were "non automated," I<i.e.>, in order to assess
their results, you would have had to turn the option on and visually 
inspect STDERR as the test were displayed on the terminal.  Now the
output is captured with subroutines based on CPAN module
IO::Capture::Stderr.  The relevant packages for that module have been
placed in the F<t/testlib/> subdirectory.

=cut


