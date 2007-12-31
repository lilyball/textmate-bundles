use strict;
use warnings;
use Test::More 
# qw(no_plan);
tests => 5;

BEGIN {
    use_ok('HTML::Template');
}

my ($fh, $template_string, @template_array);
my ($typetemplate, $stemplate, $atemplate, $fhtemplate);
my ($output);

open $fh, 'templates/simple.tmpl' 
    or die "Couldn't open simple.tmpl for reading: $!";
{
    local $/;
    $template_string = <$fh>;
    seek $fh, 0, 0;
}

@template_array = <$fh>;
seek $fh, 0, 0;

# next is same as at t/99-old-test-pl.t line 48
$typetemplate = HTML::Template->new(
     type => 'filename',
     path => 'templates',
     source => 'simple.tmpl',
     debug => 0
);

# next 3 HTML::Template objects are same as above, only testing each 
# variant of the 'type' option
$stemplate = HTML::Template->new(
    type   => 'scalarref',
    source => \$template_string,
    debug  => 0,
);

$atemplate = HTML::Template->new(
    type   => 'arrayref',
    source => \@template_array,
    debug  => 0,
);

$fhtemplate = HTML::Template->new(
    type   => 'filehandle',
    source => $fh,
    debug  => 0,
);

for my $tmpl (
    $typetemplate,
    $stemplate, 
    $atemplate, 
    $fhtemplate, 
) {
    $tmpl->param('ADJECTIVE', 'very');
    $output =  $tmpl->output;
    ok( ($output !~ /ADJECTIVE/ and $tmpl->param('ADJECTIVE') eq 'very'),
        "'type-source' version of constructor functioning properly");
}

=head1 NAME

t/04-type-source.t

=head1 OBJECTIVE

Test the 'type-source' style of constructor C<HTML::Template::new()>.

    $stemplate = HTML::Template->new(
        type   => 'scalarref',
        source => \$template_string,
    );

    $atemplate = HTML::Template->new(
        type   => 'arrayref',
        source => \@template_array,
    );

    $fhtemplate = HTML::Template->new(
        type   => 'filehandle',
        source => $fh,
    );

=cut


