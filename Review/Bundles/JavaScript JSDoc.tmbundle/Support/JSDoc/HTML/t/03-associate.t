use strict;
use warnings;
use Test::More 
# qw(no_plan)
tests => 7;

BEGIN {
    use_ok('HTML::Template');
    use_ok('CGI', qw(:html3));
}

my ($template, $q, %options);

# test a simple template
$template = HTML::Template->new(
                                   path => 'templates',
                                   filename => 'simple.tmpl',
                                   debug => 0
                                  );
can_ok('HTML::Template', qw(associateCGI));
isa_ok($template, 'HTML::Template');
$q = CGI->new();
isa_ok($q, 'CGI');

$template->associateCGI($q);
%options = map { $_, 1 } keys(%{$template->{options}});
ok($options{associate}, "associate option exists in HTML::Template object");

eval { $template->associateCGI( [ 1..10 ] ); };
like ($@, qr/Warning! non-CGI object was passed to HTML::Template::associateCGI/, "non-CGI object detected as incorrectly passed to associateCGI()");

=head1 NAME

t/03-associate.t

=head1 OBJECTIVE

Test previously untested method C<HTML::Template::associateCGI()>.

=cut

