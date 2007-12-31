use strict;
use warnings;
use Test::More 
qw(no_plan);
# tests => 4;
use Data::Dumper;

use_ok('HTML::Template');

my ($template, $output);

# test file cache - non automated, requires turning on debug watching STDERR!
$template = HTML::Template->new(
    path => ['templates/'],
    filename => 'simple.tmpl',
    double_file_cache => 1,
    file_cache_dir => './blib/temp_cache_dir',
);
$template->param(ADJECTIVE => sub { "3y"; });
$output =  $template->output;

$template = HTML::Template->new(
    path => ['templates/'],
    filename => 'simple.tmpl',
    double_file_cache => 1,
    file_cache_dir => './blib/temp_cache_dir',
);

ok($output =~ /3y/, "double_file_cache option provides expected output");

#####
# test below did NOT extend coverage within _init()

$template = HTML::Template->new(
    path => ['templates/'],
    filename => 'simple.tmpl',
    cache => 1,
);
$template->param(
    ADJECTIVE => sub { return 't' . 'i' . '1m' . '2e' .  '3l' . '4y'; });
$output =  $template->output;

$template = HTML::Template->new(
    path => ['templates/'],
    filename => 'simple.tmpl',
    double_file_cache => 1,
    file_cache_dir => './blib/temp_cache_dir',
);
ok($output =~ /ti1m2e3l4y/, "double_file_cache option provides expected output");


=head1 NAME

t/07-double-file-cache.t

=head1 OBJECTIVE

Test the previous untested C<double_file_cache> option to 
C<HTML::Template::new()>.

    $template = HTML::Template->new(
        path => ['templates/'],
        filename => 'simple.tmpl',
        double_file_cache => 1,
        file_cache_dir => './blib/temp_cache_dir',
    );

=cut

__END__

#$output = undef;
#
#$template = HTML::Template->new(
#    path => ['templates/'],
#    filename => 'empty.tmpl',
#    cache => 1,
#);
#$template->param(
##    ADJECTIVE => sub { return undef; });
##    ADJECTIVE => sub { });
##    ADJECTIVE => sub { '' }
#);
# $output =  $template->output;
# print "output:  $output\n";
#defined $template->{param_map} ? print "param_map defined\n" :
#    print "param_map not defined\n";
#defined $template->{parse_stack} ? print "parse_stack defined\n" :
#    print "parse_stack not defined\n";
#print Dumper $template;
#
#$template = HTML::Template->new(
#    path => ['templates/'],
#    filename => 'simple.tmpl',
#    double_file_cache => 1,
#    file_cache_dir => './blib/temp_cache_dir',
#);
#ok($output eq '', "double_file_cache option provides expected output");
## ok(! defined $output, "double_file_cache option provides expected output");
