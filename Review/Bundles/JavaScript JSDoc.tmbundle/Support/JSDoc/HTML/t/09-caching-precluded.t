use strict;
use warnings;
use Test::More 
# qw(no_plan);
tests => 4;

use_ok('HTML::Template');

my ($fh, $template_string, @template_array);
my ($template);
my ($type, $cache_option);

open $fh, 'templates/simple.tmpl' 
    or die "Couldn't open simple.tmpl for reading: $!";
{
    local $/;
    $template_string = <$fh>;
    seek $fh, 0, 0;
}

@template_array = <$fh>;
seek $fh, 0, 0;

test_caching_precluded('scalarref', \$template_string, 'cache');
test_caching_precluded('arrayref', \@template_array, 'double_cache');
test_caching_precluded('filehandle', $fh, 'file_cache');

sub test_caching_precluded {
    my ($type, $source, $cache_option) = @_;
    my ($template);
    eval {
        $template = HTML::Template->new(
            type   => $type,
            source => $source,
            $cache_option => 1,
        );
    };
    like( $@,
      qr/Cannot have caching when template source is not file/,
      "Cannot have caching when template source is not file");
}


=head1 NAME

t/09-caching-precluded.t

=head1 OBJECTIVE

In HTML::Template v2.7, it was in principle possible to pass to the
constructor an option which called for caching even in cases where the
template source was I<not> a file.  

    $template = HTML::Template->new(
        type   => 'scalarref',
        source => \$template_string,
        cache => 1,
    );

The documentation indicated it was
not possible to cache results coming from a filehandle, string or array,
but the module itself did not handle a violation of this rule cleanly.
If you attempted to construct an HTML::Template object such as the
example above, you would get three distinct and confusing error
messages.

Phalanx has modified C<HTML::Template::new()> to preclude the
possibility of any of the six cache options having a
true value if the template source is a filehandle, string or array.  The
constructor now does additional error-checking and, if a violation is
found, the program dies and an appropriate error message is emitted via
C<croak> and analyzed.
 
=cut

__END__

#use lib("./t/testlib");
#use_ok('_Auxiliary', qw{ 
#    test_caching_precluded 
#});

#    my ($warn, $template);
#    local $SIG{__WARN__} = sub {$warn = $_[0]};

#    like( $warn,
#      qr/$cache_option option automatically reset to zero when template source is not file/,
