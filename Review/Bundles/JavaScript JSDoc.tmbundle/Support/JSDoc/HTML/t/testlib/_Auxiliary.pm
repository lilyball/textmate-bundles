package _Auxiliary;
# Contains auxiliary subroutines for testing of HTML::Template.
# As of:  Sat May 14 09:59:29 EDT 2005
use strict;
require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
    _setup_array_fh 
    capture_template
    get_cache_key 
); 
our %EXPORT_TAGS = ();

=head1 NAME

_Auxiliary - Miscellaneous subroutines used in HTML::Template test suite

=head1 DESCRIPTION

=head2 GENERAL

The subroutines contained herein are used at various places in the
HTML::Template test suite.  Each is exported on demand only; there are
no export tags permitting export of groups of these subroutines.  In
certain cases they exist only to eliminate duplicated code.  In other
cases they serve as wrappers around small functionalities drawn from
other modules such as HTML::Template itself or IO::Capture::Stderr.

=head2 C<_setup_array_fh>

    ($fh, $template_string, $template_array_ref) = 
        _setup_array_fh('/path/to/some/file');

Reads the file specified by the argument and returns a list consisting
of a filehandle, a string and a reference to an array, each of which are
used to create dummy templates for testing in the cases where
HTML::Template gets its source material from a filehandle, string or
array, respectively.  Currently used in F<t/07-constructor-1.t>.

=cut

sub _setup_array_fh {
    my $file = shift;
    my ($fh, $template_string, @template_array);  
    open $fh, $file or die "Couldn't open $file for reading: $!";
    {
        local $/;
        $template_string = <$fh>;
        seek $fh, 0, 0;
    }

    @template_array = <$fh>;
    seek $fh, 0, 0;
    return ($fh, $template_string, \@template_array); 
}

=head2 C<capture_template>

    $capture = IO::Capture::Stderr->new();

    $template_args_ref = {
        path => ['templates/'],
        filename => 'simple.tmpl',
        cache => 1,
        cache_debug => 1,
    };

    ($template, $cache_load_or_hit) 
        = capture_template($capture, $template_args_ref);

Used in conjunction with IO::Capture::Stderr to prepare for test which
analyze data emitted by HTML::Template to standard error when certain 
debugging options are activated.  Takes a list of two arguments:  an
IO::Capture::Stderr object and a reference to a hash holding the options
to be passed to C<HTML::Template::new()>.  Returns a list of two
arguments:  an HTML::Template object and the (first) string printed to STDERR.
The template can then be further used like any such HTML::Template,
while the string may be tested in comparison with the expected debugging
message.  Currently used in F<t/14-cache-debug.t>.

=cut

sub capture_template {
    my $capture = shift;
    my $template_args_ref = shift;
    $capture->start;
    my $template = HTML::Template->new( %{$template_args_ref});
    $capture->stop;
    return ($template, $capture->read);
}

=head2 C<get_cache_key>

    ($template, $cache_load_or hit) = 
        capture_template($capture, $template_args_ref);
    $cache_keys[0] = get_cache_key($cache_load_or_hit); 

Used to extract information from debugging messages for further testing.
Takes a single argument of a string which is the STDERR message captured
by IO::Capture::Stderr inside C<capture_template()> above.  Returns the
last Perl 'word' in that string.  Why the I<last> word?  Because that's
where the cache key or cache file name currently appears in the error
messages for those features in HTML::Template.  Currently used in
F<t/14-cache-debug.t>.

=cut

sub get_cache_key {
    my @temp = split(/\s+/, +shift);
    return $temp[-1];
}

1;

